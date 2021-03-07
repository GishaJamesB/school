defmodule School.Services.Dates do
  alias School.Dates
  alias School.Repo
  alias School.Utils.Errors

  import Ecto.Query

  def create(data) do
    case Dates.changeset(%Dates{}, data) |> Repo.insert do
      {:ok, _} ->
        School.Cache.remove(:dates)
        get()
      {:error, changeset} ->
        {:error, Errors.get_formatted_errors(changeset)}
    end
  end

  def get() do
    d = School.Cache.get(:dates)
    case d do
      [] ->
        query = from d in Dates,
          select: %{date: d.date, id: d.id},
          order_by: d.date
        dates =  query |> Repo.all()
        School.Cache.add({:dates, dates})
        dates
      _ ->
        d[:dates]
    end

  end
end
