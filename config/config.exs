# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# By default, the umbrella project as well as each child
# application will require this configuration file, ensuring
# they all use the same configuration. While one could
# configure all applications here, we prefer to delegate
# back to each application for organization purposes.
import_config "../apps/*/config/config.exs"

config :phoenix, :json_library, Jason

case Mix.env() do
  :dev ->
    config :logger, :console, format: "[$level] $message\n"
    # Initialize plugs at runtime for faster development compilation
    config :phoenix, :plug_init_mode, :runtime
    # Set a higher stacktrace during development. Avoid configuring such
    # in production as building large stacktraces may be expensive.
    config :phoenix, :stacktrace_depth, 20

  :test ->
    config :logger, backends: []

  :prod ->
    config :logger, level: :info

    config :logger, :console,
      format: "$time $metadata[$level] $message\n",
      metadata: [:request_id]
end

# Sample configuration (overrides the imported configuration above):
#
#     config :logger, :console,
#       level: :info,
#       format: "$date $time [$level] $metadata$message\n",
#       metadata: [:user_id]
