defmodule LastFmWrapper.LastFmDateTime do
  @epoch :calendar.datetime_to_gregorian_seconds({{1970, 1, 1}, {0, 0, 0}})

  def uts_to_datetime(uts) do
    uts
    |> Kernel.+(@epoch)
    |> :calendar.gregorian_seconds_to_datetime
  end
end
