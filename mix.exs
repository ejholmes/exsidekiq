defmodule Sidekiq.Mixfile do
  use Mix.Project

  def project do
    [ app: :exsidekiq,
      version: "0.0.2",
      elixir: ">= 1.2.5",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [ applications: [:eredis, :crypto],
      mod: { Sidekiq, [] },
      registered: [Sidekiq.Server] ]
  end

  # Returns the list of dependencies in the format:
  # { :foobar, "~> 0.1", git: "https://github.com/elixir-lang/foobar.git" }
  defp deps do
    [ { :eredis, github: "wooga/eredis" },
      { :jiffy, github: "davisp/jiffy" } ]
  end
end
