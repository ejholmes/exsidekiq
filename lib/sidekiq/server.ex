defmodule Sidekiq.Server do
  @moduledoc false

  use GenServer

  alias Sidekiq.Worker

  def start_link do
    GenServer.start_link(__MODULE__, [], name: Sidekiq.Server)
  end

  def init(_args) do
    :eredis.start_link
  end

  def handle_call({:enqueue, worker, args, options}, _from, redis) do
    case Worker.enqueue(redis, worker, args, options) do
      {:ok, jobs} -> {:reply, {:ok, jobs}, redis}
      error -> {:error, error, redis}
    end
  end
end
