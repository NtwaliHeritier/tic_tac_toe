defmodule TicTacToeWeb.GameLiveTest do
  use TicTacToeWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  alias TicTacToe.Accounts

  test "Redirect when not logged in", %{conn: conn} do
    %{conn: conn} = register_and_log_in_user(%{conn: conn})
    {:ok, _view, html} = live(conn, "/")
    assert html =~ "Game"
  end

  test "Starts game when clicked to start game", %{conn: conn} do
    %{conn: conn} = register_and_log_in_user(%{conn: conn})
    {:ok, view, _html} = live(conn, "/")
    assert render_click(view, "start_game") =~ "Moves left: 9"
  end

  test "Joins game when clicked to join a game", %{conn: conn} do
    %{conn: conn} = register_and_log_in_user(%{conn: conn})
    {:ok, view, _html} = live(conn, "/")
    render_click(view, "start_game")
    current_user = Accounts.get_user_by_session_token(conn.private.plug_session["user_token"])
    game_name = current_user.email |> String.split("@") |> Enum.at(0)
    assert render_click(view, "join_game", %{game_name: game_name}) =~ "Moves left: 9"
  end

  test "Changes turns left when clicked to play game", %{conn: conn} do
    %{conn: conn} = register_and_log_in_user(%{conn: conn})
    {:ok, view, html} = live(conn, "/")
    render_click(view, "start_game")
    assert render_click(view, "click", %{value: "1"}) =~ "Moves left: 8"
    refute html =~ "End game"
  end

  test "keeps same turns left when clicked on an already clicked button", %{conn: conn} do
    %{conn: conn} = register_and_log_in_user(%{conn: conn})
    {:ok, view, _html} = live(conn, "/")
    render_click(view, "start_game")
    assert render_click(view, "click", %{value: "1"}) =~ "Moves left: 8"
    assert render_click(view, "click", %{value: "2"}) =~ "Moves left: 7"
    assert render_click(view, "click", %{value: "2"}) =~ "Moves left: 7"
  end
end
