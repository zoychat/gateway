defmodule Zoy.Gateway.Listener do
  @moduledoc """
  Websocket connection
  """

  require Logger

  def init(_opts) do
    {:ok, []}
  end

  def handle_control({_message, [opcode: :ping]}, state) do
    Logger.debug("Handle ping frame (socket)")
    {:ok, state}
  end

  def handle_in({message, [opcode: :text]}, state) do
    case Jason.decode(message) do
      {:ok, decoded} when is_map(decoded) ->
        match_message(decoded, state)

      _ ->
        invalid_payload_error(state)
    end
  end

  def handle_in(_message, state) do
    {:ok, state}
  end

  def handle_info({:remote_message, message}, state) do
    {:reply, :ok, {:text, message}, state}
  end

  def terminate(_reason, state) do
    {:ok, state}
  end

  ### Internal

  ## Actions for events
  defp match_message(%{"event" => "ping"}, state) do
    Logger.debug("Handle ping event (socket)")
    {:ok, state}
  end

  defp match_message(_message, state) do
    invalid_payload_error(state)
  end

  ## Generate invalid payload response
  defp invalid_payload_error(state) do
    {:stop, :normal, {1002, "invalid_payload"}, state}
  end
end
