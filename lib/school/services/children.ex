defmodule School.Services.Children do
  alias School.Children
  alias School.Repo

  import Ecto.Query

  def get_all do
    d = :ets.lookup(:school_bucket, :children)
    case d do
      [] ->
        query = from c in Children,
          select: %{id: c.id, name: c.name},
          order_by: [asc: c.name]

        all_children = query |> Repo.all()
        GenServer.call(School.Cache, {:insert, {:children, all_children}})
        all_children
      _ ->
        d[:children]
    end
  end
end
