defmodule LastFmWrapper.MixProject do
  use Mix.Project

  def project do
    [
      app: :last_fm_wrapper,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:dialyxir, "~> 0.5", only: [:dev], runtime: false},
      {:dotenv, "~> 3.0.0"},
      {:httpoison, "~> 1.6"},
      {:poison, "~> 3.1"},
      {:postgrex, "~> 0.15"}
    ]
  end
end
