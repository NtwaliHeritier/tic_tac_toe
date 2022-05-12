defmodule TicTacToe.Manager.GameServer do
  use GenServer
  alias TicTacToe.Game.GamePlay

  def start_link(player: player) do
    GenServer.start_link(__MODULE__, player, name: game_name(player.name))
  end

  def join(name, player) do
    GenServer.call(name, {:join, player})
  end

  def get_status(name) do
    GenServer.call(name, :get_status)
  end

  def play(name, player, position) do
    GenServer.call(name, {:play, player, position})
  end

  def init(player) do
    state = GamePlay.new_game(player)
    {:ok, state}
  end

  def handle_call({:join, player}, _from, state) do
    state = GamePlay.join(state, player)
    {:reply, state, state}
  end

  def handle_call(:get_status, _from, state) do
    {:reply, state, state}
  end

  def handle_call({:play, player, position}, _from, state) do
    state = GamePlay.play(state, player, position)
    {:reply, state, state}
  end

  defp game_name(name), do: :"#{name}"
end
