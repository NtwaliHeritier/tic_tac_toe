defmodule TicTacToe.Manager.GameSupervisor do
  use DynamicSupervisor

  alias TicTacToe.Manager.GameServer

  def start_link(_) do
    DynamicSupervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(_) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_child(player1, player2) do
    spec = {GameServer, player1: player1, player2: player2}
    DynamicSupervisor.start_child(__MODULE__, spec)
  end
end
