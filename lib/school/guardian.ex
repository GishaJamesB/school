defmodule School.Guardian do
  use Ecto.Schema
  import Ecto.Changeset

  alias School.Children

  schema "guardians" do
    field :name, :string
    field :relation, :string
    field :religion, :string

    many_to_many :children, Children, join_through: "children_guardians"
    timestamps()
  end

  def changeset(changeset, params \\ %{}) do
    changeset
    |> cast(params, [:name, :relation, :religion])
    |> validate_required([:name])
  end
end
