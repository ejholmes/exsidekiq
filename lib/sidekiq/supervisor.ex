defmodule Sidekiq.Supervisor do
  @moduledoc false

  use Supervisor

  def start_link(args) do
    Supervisor.start_link(__MODULE__, args)
  end

  def init(args) do
    child_processes = [worker(Sidekiq.Server, args)]
    supervise child_processes, strategy: :one_for_one
  end
end
