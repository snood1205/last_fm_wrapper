defmodule LastFmWrapper.LastFmDateTime do
  @epoch :calendar.datetime_to_gregorian_seconds({{1970, 1, 1}, {0, 0, 0}})

  @spec uts_to_datetime(String.t()) :: NaiveDateTime.t()
  def uts_to_datetime(uts) do
    uts
    |> String.to_integer()
    |> Kernel.+(@epoch)
    |> :calendar.gregorian_seconds_to_datetime()
    |> NaiveDateTime.from_erl!()
  end
end
