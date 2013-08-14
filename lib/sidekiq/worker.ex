defmodule Sidekiq.Worker do
  import :jiffy, only: [encode: 1]
  import :eredis, only: [q: 2]

  @default_queue "default"
  @jid_length 12

  def enqueue(redis, worker, args // [], options // HashDict.new) do
    payload = payload worker, args, options
    json    = encode { payload.to_list }
    q redis, ["LPUSH", queue_key(options[:queue]), json]
  end

  defp payload(worker, args, options) do
    payload_defaults(worker, args, options) |> HashDict.merge(HashDict.new(options))
  end

  defp payload_defaults(worker, args, options) do
    HashDict.new [class: worker, args: args, queue: @default_queue]
  end

  defp queue_key(queue) do
    "queue:#{queue}"
  end
end
