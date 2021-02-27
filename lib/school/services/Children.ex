defmodule School.Services.Children do
  alias School.Children
  alias School.Repo

  def get_all do
    children = Children |> Repo.all()
    children |> Repo.preload(:guardians)
  end
end
