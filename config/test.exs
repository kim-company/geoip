use Mix.Config

config :geoip,
  adapter: GeoIP.Adapters.Mocks.Default,
  cache_ttl_secs: 3600,
  cache_enabled: true