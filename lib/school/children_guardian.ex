defmodule School.ChildrenGuardian do
  use Ecto.Schema
  import Ecto.Changeset

  schema "children_guardians" do
    field :children_id, :integer
    field :guardian_id, :integer

    timestamps()
  end

  def changeset(changeset, params \\ %{}) do
    changeset
    |> cast(params, [:children_id, :guardian_id])
    |> validate_required([:children_id, :guardian_id])
  end
end
