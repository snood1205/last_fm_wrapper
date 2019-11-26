defmodule LastFmWrapper.Track do
  alias LastFmWrapper.{LastFmDateTime, Printer}

  def process_and_append(track_object, last_time, configuration) do
    track_object
    |> construct_track(last_time, configuration)
  end

  ###############################################################

  defp construct_track(track_object, last_time, configuration) do
    cond do
      LastFmDateTime.uts_to_datetime(track_object["date"]["uts"]) > last_time ->
        track_object
        |> Printer.print(configuration)

      true ->
        nil
    end
  end
end
