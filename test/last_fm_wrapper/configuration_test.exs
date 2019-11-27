defmodule LastFmWrapper.ConfigurationTest do
  use ExUnit.Case, async: false

  import Mock

  test "loads from .env" do
    with_mock System,
      get_env: fn env ->
        case env do
          "API_KEY" ->
            "12345ab678b90123c4d5678d901e2f3a"

          "USERNAME" ->
            "sample_last_fm_user"
        end
      end do
      assert LastFmWrapper.Configuration.load_from_env() == %LastFmWrapper.Configuration{
               api_key: "12345ab678b90123c4d5678d901e2f3a",
               username: "sample_last_fm_user"
             }
    end
  end
end
