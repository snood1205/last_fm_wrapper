defmodule LastFmWrapper.Track do
  alias LastFmWrapper.{Database, LastFmDateTime, Printer}

  def process_and_append(track_object, last_time, configuration, db_pid) do
    track_object
    |> construct_track(last_time, configuration, db_pid)
  end

  ###############################################################

  defp construct_track(track_object, last_time, configuration, db_pid) do
    cond do
      LastFmDateTime.uts_to_datetime(track_object["date"]["uts"]) > last_time ->
        track_object
        |> Printer.print(configuration)
        |> Database.insert(db_pid)

      true ->
        nil
    end
  end
end
