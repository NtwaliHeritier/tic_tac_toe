defmodule TicTacToe.Manager.GameSupervisor do
  use DynamicSupervisor

  alias TicTacToe.Manager.GameServer

  def start_link(_) do
    DynamicSupervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(_) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_child(player) do
    spec = {GameServer, player: player}
    DynamicSupervisor.start_child(__MODULE__, spec)
  end

  def stop_game(name) do
    pid = name |> String.to_atom() |> Process.whereis()
    DynamicSupervisor.terminate_child(__MODULE__, pid)
  end
end
