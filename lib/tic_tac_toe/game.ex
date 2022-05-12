defmodule TicTacToe.Game do
  alias TicTacToe.Game.GamePlay

  defdelegate new(player), to: GamePlay, as: :new_game
  defdelegate join(game, player), to: GamePlay
  defdelegate play(game, player, position), to: GamePlay
end
