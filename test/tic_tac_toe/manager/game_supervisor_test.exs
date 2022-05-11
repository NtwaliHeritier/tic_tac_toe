defmodule TicTacToe.Manager.GameSupervisorTest do
  use ExUnit.Case, async: true

  alias TicTacToe.Manager.{GameSupervisor, GameServer}
  alias TicTacToe.Game.Player

  setup do
    player1 = Player.new("Ntwali", "X")
    player2 = Player.new("Ishimwe", "O")
    GameSupervisor.start_link([])
    {:ok, %{player1: player1, player2: player2}}
  end

  describe "&start_child/2" do
    test "starts a child process", %{player1: player1, player2: player2} do
      GameSupervisor.start_child(player1, player2)
      game = GameServer.get_status(:"#{player1.name}_#{player2.name}")
      assert game.player1.name === "Ntwali"
    end
  end
end
