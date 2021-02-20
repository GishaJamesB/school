defmodule School.Children do
  use Ecto.Schema
  import Ecto.Changeset

  alias School.Guardian

  schema "children" do
    field :name, :string
    field :gender, :string
    field :contact_no, :string
    field :medical_condition, :string
    field :remarks, :string

    many_to_many :guradians, Guardian, join_through: "children_guardians"

    timestamps()
  end

  @valid_genders ["M", "F"]

  def changeset(changeset, params \\ %{}) do
    changeset
    |> cast(params, [:name, :gender, :contact_no, :medical_condition, :remarks])
    |> validate_required([:name, :gender])
    |> validate_inclusion(:gender, @valid_genders)
  end
end
