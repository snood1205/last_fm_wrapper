defmodule LastFmWrapper.Url do
  alias LastFmWrapper.Configuration

  def generate(params, configuration \\ %Configuration{}, options \\ nil)

  def generate(params = %{}, %Configuration{api_key: api_key}, :with_signature) do
    params = Map.put(params, :api_key, api_key)
    "?" <> convert_to_query_params(params) <>
      "&" <> generate_signature(params)
  end

  def generate(params = %{}, %Configuration{api_key: api_key}, nil) do
    params = Map.put(params, :api_key, api_key)
    "?" <> convert_to_query_params(params)
  end


  def generate_url_with_session_key(
        %Configuration{api_key: api_key, session_key: sk},
        method
      ) do
    start_params(%{
      method: method,
      api_key: api_key,
      api_sig: api_sig,
      sk: sk
    })
  end

  def generate_url(%Configuration{api_key: api_key}, method) do
    start_params(%{
      api_key: api_key,
      method: method
    })
  end

  def start_params(map) do
    join_params("?", map)
  end

  def join_params(params, map) do
    params <> "&" <>
      (map
       |> Enum.map(fn {tag, value} -> "#{tag}=#{value}" end)
       |> Enum.join("&"))
  end

  def as_json(url) do
    cond do
      String.starts_with?(url, "?") -> "#{url}&format=json"
      true -> "#{url}?format=json"
    end
  end

  defp generate_signature(params) do
    signature_input = params
                      |> Enum.map(fn {k, v} -> k <> v end)
                      |> Enum.sort()
                      |> Enum.join()

    :crypto.hash(:md5, signature_input)
    |> Base.encode16()
  end

  defp convert_to_query_params(params) do
    params
    |> Enum.map(fn {param, value} -> "#{param}=#{value}" end)
    |> Enum.join("&")
  end
end
