defmodule TicTacToeWeb.PageController do
  use TicTacToeWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
