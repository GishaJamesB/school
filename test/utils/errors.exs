defmodule School.ErrorsTest do
  use ExUnit.Case
  doctest School.Utils.Errors
  alias School.Utils.Errors
  alias School.Repo
  alias School.Dates

  setup do
    # Explicitly get a connection before each test
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(School.Repo)
  end


  test "get_formatted_errors" do
    data = %{:date => ~D[2000-01-01]}
    Dates.changeset(%Dates{}, data) |> Repo.insert
    {:error, changeset} = Dates.changeset(%Dates{}, data) |> Repo.insert

    assert Errors.get_formatted_errors(changeset) == "date: has already been taken"
  end
end
