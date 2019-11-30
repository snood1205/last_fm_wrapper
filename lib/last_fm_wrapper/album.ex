defmodule LastFmWrapper.Album do
  alias LastFmWrapper.{Api, Configuration, Url}

  def add_tags(artist, album, tags, configuration = %Configuration{}) do
    configuration
    |> Url.generate(%{
      method: "album.addTags",
      artist: artist,
      album: album,
      tags: tags,
      format: :json
    }, :with_signature)
    |> Api.post!([])
  end
end
