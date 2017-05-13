defmodule Sidekiq.Supervisor do
  @moduledoc false

  use Supervisor

  def start_link(args) do
    Supervisor.start_link(__MODULE__, args)
  end

  def init(args) do
    children = [worker(Sidekiq.Server, args)]
    supervise(children, strategy: :one_for_one)
  end
end
