defmodule Sidekiq.Server do
  use GenServer.Behaviour

  # ==========
  # Public API
  # ==========

  def start_link do
    :gen_server.start_link({ :local, :sidekiq }, __MODULE__, [], [])
  end

  def enqueue(worker, args) do
    :gen_server.call :sidekiq, { :enqueue, worker, args }
  end

  # ========================
  # GenServer implementation
  # ========================

  def init do
    :eredis.start_link
  end

  def handle_call({ :enqueue, worker, args }, _from, redis) do
    queue = "default"
    json = :jiffy.encode { [queue: queue, class: worker, args: args] }
    #case :eredis.q(redis, ["LPUSH", "queue:#{queue}", json]) do
      #{ :ok, "1" } -> { :reply, :ok, redis }
      #_ -> { :terminate }
    #end
    { :reply, json, redis }
  end
end
