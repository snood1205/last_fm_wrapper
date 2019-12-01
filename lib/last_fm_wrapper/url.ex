defmodule LastFmWrapper.Url do
  alias LastFmWrapper.Configuration

  def generate(params, configuration \\ %Configuration{}, options \\ nil)

  def generate(
        params = %{},
        %Configuration{api_key: api_key, shared_secret: shared_secret},
        :with_signature
      ) do
    params = Map.put(params, :api_key, api_key)
    "?" <> convert_to_query_params(params) <> "&" <> generate_signature(params, shared_secret)
  end

  def generate(params = %{}, %Configuration{api_key: api_key}, nil) do
    params = Map.put(params, :api_key, api_key)
    "?" <> convert_to_query_params(params)
  end

  def generate(params = %{}, %Configuration{}, nil) do
    "?" <> convert_to_query_params(params)
  end

  defp generate_signature(params, secret) do
    signature_input =
      params
      |> Enum.map(fn tuple -> tuple |> Tuple.to_list() |> Enum.join() end)
      |> Enum.sort()
      |> Enum.join()
      |> String.replace("formatjson", "")

    signature =
      :crypto.hash(:md5, signature_input <> secret)
      |> Base.encode16()
      |> String.downcase()

    "api_sig=#{signature}"
  end

  defp convert_to_query_params(params) do
    params
    |> Enum.map(fn {param, value} -> "#{param}=#{value}" end)
    |> Enum.join("&")
  end
end
