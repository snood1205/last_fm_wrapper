defmodule LastFmWrapper.MixProject do
  use Mix.Project

  def project do
    [
      app: :last_fm_wrapper,
      version: "0.1.0-alpha",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      name: "last.fm Wrapper",
      source_url: "https://github.com/snood1205/last_fm_wrapper"
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:dotenv, "~> 3.0.0"},
      {:httpoison, "~> 1.6"},
      {:poison, "~> 3.1"}
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
end
