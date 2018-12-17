defmodule MgmtWeb.Endpoint.Instrumenter do
  def phoenix_controller_call(:start, _params, state), do: state

  def phoenix_controller_call(:stop, diff, state) do
    metadata = %{
      method: state.conn.method,
      request_path: state.conn.request_path,
      controller: state.conn.private.phoenix_controller,
      action: state.conn.private.phoenix_action
    }

    Telemetry.execute([:mgmt_web, :endpoint, :phoenix_controller_call], diff, metadata)
  end

  def phoenix_controller_render(:start, _params, state), do: state

  def phoenix_controller_render(:stop, diff, state) do
    metadata = Map.take(state, [:format, :template, :view])

    Telemetry.execute([:mgmt_web, :endpoint, :phoenix_controller_render], diff, metadata)
  end
end
