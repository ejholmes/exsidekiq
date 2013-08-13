defmodule Sidekiq.Supervisor do
  use Supervisor.Behaviour

  def start_link(args) do
    :supervisor.start_link(__MODULE__, args)
  end

  def init(args) do
    child_processes = [ worker(Sidekiq.Server, args) ]
    supervise child_processes, strategy: :one_for_one
  end
end
