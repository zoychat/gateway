defmodule Zoy.Router do
  @moduledoc """
  Root router for Zohy web server
  """

  use Sentry.PlugCapture
  use Plug.Router

  alias Zoy.Router.{Util, Routes}

  plug :match
  plug :dispatch
  plug Sentry.PlugContext

  get "/" do
    Util.respond(conn, {:ok, "Hello World!"})
  end

  forward "/v1", to: Routes.V1
  forward "/ws", to: Routes.Socket

  match _ do
    Util.not_found(conn)
  end
end
