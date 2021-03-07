defmodule School.Services.Dates do
  alias School.Dates
  alias School.Repo

  import Ecto.Query
  import Ecto.Changeset

  def create(data) do
    case Dates.changeset(%Dates{}, data) |> Repo.insert do
      {:ok, _} ->
        School.Cache.remove(:dates)
        get()
      {:error, changeset} ->
        error = traverse_errors(changeset, fn {msg, opts} ->
          Enum.reduce(opts, msg, fn {key, value}, acc ->
            String.replace(acc, "%{#{key}}", to_string(value))
          end)
        end)
        |> Enum.reduce("", fn {k, v}, acc ->
          joined_errors = Enum.join(v, "; ")
          "#{acc} #{k}: #{joined_errors}"
        end)
        {:error, error}
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
