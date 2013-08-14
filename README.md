# Elixir Sidekiq

[![Build Status](https://travis-ci.org/ejholmes/exsidekiq.png)](https://travis-ci.org/ejholmes/exsidekiq)

This a Sidekiq client for the [Elixir](http://elixir-lang.org) language.

## Usage

You can enqueue jobs with `Sidekiq.enqueue`:

```elixir
Sidekiq.enqueue "SomeWorkerClass", ["some", "args"]
#=> { :ok, "1" }

Sidekiq.enqueue "SomeWorkerClass", ["some", "args"], queue: "background", retry: 5
#=> { :ok, "2" }
```
