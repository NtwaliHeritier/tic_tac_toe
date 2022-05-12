defmodule TicTacToe.DataCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias TicTacToe.Repo
      alias TicTacToe.Accounts
      alias TicTacToe.Accounts.User

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import TicTacToe.DataCase
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(TicTacToe.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(TicTacToe.Repo, {:shared, self()})
    end

    :ok
  end
end
