defmodule LastFmWrapper.RunnerTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  test "with a last_time in the future it should return an array of nils" do
    use_cassette "fetch_nil_tracks" do
      tracks =
        LastFmWrapper.Configuration.load_from_env()
        |> LastFmWrapper.Runner.run(tomorrow())

      assert(
        tracks
        |> List.flatten()
        |> Enum.all?(&(&1 == nil))
      )
    end
  end

  test "with a last_time in the distant past, it should return valid tracks" do
    use_cassette "fetch_all_tracks" do
      LastFmWrapper.Configuration.load_from_env()
      |> LastFmWrapper.Runner.run(~N[1970-01-01 00:00:00])
      |> test_all_tracks()
    end
  end

  test "without a time specified it should fetch all tracks" do
    use_cassette "fetch_all_tracks_without_time" do
      LastFmWrapper.Configuration.load_from_env()
      |> LastFmWrapper.Runner.run()
      |> test_all_tracks()
    end
  end

  test "without any parameters passed it should fetch all tracks" do
    use_cassette "fetch_all_tracks_without_time_or_configuration" do
      LastFmWrapper.Runner.run()
      |> test_all_tracks()
    end
  end

  defp tomorrow do
    DateTime.utc_now()
    |> DateTime.add(60 * 60 * 24, :second)
    |> DateTime.to_unix()
    |> Integer.to_string()
  end

  defp test_all_tracks(all_tracks) do
    # assert that all tracks are not 1D list of tracks
    assert List.flatten(all_tracks) != all_tracks
    assert Enum.count(all_tracks) != 0

    tracks = hd(all_tracks)

    assert Enum.count(tracks) != 0
    assert Enum.all?(tracks, &(&1 != nil))
    track = hd(tracks)
    assert Map.get(track, "name") != nil
    assert Map.get(track, "album") != nil
    assert Map.get(track, "artist") != nil
  end
end
