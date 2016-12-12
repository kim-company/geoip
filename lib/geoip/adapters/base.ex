defmodule GeoIP.Adapters.Base do

  defmacro __using__(_opts) do
    quote do
      @behaviour GeoIP.Adapters.Base

      def map(body) do
        Poison.decode!(body, as: %GeoIP.Location{})
      end

      def base_url(), do: "https://freegeoip.net"
      def lookup(host), do: host |> lookup_url |> HTTPoison.get
      defp lookup_url(host), do: "#{base_url}/json/#{host}"

      defoverridable [map: 1, base_url: 0, lookup: 1]
    end
  end

  @callback lookup(any) :: %GeoIP.Location{}

  @doc """
  Returns the struct used to map the raw data retrieven from the groip service
  """
  @callback map(String.t) :: %GeoIP.Location{}

  @doc """
  Returns the base url used to retireve geoip data
  """
  @callback base_url() :: String.t
end