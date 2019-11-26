defmodule LastFmWrapper.TrackFetcher do
  alias LastFmWrapper.{Configuration, LastFmTrack, Track, Url}

  @spec fetch_new_tracks(Configuration.t(), DateTime.t()) :: [map]
  def fetch_new_tracks(configuration = %Configuration{}, last_time) do
    total_pages = fetch_total_pages(configuration)

    Enum.map(1..total_pages, fn page_number ->
      fetch_tracks(configuration, page_number)
      |> process_tracks(last_time, configuration)
    end)
  end

  def fetch_all_tracks(configuration = %Configuration{}) do
    total_pages = fetch_total_pages(configuration)
    Enum.map(total_pages..1, fn page_number ->
      fetch_tracks(configuration, page_number)
      |> process_tracks(configuration)
    end)
  end

  def fetch_page(configuration = %Configuration{}, page_number \\ 1) do
    configuration
    |> Url.generate_url(page_number)
    |> LastFmTrack.get!()
  end

  ###############################################

  defp fetch_total_pages(configuration) do
    IO.puts("Fetching total pages...")
    response = fetch_page(configuration, 1)
    total_pages = response.body["recenttracks"]["@attr"]["totalPages"]
    IO.puts("Total pages fetched: #{total_pages}\n")
    total_pages |> String.to_integer()
  end

  defp fetch_tracks(configuration, page_number) do
    IO.puts("Fetching page #{page_number}")
    response = fetch_page(configuration, page_number)

    response.body["recenttracks"]["track"]
  end

  defp process_tracks(tracks, last_time, configuration) do
    tracks
    |> filter_now_playing()
    |> Enum.map(&Track.process_and_append(&1, last_time, configuration))
  end

  defp process_tracks(tracks, configuration) do
    tracks
    |> filter_now_playing()
    |> Enum.map(&Track.process_and_append(&1))
  end


  defp filter_now_playing(tracks) do
    tracks
    |> Enum.reject(fn track -> track["date"]["uts"] == nil end)
  end
end
