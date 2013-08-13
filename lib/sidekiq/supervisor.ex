defmodule Sidekiq.Supervisor do
  use Supervisor.Behaviour

  def start_link do
    :supervisor.start_link(__MODULE__, [])
  end

  def init(_args) do
    child_processes = [ worker(Sidekiq.Server, []) ]
    supervise child_processes, strategy: :one_for_one
  end
end
