defmodule Sidekiq.Server do
  use GenServer.Behaviour

  def start_link do
    :gen_server.start_link({ :local, :sidekiq }, __MODULE__, [], [])
  end

  def init(_args) do
    :eredis.start_link
  end

  def handle_call({ :enqueue, worker, args, options }, _from, redis) do
    enqueue(redis, worker, args, options)
  end

  def handle_call({ :enqueue, worker, args }, _from, redis) do
    enqueue(redis, worker, args)
  end

  defp enqueue(redis, worker, args // [], options // []) do
    queue = Keyword.get(options, :queue, "default")
    json = :jiffy.encode { [queue: queue, class: worker, args: args] }
    case :eredis.q(redis, ["LPUSH", "queue:#{queue}", json]) do
      { :ok, _ } -> { :reply, :ok, redis }
      _ret -> _ret
    end
  end
end
