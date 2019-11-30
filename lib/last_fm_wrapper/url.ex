defmodule LastFmWrapper.Url do
  alias LastFmWrapper.Configuration

  def generate(params, configuration \\ %Configuration{}, options \\ nil)

  def generate(params = %{}, %Configuration{api_key: api_key}, :with_signature) do
    params = Map.put(params, :api_key, api_key)
    "?" <> convert_to_query_params(params) <> "&" <> generate_signature(params)
  end

  def generate(params = %{}, %Configuration{api_key: api_key}, nil) do
    params = Map.put(params, :api_key, api_key)
    "?" <> convert_to_query_params(params)
  end

  def generate(params = %{}, %Configuration{}, nil) do
    "?" <> convert_to_query_params(params)
  end

  defp generate_signature(params) do
    signature_input =
      params
      |> Enum.map(fn {k, v} -> k <> v end)
      |> Enum.sort()
      |> Enum.join()

    signature =
      :crypto.hash(:md5, signature_input)
      |> Base.encode16()

    "api_sig=#{signature}"
  end

  defp convert_to_query_params(params) do
    params
    |> Enum.map(fn {param, value} -> "#{param}=#{value}" end)
    |> Enum.join("&")
  end
end
