defmodule TicTacToeWeb.GameLive do
  use TicTacToeWeb, :live_view

  alias TicTacToe.Accounts
  alias TicTacToe.Game.Player
  alias TicTacToe.Game

  def mount(_params, session, socket) do
    current_user = Accounts.get_user_by_session_token(session["user_token"])

    socket = assign(socket, squares: Enum.to_list(1..9), game: nil, player: nil)

    socket = assign_new(socket, :current_user, fn -> current_user end)

    {:ok, socket}
  end

  def handle_event("start_game", _params, socket) do
    name = socket.assigns.current_user.email |> String.split("@") |> Enum.at(0)
    player = Player.new(name)
    Game.new(player)
    game = Game.get_status(String.to_atom(name))
    Phoenix.PubSub.subscribe(TicTacToe.PubSub, game.player1.name)
    {:noreply, assign(socket, game: game, player: player)}
  end

  def handle_event("join_game", %{"game_name" => game_name}, socket) do
    name = socket.assigns.current_user.email |> String.split("@") |> Enum.at(0)
    player = Player.new(name)
    game = game_name |> String.to_atom() |> Game.join(player)
    Phoenix.PubSub.subscribe(TicTacToe.PubSub, game.player1.name)
    {:noreply, assign(socket, game: game, player: player)}
  end

  def handle_event("click", %{"value" => value}, socket) do
    key =
      if(socket.assigns.player.name === socket.assigns.game.player1.name) do
        socket.assigns.game.player1.key
      else
        socket.assigns.game.player2.key
      end

    squares = socket.assigns.squares

    squares =
      Enum.map(squares, fn square ->
        if String.to_integer(value) == square do
          key
        else
          square
        end
      end)

    game_name = socket.assigns.game.player1.name

    game =
      Game.play(
        :"#{String.to_atom(game_name)}",
        socket.assigns.player,
        String.to_integer(value)
      )

    Phoenix.PubSub.broadcast(
      TicTacToe.PubSub,
      game.player1.name,
      {:update, game, squares}
    )

    socket = assign(socket, squares: squares, game: game)
    {:noreply, socket}
  end

  def handle_event("end", _params, socket) do
    if Process.whereis(String.to_atom(socket.assigns.game.player1.name)) do
      Game.stop(socket.assigns.game.player1.name)
    end

    Phoenix.PubSub.unsubscribe(TicTacToe.PubSub, socket.assigns.game.player1.name)
    {:noreply, assign(socket, game: nil, player: nil, squares: Enum.to_list(1..9))}
  end

  def handle_info({:update, game, squares}, socket) do
    socket = assign(socket, game: game, squares: squares)
    {:noreply, socket}
  end
end
