use Mix.Config

config :logger, level: :info

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :logger, Logger.Backends.Telegraf,
  metadata: [:request_id]
