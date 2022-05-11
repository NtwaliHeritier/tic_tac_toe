defmodule TicTacToe.Manager.GameServerTest do
  use ExUnit.Case

  alias TicTacToe.Manager.GameServer
  alias TicTacToe.Game.{GamePlay, Player}

  setup do
    player1 = Player.new("Heritier", "X")
    player2 = Player.new("Kevin", "O")
    GameServer.start_link(player1: player1, player2: player2)
    {:ok, %{name: :"#{player1.name}_#{player2.name}", player1: player1}}
  end

  describe "&get_status/1" do
    test "returns the state of the game server", %{name: name} do
      assert GameServer.get_status(name) === %GamePlay{
               player1: %Player{key: "X", name: "Heritier", score_combo: []},
               player2: %Player{key: "O", name: "Kevin", score_combo: []},
               player_turn: nil,
               positions_filled: [],
               turns_left: 9,
               winner: nil
             }
    end
  end

  describe "&play/3" do
    test "updates the game struct with the move the player made", %{name: name, player1: player} do
      game = GameServer.play(name, player, 1)
      assert game.player1.score_combo === [1]
    end
  end
end
