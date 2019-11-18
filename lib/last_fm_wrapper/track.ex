defmodule LastFmWrapper.Track do
  def process_and_append(track_object, last_time) do
    track_object
    |> construct_track()
  end

  ###############################################################

  defp construct_track(_track_object) do
  end
end
