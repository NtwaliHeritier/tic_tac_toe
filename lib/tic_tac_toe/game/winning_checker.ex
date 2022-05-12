defmodule TicTacToe.Game.WinningChecker do
  @winning_combo [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
    [1, 4, 7],
    [2, 5, 8],
    [3, 6, 9],
    [1, 5, 9],
    [3, 5, 7]
  ]

  def check(game) do
    player = Map.get(game, :player_turn)

    if check_if_won(Map.get(game, player), @winning_combo) == nil do
      game
    else
      %{game | winner: Map.get(game, player)}
    end
  end

  defp check_if_won(_, []), do: nil

  defp check_if_won(player, [winning_combo | t]) do
    if winning_combo -- player.score_combo === [] do
      "won"
    else
      check_if_won(player, t)
    end
  end
end
