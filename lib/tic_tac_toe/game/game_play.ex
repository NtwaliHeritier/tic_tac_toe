defmodule TicTacToe.Game.GamePlay do
  defstruct [:player1, :player2, scores: %{player1: [], player2: []}]

  def new_game(player1, player2) do
    %__MODULE__{player1: player1, player2: player2}
  end
end
