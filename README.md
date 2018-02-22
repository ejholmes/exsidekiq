# Elixir Sidekiq

[![Build Status](https://travis-ci.org/ejholmes/exsidekiq.png)](https://travis-ci.org/ejholmes/exsidekiq)

This a [Sidekiq](https://sidekiq.org) client for the [Elixir](https://elixir-lang.org) language.

## Install

Add exsidekiq to your mix.exs dependencies:
```elixir

defp deps do
  [{:exsidekiq, git: "https://github.com/ejholmes/exsidekiq", tag: "v0.0.3"}]
end
```

List exsidekiq as your application dependencies:
``` elixir
def application do
  [applications: [:exsidekiq]]
end
```

## Usage

You can enqueue jobs with `Sidekiq.enqueue`:
```elixir
Sidekiq.enqueue "SomeWorkerClass", ["some", "args"]
#=> { :ok, "1" }

Sidekiq.enqueue "SomeWorkerClass", ["some", "args"], queue: "background", retry: 5
#=> { :ok, "2" }
```
