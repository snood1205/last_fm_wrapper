defmodule LastFmWrapper.LastFmDateTimeTest do
  use ExUnit.Case, async: false

  test "uts_to_datetime converts a valid uts string into a naive datetime" do
    assert LastFmWrapper.LastFmDateTime.uts_to_datetime("0") == ~N[1970-01-01 00:00:00]
    assert LastFmWrapper.LastFmDateTime.uts_to_datetime("1600000000") == ~N[2020-09-13 12:26:40]
  end

  test "uts_to_datetime errors on invalid input" do
    assert_raise ArgumentError, fn ->
      LastFmWrapper.LastFmDateTime.uts_to_datetime("Invalid Input")
    end
  end
end
