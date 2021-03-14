defmodule School.Services.Children do
  alias School.Children
  alias School.Repo

  import Ecto.Query

  def get_all do
    d = School.Cache.get(:children)
    case d do
      [] ->
        query = from c in Children,
          select: %{id: c.id, name: c.name},
          order_by: [asc: c.name]

        all_children = query |> Repo.all()
        School.Cache.add({:children, all_children})
        all_children
      _ ->
        d[:children]
    end
  end

  def get_child(id) do
    School.Children
    |> Repo.get(id)
    |> Repo.preload([{:guardians, :contact_info}, {:attendance, :dates}])
  end
end
