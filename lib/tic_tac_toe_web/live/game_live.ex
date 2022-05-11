defmodule TicTacToeWeb.GameLive do
  use TicTacToeWeb, :live_view

  alias TicTacToe.Accounts

  def mount(_params, session, socket) do
    socket =
      assign_new(socket, :current_user, fn ->
        Accounts.get_user_by_session_token(session["user_token"])
      end)

    {:ok, socket}
  end

  def handle_event("click", %{"value" => value}, socket) do
    IO.puts("=====================")
    IO.inspect(value)
    {:noreply, socket}
  end
end
