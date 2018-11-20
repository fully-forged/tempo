# Since configuration is shared in umbrella projects, this file
# should only configure the :mgmt_web application itself
# and only for organization purposes. All other config goes to
# the umbrella root.
use Mix.Config

# General application configuration
config :mgmt_web,
  ecto_repos: [Mgmt.Repo],
  generators: [context_app: :mgmt, binary_id: true]

# Configures the endpoint
config :mgmt_web, MgmtWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "sp8iDkKHkhpDfGKJwX5uXaLc8dddC461z0a+XEzNbkatcM3jkgLS+CB+1BQVkwki",
  render_errors: [view: MgmtWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: MgmtWeb.PubSub, adapter: Phoenix.PubSub.PG2]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
