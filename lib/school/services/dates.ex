defmodule School.Services.Dates do
  alias School.Dates
  alias School.Repo

  import Ecto.Query

  def create(data) do
    Dates.changeset(%Dates{}, data) |> Repo.insert
  end

  def get() do
    query = from d in Dates,
     select: %{date: d.date, id: d.id}
    query |> Repo.all()
  end
end
