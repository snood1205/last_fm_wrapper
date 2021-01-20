defmodule LastFmWrapper.MixProject do
  use Mix.Project

  def project do
    [
      app: :last_fm_wrapper,
      version: "0.1.0-alpha",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      test_coverage: test_coverage(),
      name: "last.fm Wrapper",
      source_url: "https://github.com/snood1205/last_fm_wrapper",
      preferred_cli_env: preferred_cli_env()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:dotenv, "~> 3.1.0"},
      {:httpoison, "~> 1.6"},
      {:poison, "~> 4.0"},
      {:mock, "~> 0.3.0", only: :test},
      {:excoveralls, "~> 0.10", only: :test},
      {:exvcr, "~> 0.10", only: :test}
    ]
  end

  defp description do
    "A wrapper around the last.fm API to make fetching/parsing tracks easier. Still in early development."
  end

  defp package do
    [
      files: ~w(lib test .formatter.exs mix.exs README.md LICENSE),
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/snood1205/last_fm_wrapper"}
    ]
  end

  defp test_coverage do
    [tool: ExCoveralls]
  end

  defp preferred_cli_env do
    [vcr: :test, "vcr.delete": :test, "vcr.check": :test, "vcr.show": :test]
  end
end
