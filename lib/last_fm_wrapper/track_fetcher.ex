defmodule LastFmWrapper.TrackFetcher do
  alias LastFmWrapper.{Configuration, Api, Printer, Track, Url}

  @spec fetch_new_tracks(Configuration.t(), NaiveDateTime.t()) :: [map]
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
      |> process_tracks()
    end)
  end

  ###############################################

  defp fetch_total_pages(configuration) do
    Printer.print("Fetching total pages...", configuration)
    response = fetch_page(configuration, 1)
    total_pages = response.body["recenttracks"]["@attr"]["totalPages"]
    Printer.print("Total pages fetched: #{total_pages}\n", configuration)
    total_pages |> String.to_integer()
  end

  defp fetch_tracks(configuration, page_number) do
    Printer.print("Fetching page #{page_number}", configuration)
    response = fetch_page(configuration, page_number)

    response.body["recenttracks"]["track"]
  end

  defp process_tracks(tracks, last_time, configuration) do
    tracks
    |> filter_now_playing()
    |> Enum.map(&Track.process_and_append(&1, last_time, configuration))
  end

  defp process_tracks(tracks) do
    tracks
    |> filter_now_playing()
  end

  defp fetch_page(configuration = %Configuration{username: user}, page_number) do
    configuration
    |> Url.generate(%{
      method: "user.getrecenttracks",
      page: page_number,
      user: user,
      format: :json
    })
    |> Url.as_json()
    |> Api.get!()
  end

  defp filter_now_playing(tracks) do
    tracks
    |> Enum.reject(fn track -> track["date"]["uts"] == nil end)
  end
end
