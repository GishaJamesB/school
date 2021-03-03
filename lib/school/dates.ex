defmodule School.Dates do
  use Ecto.Schema
  import Ecto.Changeset

  alias School.Children

  schema "dates" do
    field :date, :date
    many_to_many :children, Children, join_through: "attendance"
  end

  def changeset(changeset, params \\ %{}) do
    changeset
    |> cast(params, [:date])
  end

end
