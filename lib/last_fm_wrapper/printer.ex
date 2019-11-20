defmodule LastFmWrapper.Printer do
  alias LastFmWrapper.Configuration

  @spec print(map, Configuration.t) :: map
  def print(track, %Configuration{print: true}) do
    track
    |> IO.inspect()
  end

  def print(track, _) do
    track
  end
end
