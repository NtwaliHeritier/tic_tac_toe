defmodule TicTacToe.Game.GamePlayTest do
  use ExUnit.Case, async: true

  alias TicTacToe.Game.{GamePlay, Player}

  setup do
    player1 = Player.new("Heritier", "X")
    player2 = Player.new("Kevin", "O")
    game = GamePlay.new_game(player1, player2)
    {:ok, %{player1: player1, player2: player2, game: game}}
  end

  describe "&new_game/2" do
    test "starts a new game", %{player1: player1, player2: player2} do
      game = GamePlay.new_game(player1, player2)

      assert game === %GamePlay{
               player1: player1,
               player2: player2,
               turns_left: 9,
               winner: nil,
               positions_filled: [],
               player_turn: nil
             }

      assert game.player1.name === "Heritier"
      assert game.player2.name === "Kevin"
    end
  end

  describe "&play/2" do
    test "makes a play move", %{game: game, player1: player1} do
      assert GamePlay.play(game, player1, 1) === %GamePlay{
               player1: %Player{key: "X", name: "Heritier", score_combo: [1]},
               player2: %Player{key: "O", name: "Kevin", score_combo: []},
               player_turn: :player1,
               positions_filled: [1],
               turns_left: 8,
               winner: nil
             }
    end

    test "doesn't allow to overwrite position", %{game: game, player1: player1, player2: player2} do
      game = GamePlay.play(game, player1, 1)

      assert GamePlay.play(game, player2, 1) === %GamePlay{
               player1: %Player{key: "X", name: "Heritier", score_combo: [1]},
               player2: %Player{key: "O", name: "Kevin", score_combo: []},
               player_turn: :player1,
               positions_filled: [1],
               turns_left: 8,
               winner: nil
             }
    end
  end
end