defmodule Zoy.MixProject do
  use Mix.Project

  @app :zoy
  @version "0.1.0"
  @elixir "~> 1.14"

  def project do
    [
      app: @app,
      version: @version,
      elixir: @elixir,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      dialyzer: dialyxir()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Zoy, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:jason, "~> 1.4"},
      {:plug, "~> 1.14"},
      {:bandit, "~> 1.0.0-pre.16"},
      {:websock_adapter, "~> 0.5.4"},
      {:corsica, "~> 2.1"},
      {:dialyxir, "~> 1.3", only: [:dev], runtime: false}
    ]
  end

  defp dialyxir do
    [
      plt_local_path: "priv/plts/project",
      plt_core_path: "priv/plts/core"
    ]
  end
end
