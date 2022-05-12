defmodule TicTacToe.Manager.GameSupervisorTest do
  use ExUnit.Case, async: true

  alias TicTacToe.Manager.{GameSupervisor, GameServer}
  alias TicTacToe.Game.Player

  setup do
    player1 = Player.new("Ntwali")
    GameSupervisor.start_link([])
    {:ok, %{player1: player1}}
  end

  describe "&start_child/1" do
    test "starts a child process", %{player1: player1} do
      GameSupervisor.start_child(player1)
      game = GameServer.get_status(:"#{player1.name}")
      assert game.player1.name === "Ntwali"

      assert DynamicSupervisor.count_children(GameSupervisor) === %{
               active: 1,
               specs: 1,
               supervisors: 0,
               workers: 1
             }
    end
  end

  describe "&stop_game/1" do
    test "stops a game process", %{player1: player1} do
      GameSupervisor.start_child(player1)
      GameSupervisor.stop_game(player1.name)

      assert DynamicSupervisor.count_children(GameSupervisor) === %{
               active: 0,
               specs: 0,
               supervisors: 0,
               workers: 0
             }
    end
  end
end
