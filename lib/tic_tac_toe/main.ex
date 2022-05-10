defmodule TicTacToe.Main do
  alias TicTacToe.Game.{Player, GamePlay}

  def run do
    player1 = Player.new("hatsor", "x")
    player2 = Player.new("kevin", "o")
    game = GamePlay.new_game(player1, player2)
    game = GamePlay.play(game, player1, 1)
    game = GamePlay.play(game, player1, 2)
    GamePlay.play(game, player1, 3)
  end
end
