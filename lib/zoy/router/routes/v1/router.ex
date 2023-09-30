defmodule Zoy.Router.Routes.V1 do
  @moduledoc """
  Routes for /v1
  """

  use Sentry.PlugCapture
  use Plug.Router

  alias Zoy.API
  alias Zoy.Router.Util

  plug :match
  plug :dispatch
  plug Sentry.PlugContext

  plug Corsica,
    origins: "*",
    max_age: 600,
    allow_methods: :all,
    allow_headers: :all

  forward "/health", to: API.Health

  match _ do
    Util.not_found(conn)
  end
end
