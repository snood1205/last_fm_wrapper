defmodule LastFmWrapper.LastFmImage do
  @spec extralarge_url([map]) :: map
  def extralarge_url(images) do
    Enum.find(images, fn x -> x["size"] == "extralarge" end)["#text"]
  end
end
