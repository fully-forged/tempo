defmodule Mgmt.Repo do
  use Ecto.Repo,
    otp_app: :mgmt,
    adapter: Ecto.Adapters.Postgres

  def init(_arg, config) do
    new_config =
      config
      |> Keyword.put(:username, Core.Config.get(:postgres_user))
      |> Keyword.put(:password, Core.Config.get(:postgres_password))
      |> Keyword.put(:hostname, Core.Config.get(:postgres_host))

    {:ok, new_config}
  end
end
