defmodule Zoy do
  @moduledoc """
  Entry point for the Zoy application.
  """

  use Application

  require Logger

  def start(_type, _args) do
    http_port = Application.get_env(:zoy, :http_port)

    children = [
      # Web server
      {Bandit, plug: Zoy.Router, scheme: :http, port: http_port}
    ]

    opts = [strategy: :one_for_one, name: Zoy.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
