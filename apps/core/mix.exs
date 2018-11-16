defmodule Core.MixProject do
  use Mix.Project

  def project do
    [
      app: :core,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      included_applications: [:vmstats],
      extra_applications: [:logger],
      mod: {Core.Application, start_args(Mix.env())}
    ]
  end

  defp start_args(:test), do: [enable_metrics: false]
  defp start_args(_env), do: [enable_metrics: true]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:vmstats, "~> 2.3"},
      {:statix, "~> 1.1"},
      {:telemetry, "~> 0.2.0"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
      # {:sibling_app_in_umbrella, in_umbrella: true},
    ]
  end
end
