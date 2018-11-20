# Since configuration is shared in umbrella projects, this file
# should only configure the :mgmt application itself
# and only for organization purposes. All other config goes to
# the umbrella root.
use Mix.Config

config :mgmt,
  ecto_repos: [Mgmt.Repo]

import_config "#{Mix.env()}.exs"
