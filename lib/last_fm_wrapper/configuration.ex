defmodule LastFmWrapper.Configuration do
  alias LastFmWrapper.Configuration

  defstruct(
    api_key: "",
    username: "",
    print: false
  )

  @doc """
  Loads a configuration file from system ENV variables or a local .env file.

  Note: the `api_key` is read in from `$API_KEY` and the `username` is read
  in from `$USERNAME`

  Returns `%LastFmWrapper.Configuration{}` with values loaded from the system variables.

  ## Examples

      iex> LastFmWrapper.Configuration.load_from_env()
      %LastFmWrapper.Configuration{api_key: "12345ab678b90123c4d5678d901e2f3a",
                                   username: "fake_username"}
  """
  @spec load_from_env :: Configuration.t()
  def load_from_env() do
    %Configuration{
      api_key: System.get_env("API_KEY"),
      username: System.get_env("USERNAME")
    }
  end
end
