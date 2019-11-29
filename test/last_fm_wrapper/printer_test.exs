defmodule LastFmWrapper.PrinterTest do
  use ExUnit.Case, async: true

  import ExUnit.CaptureIO

  test "when configured to print, a track should be printed" do
    assert capture_io(fn ->
             configuration = %LastFmWrapper.Configuration{print: true}

             %{artist: "Parquet Court", album: "Wide Awake!", song: "Total Football"}
             |> LastFmWrapper.Printer.print(configuration)
           end) == ~s[%{album: "Wide Awake!", artist: "Parquet Court", song: "Total Football"}\n]
  end

  test "when configured not to print, nothing should be output" do
    assert capture_io(fn ->
             configuration = %LastFmWrapper.Configuration{print: false}

             %{artist: "Parquet Court", album: "Wide Awake!", song: "Total Football"}
             |> LastFmWrapper.Printer.print(configuration)
           end) == ""
  end
end
