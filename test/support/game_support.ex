defmodule TicTacToeWeb.Support.GameSupport do
  alias TicTacToe.Game.{GamePlay, Player}

  def create_game(_ \\ []) do
    player1 = Player.new("Heritier")
    player2 = Player.new("Kevin")
    game = GamePlay.new_game(player1)
    game = GamePlay.join(game, player2)
    %{game: game, player1: player1, player2: player2}
  end
end
