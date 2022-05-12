defmodule TicTacToe.Main do
  alias TicTacToe.Game.{Player, GamePlay}

  def run do
    player1 = Player.new("hatsor")
    player2 = Player.new("kevin")
    # player3 = Player.new("peace", "x")
    # player4 = Player.new("eddy", "o")
    game = GamePlay.new_game(player1)
    game = GamePlay.join(game, player2)
    game = GamePlay.play(game, player2, 1)
    game = GamePlay.play(game, player2, 2)
    GamePlay.play(game, player1, 3)
  end
end
