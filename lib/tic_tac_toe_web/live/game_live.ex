defmodule TicTacToeWeb.GameLive do
  use TicTacToeWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_event("click", %{"value" => value}, socket) do
    IO.puts("=====================")
    IO.inspect(value)
    {:noreply, socket}
  end
end
