defmodule Zoy.Router.Routes.Socket do
  @moduledoc """
  Router for the gateway
  """

  use Sentry.PlugCapture
  use Plug.Router

  alias Zoy.Router.Util

  plug :match
  plug :dispatch
  plug Sentry.PlugContext

  ## Upgrade to websocket connection
  get "/" do
    conn
    |> WebSockAdapter.upgrade(Zoy.Gateway.Listener, [], max_frame_size: 8192, timeout: 60_000)
    |> halt()
  end

  match _ do
    Util.not_found(conn)
  end
end
