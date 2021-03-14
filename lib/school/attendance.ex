defmodule School.Attendance do
  use Ecto.Schema
  import Ecto.Changeset

  schema "attendance" do
    belongs_to :dates, School.Dates, foreign_key: :date_id
    belongs_to :children, School.Children
    timestamps()
  end

  def changeset(changeset, params \\ %{}) do
    changeset
    |> cast(params, [:children_id, :date_id])
    |> validate_required([:children_id, :date_id])
    |> unique_constraint(:unique_date_child, name: :date_child)
  end

end
