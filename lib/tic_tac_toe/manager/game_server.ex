defmodule TicTacToe.Manager.GameServer do
  use GenServer
  alias TicTacToe.Game.GamePlay

  def start_link(player1: player1, player2: player2) do
    GenServer.start_link(__MODULE__, {player1, player2},
      name: game_name(player1.name, player2.name)
    )
  end

  def get_status(name) do
    GenServer.call(name, :get_status)
  end

  def play(name, player, position) do
    GenServer.call(name, {:play, player, position})
  end

  def init({player1, player2}) do
    state = GamePlay.new_game(player1, player2)
    {:ok, state}
  end

  def handle_call(:get_status, _from, state) do
    {:reply, state, state}
  end

  def handle_call({:play, player, position}, _from, state) do
    state = GamePlay.play(state, player, position)
    {:reply, state, state}
  end

  defp game_name(name1, name2), do: :"#{name1}_#{name2}"
end
