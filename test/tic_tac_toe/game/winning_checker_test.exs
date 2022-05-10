defmodule TicTacToe.Game.WinningCheckerTest do
  use ExUnit.Case, async: true

  alias TicTacToe.Game.{WinningChecker, GamePlay, Player}

  setup do
    player1 = Player.new("Heritier", "X")
    player2 = Player.new("Kevin", "O")
    game = GamePlay.new_game(player1, player2)
    {:ok, %{player1: player1, game: game}}
  end

  describe "&check_game/1" do
    test "checks if winning combo is matched", %{game: game, player1: player1} do
      game = GamePlay.play(game, player1, 1)
      assert WinningChecker.check(game) == %GamePlay{winner: nil}
    end
  end
end
