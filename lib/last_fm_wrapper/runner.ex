defmodule LastFmWrapper.Runner do
  alias LastFmWrapper.{Configuration, TrackFetcher}

  @spec run(Configuration.t(), NaiveDateTime.t()) :: [map]
  def run(configuration = %Configuration{}, last_time) do
    TrackFetcher.fetch_new_tracks(configuration, last_time)
  end

  @spec run(Configuration.t()) :: [map]
  def run(configuration = %Configuration{}) do
    configuration
    |> TrackFetcher.fetch_new_tracks(DateTime.from_unix!(0) |> DateTime.to_naive())
  end

  @spec run :: [map]
  def run() do
    Configuration.load_from_env()
    |> TrackFetcher.fetch_new_tracks(DateTime.from_unix!(0) |> DateTime.to_naive())
  end
end
