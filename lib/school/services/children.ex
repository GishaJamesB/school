defmodule School.Services.Children do
  alias School.Children
  alias School.Repo

  import Ecto.Query

  def get_all do
    query = from c in Children,
      select: %{id: c.id, name: c.name},
      order_by: [asc: c.name]

    query |> Repo.all()
  end
end
