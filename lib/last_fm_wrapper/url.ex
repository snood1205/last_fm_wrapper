defmodule LastFmWrapper.Url do
  alias LastFmWrapper.Configuration

  def generate_url(
        %Configuration{api_key: api_key, username: username},
        page_number
      ) do
    "?method=user.getrecenttracks&user=#{username}&api_key=#{api_key}" <>
      "&format=json&page=#{page_number}"
  end
end
