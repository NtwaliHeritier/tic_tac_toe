defmodule TicTacToeWeb.Support.GameSupport do
  alias TicTacToe.Game.{GamePlay, Player}

  def create_game(_ \\ []) do
    player1 = Player.new("Heritier", "X")
    player2 = Player.new("Kevin", "O")
    game = GamePlay.new_game(player1, player2)
    %{game: game, player1: player1, player2: player2}
  end
end
