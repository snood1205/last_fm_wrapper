defmodule LastFmWrapper.Configuration do
  alias LastFmWrapper.Configuration

  defstruct(
    api_key: "",
    username: "",
    print: false,
    database_name: "",
    database_username: "",
    database_password: ""
  )

  @spec load_from_env :: Configuration.t
  def load_from_env() do
    %Configuration{
      api_key: System.get_env("API_KEY"),
      username: System.get_env("USERNAME"),
      database_name: System.get_env("DB_NAME"),
      database_username: System.get_env("DB_USER"),
      database_password: System.get_env("DB_PASSWORD")
    }
  end
end
