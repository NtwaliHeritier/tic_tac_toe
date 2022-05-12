defmodule TicTacToeWeb.GameLive do
  use TicTacToeWeb, :live_view

  alias TicTacToe.Accounts

  def mount(_params, session, socket) do
    socket = assign(socket, :squares, Enum.to_list(1..9))

    socket =
      assign_new(socket, :current_user, fn ->
        Accounts.get_user_by_session_token(session["user_token"])
      end)

    {:ok, socket}
  end

  def handle_event("click", %{"value" => value}, socket) do
    squares = socket.assigns.squares
    current_user = socket.assigns.current_user

    squares =
      Enum.map(squares, fn square ->
        if String.to_integer(value) == square do
          current_user.email
        else
          square
        end
      end)

    socket = assign(socket, :squares, squares)
    {:noreply, socket}
  end
end
