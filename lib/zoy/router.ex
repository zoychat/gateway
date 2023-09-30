defmodule Zoy.Router do
  @moduledoc """
  Root router for Zohy web server
  """

  use Plug.Router

  alias Zoy.Router.{Util, Routes}

  plug :match
  plug :dispatch

  get "/" do
    Util.respond(conn, {:ok, "Hello World!"})
  end

  forward "/v1", to: Routes.V1
  forward "/ws", to: Routes.Socket

  match _ do
    Util.not_found(conn)
  end
end
