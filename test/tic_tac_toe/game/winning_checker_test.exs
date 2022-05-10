defmodule TicTacToe.Game.WinningCheckerTest do
  use ExUnit.Case, async: true

  alias TicTacToe.Game.{WinningChecker, GamePlay, Player}
  import TicTacToeWeb.Support.GameSupport, only: [create_game: 1]

  describe "&check_game/1" do
    setup [:create_game]

    test "checks if winning combo is matched", %{game: game, player1: player1} do
      game = GamePlay.play(game, player1, 1)

      assert WinningChecker.check(game) === %GamePlay{
               player1: %Player{key: "X", name: "Heritier", score_combo: [1]},
               player2: %Player{key: "O", name: "Kevin", score_combo: []},
               player_turn: :player1,
               positions_filled: [1],
               turns_left: 8,
               winner: nil
             }
    end

    test "returns that game is won", %{game: game, player1: player1} do
      game = GamePlay.play(game, player1, 1)
      game = GamePlay.play(game, player1, 2)
      game = GamePlay.play(game, player1, 3)
      assert game.winner === game.player1
    end
  end
end
