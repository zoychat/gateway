defmodule Zoy.Router.Util do
  @moduledoc """
  Some utils for routers
  """

  import Plug.Conn

  @doc """
  Redirects to a given url
  """
  @spec redirect(Plug.Conn.t(), binary) :: Plug.Conn.t()
  def redirect(conn, url) do
    conn
    |> put_resp_header("location", url)
    |> send_resp(:found, url)
  end

  @spec respond(Plug.Conn.t(), {:ok}) :: Plug.Conn.t()
  def respond(conn, {:ok}) do
    conn
    |> send_resp(204, "")
  end

  @doc """
  Return JSON response with data
  """
  @spec respond(Plug.Conn.t(), {:ok, any}) :: Plug.Conn.t()
  def respond(conn, {:ok, data}) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(%{success: true, data: data}))
  end

  @spec respond(Plug.Conn.t(), {:error, atom, binary}) :: Plug.Conn.t()
  def respond(conn, {:error, code, reason}) do
    respond(conn, {:error, 404, code, reason})
  end

  @spec respond(Plug.Conn.t(), {:error, integer, atom, binary}) :: Plug.Conn.t()
  def respond(conn, {:error, http_code, code, reason}) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(
      http_code,
      Jason.encode!(%{
        success: false,
        error: %{
          code: Atom.to_string(code),
          message: reason
        }
      })
    )
  end

  @spec respond(Plug.Conn.t(), {:error, map}) :: Plug.Conn.t()
  def error(conn, {:error, errors}) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(
      400,
      Jason.encode!(%{
        success: false,
        errors: errors
      })
    )
  end

  @doc """
  Returns a 404 response with a error message informing that the route does not exist
  """
  @spec not_found(Plug.Conn.t()) :: Plug.Conn.t()
  def not_found(conn) do
    respond(conn, {:error, 404, :not_found, "Route does not exist"})
  end
end
