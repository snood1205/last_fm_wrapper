defmodule LastFmWrapper.Runner do
  alias LastFmWrapper.{Configuration, TrackFetcher}

  def run(configuration = %Configuration{}, last_time) do
    TrackFetcher.fetch_new_tracks(configuration, last_time)
  end

  def run(configuration = %Configuration{}) do
    TrackFetcher.fetch_new_tracks(configuration, ~D[1970-01-01])
  end

  def run() do
    Configuration.load_from_env
    |> TrackFetcher.fetch_new_tracks(~D[1970-01-01])
  end
end
