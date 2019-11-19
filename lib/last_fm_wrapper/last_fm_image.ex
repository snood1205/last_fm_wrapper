defmodule LastFmWrapper.LastFmImage do
  def extralarge_url(images) do
    Enum.find(images, fn x -> x["size"] == "extralarge" end)["#text"]
  end
end
