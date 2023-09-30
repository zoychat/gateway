defmodule Zoy.API.Health do
  @moduledoc """
  Health route
  """

  use Sentry.PlugCapture
  use Plug.Router

  require Logger

  alias Zoy.Router.Util

  plug :match
  plug :dispatch
  plug Sentry.PlugContext

  ## Returns a 200 OK response
  get "/" do
    Logger.info("Health check")
    Util.respond(conn, {:ok, "OK"})
  end

  match _ do
    Util.not_found(conn)
  end
end
