defmodule TicTacToe.Game do
  alias TicTacToe.Manager.{GameSupervisor, GameServer}

  defdelegate new(player), to: GameSupervisor, as: :start_child
  defdelegate get_status(name), to: GameServer
  defdelegate join(game, player), to: GameServer
  defdelegate play(game, player, position), to: GameServer
  defdelegate stop(name), to: GameSupervisor, as: :stop_game
end
