defmodule Sidekiq do
  @moduledoc """
  This module provides an interface for enqueueing jobs in Sidekiq.
  """

  use Application.Behaviour

  def start(_type, args // []) do
    Sidekiq.Supervisor.start_link args
  end

  @doc """
  Enqueues a job in sidekiq.

  ## Example

    Sidekiq.enqueue "DoWork", ["hello"], queue: "work"

  """
  def enqueue(worker, args // [], options // HashDict.new) do
    :gen_server.call Sidekiq.Server, { :enqueue, worker, args, options }
  end
end
