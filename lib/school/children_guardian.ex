defmodule School.ChildrenGuardian do
  use Ecto.Schema
  import Ecto.Changeset

  schema "children_guardians" do
    field :child_id, :integer
    field :guardian_id, :integer

    timestamps()
  end

  def changeset(changeset, params \\ %{}) do
    changeset
    |> cast(params, [:child_id, :guardian_id])
    |> validate_required([:child_id, :guardian_id])
  end
end
