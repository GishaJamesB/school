defmodule School.Services.Dates do
  alias School.Dates
  alias School.Repo

  def create(data) do
    Dates.changeset(%Dates{}, data) |> Repo.insert
  end
end
