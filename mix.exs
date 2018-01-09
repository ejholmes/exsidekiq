defmodule Sidekiq.Mixfile do
  use Mix.Project

  def project do
    [app: :exsidekiq, version: "0.0.3", elixir: ">= 1.2.5", deps: deps()]
  end

  def application do
    [applications: [:eredis, :crypto], mod: {Sidekiq, []}, registered: [Sidekiq.Server]]
  end

  defp deps do
    [
      {:eredis, "~> 1.1"},
      {:jiffy, "~> 0.15.0"}
    ]
  end
end
