defmodule Sidekiq.Worker do
  @moduledoc false

  @default_queue "default"

  def enqueue(redis, worker, args \\ [], options \\ Map.new()) do
    Map.new()
    |> add_worker(worker)
    |> add_args(args)
    |> add_options(options)
    |> commit(redis)
  end

  defp add_worker(message, worker_name), do: Map.put(message, :class, worker_name)
  defp add_args(message, args), do: Map.put(message, :args, args)

  defp add_options(message, options) do
    [queue: @default_queue]
    |> Map.new()
    |> Map.merge(message)
    |> Map.merge(Map.new(options))
  end

  defp commit(%{queue: queue} = message, conn) do
    import :jiffy, only: [encode: 1]
    import :eredis, only: [q: 2]

    encoded_message = encode({Map.to_list(message)})
    q(conn, ["LPUSH", "queue:#{queue}", encoded_message])
  end
end
