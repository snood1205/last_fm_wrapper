defmodule LastFmWrapper.LastFmImageTest do
  use ExUnit.Case, async: true

  @images [
    %{
      "size" => "small",
      "#text" => "small_url"
    },
    %{
      "size" => "medium",
      "#text" => "medium_url"
    },
    %{
      "size" => "large",
      "#text" => "large_url"
    },
    %{
      "size" => "extralarge",
      "#text" => "extralarge_url"
    }
  ]

  test "can find the extralarge image from a list of image maps" do
    assert LastFmWrapper.LastFmImage.extralarge_url(@images) == "extralarge_url"
  end

  test "returns nil on input without extralarge size" do
    assert LastFmWrapper.LastFmImage.extralarge_url([]) == nil
  end
end
