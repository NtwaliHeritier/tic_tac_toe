defmodule TicTacToeWeb.GameLive do
  use TicTacToeWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
        <h1>Game</h1>
    <%= for square <- Enum.to_list(1..9) do %>
        <button phx-click="click"><%=square%></button>
        <%= if rem(square, 3) === 0 do %>
            <br>
        <% end %>
    <% end %>
    """
  end

  def handle_event("click", _params, socket) do
    IO.puts("=====================")
    IO.puts("clicked")
    {:noreply, socket}
  end
end
