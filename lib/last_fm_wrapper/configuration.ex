defmodule LastFmWrapper.Configuration do
  alias LastFmWrapper.Configuration

  defstruct(
    api_key:    "",
    username:   ""
  )

  def load_from_env() do
    %Configuration{
      api_key: System.get_env("API_KEY"),
      username: System.get_env("USERNAME")
    }
  end
end
