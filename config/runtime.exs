import Config

config :zoy,
  http_port: System.get_env("HTTP_PORT") || 4000
