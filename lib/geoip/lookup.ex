defmodule GeoIP.Lookup do
  alias GeoIP.{Location, Error}

  def call(nil), do: %Location{}

  def call(%{remote_ip: host}), do: call(host)

  def call(host) when is_tuple(host), do: host |> Tuple.to_list |> Enum.join(".") |> call

  def call("localhost"), do: call("127.0.0.1")

  def call("127.0.0.1" = ip), do: {:ok, %Location{ip: ip}}

  def call(host) do
    case get_from_cache(host) do
      {:ok, location} -> {:ok, location}
      _ ->
        host
        |> adapter.lookup()
        |> parse_response
        |> put_in_cache(host)
    end
  end

  defp get_from_cache(host) do
    if Application.get_env(:geoip, :cache_enabled), do: Cachex.get(:geoip_lookup_cache, host)
  end

  defp put_in_cache({:ok, location} = result, host) do
    if Application.get_env(:geoip, :cache_enabled), do: Cachex.set(:geoip_lookup_cache, host, location)
    result
  end
  defp put_in_cache(result, _), do: result

  defp parse_response({:ok, %HTTPoison.Response{status_code: 200, body: body}}) do
    {:ok, adapter.map(body)}
  end

  defp parse_response({:ok, %HTTPoison.Response{status_code: _, body: body}}) do
    {:error, %Error{reason: body}}
  end

  defp parse_response({:error, %HTTPoison.Error{reason: reason}}) do
    {:error, %Error{reason: reason}}
  end

  defp parse_response(result) do
    {:error, %Error{reason: "Error looking up host: #{inspect(result)}"}}
  end

  defp adapter(), do: Application.get_env(:geoip, :adapter, GeoIP.Adapters.Default)
end
