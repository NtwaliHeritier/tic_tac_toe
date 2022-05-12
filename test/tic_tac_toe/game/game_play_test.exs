defmodule TicTacToe.Game.GamePlayTest do
  use ExUnit.Case, async: true

  alias TicTacToe.Game.{GamePlay, Player}
  import TicTacToeWeb.Support.GameSupport, only: [create_game: 1]

  describe "&new_game/1" do
    setup [:create_game]

    test "starts a new game", %{player1: player} do
      game = GamePlay.new_game(player)
      assert game.player1.name === "Heritier"
      assert game.player1.key === "X"
    end
  end

  describe "&join/2" do
    setup [:create_game]

    test "joins a game", %{player2: player, game: game} do
      game = GamePlay.join(game, player)
      assert game.player2.name === "Kevin"
      assert game.player2.key === "O"
    end
  end

  describe "&play/2" do
    setup [:create_game]

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
