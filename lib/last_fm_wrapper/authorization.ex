defmodule LastFmWrapper.Authorization do
  alias LastFmWrapper.{Api, Configuration, Url}

  def get_session(configuration = %Configuration{token: token}) do
    response =
      %{method: "auth.getsession", token: token, format: :json}
      |> Url.generate(configuration)
      |> Api.get!()

    response
  end

  def get_token(configuration = %Configuration{}) do
    response =
      %{method: "auth.gettoken", format: :json}
      |> Url.generate(configuration)
      |> Api.get!()

    response.body["token"]
  end
end
