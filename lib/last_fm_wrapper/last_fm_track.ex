defmodule LastFmWrapper.LastFmTrack do
  use HTTPoison.Base

  def process_request_url(url) do
    "http://ws.audioscrobbler.com/2.0/" <> url
  end

  def process_response_body(body) do
    body
    |> Poison.decode!
  end
end
