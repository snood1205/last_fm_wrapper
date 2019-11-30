defmodule LastFmWrapper.Authorization do
  alias LastFmWrapper.{Api, Configuration, Url}

  def get_session(configuration = %Configuration{token: token}) do
    response =
      configuration
      |> Url.generate_url("auth.getsession")
      |> Url.join_params(%{token: token})
      |> Url.as_json()
      |> Api.get!()

    response
  end

  def get_token(configuration = %Configuration{}) do
    response =
      configuration
      |> Url.generate_url("auth.gettoken")
      |> Url.as_json()
      |> Api.get!()

    response.body["token"]
  end
end
