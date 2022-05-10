defmodule TicTacToe.Game.PlayerTest do
  use ExUnit.Case, async: true

  alias TicTacToe.Game.Player

  setup do
    {:ok, player: %Player{score_combo: [3], name: "Heritier", key: "X"}}
  end

  describe "test the player module" do
    test "&new/2" do
      assert Player.new("Heritier", "X") === %Player{name: "Heritier", key: "X", score_combo: []}
      refute Player.new("Heriier", "X") === %Player{name: "Heritier", key: "X", score_combo: []}
    end

    test "&update_player_score/2", %{player: player} do
      assert Player.update_player_score(player, 1) === %Player{
               score_combo: [1, 3],
               name: "Heritier",
               key: "X"
             }

      refute Player.update_player_score(player, 1) === %Player{
               score_combo: [3],
               name: "Heritier",
               key: "X"
             }
    end
  end
end
