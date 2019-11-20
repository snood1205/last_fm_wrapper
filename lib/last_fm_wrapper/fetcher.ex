defmodule LastFmWrapper.TrackFetcher do
  alias LastFmWrapper.{Configuration, Database, LastFmTrack, Track, Url}

  @spec fetch_new_tracks(Configuration.t, DateTime.t) :: [map]
  def fetch_new_tracks(configuration = %Configuration{}, last_time) do
    total_pages = fetch_total_pages(configuration) |> String.to_integer()
    IO.puts("Total pages fetched: #{total_pages}\n")

    Enum.map(1..total_pages, fn page_number ->
      fetch_tracks(configuration, page_number)
      |> process_tracks(last_time, configuration)
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

    response.body["recenttracks"]["track"]
  end

  defp process_tracks(tracks, last_time, configuration) do
    db_pid = Database.start(configuration)
    Enum.map(tracks, &Track.process_and_append(&1, last_time, configuration, db_pid))
  end

  defp fetch_page(configuration, page_number) do
    configuration
    |> Url.generate_url(page_number)
    |> LastFmTrack.get!()
  end
end
