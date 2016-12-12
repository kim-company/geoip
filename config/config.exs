# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :geoip,
  adapter: GeoIP.Adapters.Default,
  cache_ttl_secs: 3600,
  cache_enabled: true

import_config "#{Mix.env}.exs"
