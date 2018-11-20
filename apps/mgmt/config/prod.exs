use Mix.Config

config :mgmt, Mgmt.Repo,
  database: "mgmt_prod",
  pool_size: 15
