defmodule TicTacToe.Game.GamePlay do
  defstruct [:player1, :player2, :winner, :player_turn, positions_filled: [], turns_left: 9]

  alias TicTacToe.Game.{Player, WinningChecker}

  def new_game(player) do
    player = Player.assign_key(player, "X")
    %__MODULE__{player1: player}
  end

  def join(game, player) do
    player = Player.assign_key(player, "O")
    %{game | player2: player}
  end

  def play(game, player, position) do
    if(position in game.positions_filled) do
      game
    else
      player
      |> check_player(game)
      |> update_game_score(position)
      |> update_positions_taken(position)
      |> WinningChecker.check()
      |> update_turns_left()
      |> is_game_over?()
    end
  end

  defp check_player(player, game) do
    IO.inspect(game.player1.key)
    IO.inspect(player)

    if game.player1.name == player.name do
      %{game | player_turn: :player1}
    else
      %{game | player_turn: :player2}
    end
  end

  defp update_game_score(game, position) do
    if game.player_turn == :player1 do
      %{game | player1: Player.update_player_score(game.player1, position)}
    else
      %{game | player2: Player.update_player_score(game.player2, position)}
    end
  end

  defp update_positions_taken(game, position) do
    Map.update!(game, :positions_filled, &[position | &1])
  end

  defp update_turns_left(game) do
    Map.update!(game, :turns_left, &(&1 - 1))
  end

  defp is_game_over?(game) do
    cond do
      game.winner !== nil -> game
      game.turns_left == 0 -> "Game over"
      true -> game
    end
  end
end
