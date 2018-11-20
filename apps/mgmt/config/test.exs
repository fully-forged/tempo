use Mix.Config

config :mgmt, Mgmt.Repo,
  database: "mgmt_test",
  pool: Ecto.Adapters.SQL.Sandbox
