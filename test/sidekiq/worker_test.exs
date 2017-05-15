defmodule SidekiqWorkerTest do
  use ExUnit.Case

  setup do
    {:ok, redis} = :eredis.start_link
    {:ok, [redis: redis]}
  end

  test "#enqueue simple", context do
    assert {:ok, _} = Sidekiq.Worker.enqueue context[:redis], "Job"
  end

  test "#enqueue with args", context do
    assert {:ok, _} = Sidekiq.Worker.enqueue context[:redis], "Job", ["some", "args"]
  end

  test "#enqueue with args and options", context do
    assert {:ok, _} = Sidekiq.Worker.enqueue context[:redis], "Job", ["some", "args"], queue: "background"
  end
end
