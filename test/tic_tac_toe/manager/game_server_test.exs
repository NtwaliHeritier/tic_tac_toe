defmodule TicTacToe.Manager.GameServerTest do
  use ExUnit.Case, async: true

  alias TicTacToe.Manager.GameServer
  alias TicTacToe.Game.{GamePlay, Player}

  setup do
    player1 = Player.new("Heritier")
    GameServer.start_link(player: player1)
    {:ok, %{name: :"#{player1.name}", player1: player1}}
  end

  describe "&get_status/1" do
    test "returns the state of the game server", %{name: name} do
      assert GameServer.get_status(name) === %GamePlay{
               player1: %Player{key: "X", name: "Heritier", score_combo: []},
               player2: nil,
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
