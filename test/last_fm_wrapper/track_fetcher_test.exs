defmodule LastFmWrapper.TrackFetcherTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  test "fetch all tracks" do
    use_cassette "fetch_all_tracks_with_fetcher" do
      LastFmWrapper.Configuration.load_from_env()
      |> LastFmWrapper.TrackFetcher.fetch_all_tracks()
      |> test_tracks_structure()
    end
  end

  defp test_tracks_structure(tracks) do
    assert is_list(tracks)
    assert is_list(hd(tracks))
    assert !is_list(hd(hd(tracks)))
  end
end
