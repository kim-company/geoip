defmodule GeoIP.Adapters.Mocks.Default do
  use GeoIP.Adapters.Base

  def lookup(_host) do
    {:ok,
    %HTTPoison.Response{body: "{\"ip\":\"46.234.244.221\",\"country_code\":\"IT\",\"country_name\":\"Italy\",\"region_code\":\"\",\"region_name\":\"\",\"city\":\"\",\"zip_code\":\"\",\"time_zo
ne\":\"Europe/Rome\",\"latitude\":43.1479,\"longitude\":12.1097,\"metro_code\":0}\n",
    headers: [{"Content-Type", "application/json"}, {"Vary", "Origin"},
   {"X-Database-Date", "Thu, 08 Dec 2016 03:29:58 GMT"},
   {"X-Ratelimit-Limit", "10000"}, {"X-Ratelimit-Remaining", "9998"},
   {"X-Ratelimit-Reset", "3495"}, {"Date", "Mon, 12 Dec 2016 14:12:56 GMT"},
   {"Content-Length", "205"}], status_code: 200}}
  end
end
