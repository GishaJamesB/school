defmodule School.Attendance do
  use Ecto.Schema
  import Ecto.Changeset

  schema "attendance" do
    field :date_id, :integer
    field :children_id, :integer
    timestamps()
  end

  def changeset(changeset, params \\ %{}) do
    changeset
    |> cast(params, [:children_id, :date_id])
    |> validate_required([:children_id, :date_id])
  end

end
