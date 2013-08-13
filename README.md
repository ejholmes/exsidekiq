# Elixir Sidekiq

This a Sidekiq client for the [Elixir](http://elixir-lang.org) language.

## Usage

You can enqueue jobs with `Sidekiq.enqueue`:

```elixir
Sidekiq.enqueue "SomeWorkerClass", ["some", "args"]
#=> :ok

Sidekiq.enqueue "SomeWorkerClass", ["some", "args"], queue: "background", retry: 5
#=> :ok
```
