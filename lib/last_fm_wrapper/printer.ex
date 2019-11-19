defmodule LastFmWrapper.Printer do
  alias LastFmWrapper.Configuration

  def print(track, %Configuration{print: true}) do
    track
    |> IO.inspect
  end

  def print(track, _) do
    track
  end
end
