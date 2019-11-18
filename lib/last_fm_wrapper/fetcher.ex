defmodule LastFmWrapper.TrackFetcher do
  alias LastFmWrapper.{Configuration, LastFmTrack, Track, Url}

  def fetch_new_tracks(configuration = %Configuration{}, last_time) do
    total_pages = fetch_total_pages(configuration) |> String.to_integer()
    IO.puts("Total pages fetched: #{total_pages}\n")

    Enum.each(1..total_pages, fn page_number ->
      fetch_tracks(configuration, page_number)
      |> process_tracks(last_time)
    end)
  end

  ###############################################

  defp fetch_total_pages(configuration) do
    IO.puts("Fetching total pages...")
    response = fetch_page(configuration, 1)
    response.body["recenttracks"]["@attr"]["totalPages"]
  end

  defp fetch_tracks(configuration, page_number) do
    IO.puts("Fetching page #{page_number}")
    response = fetch_page(configuration, page_number)
    response.body["recenttracks"]
  end

  defp process_tracks(tracks, last_time) do
     Enum.each(tracks, fn track -> Track.process_and_append(track, last_time) end)
  end

  defp fetch_page(configuration, page_number) do
    configuration
    |> Url.generate_url(page_number)
    |> LastFmTrack.get!()
  end
end
