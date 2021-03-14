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

    many_to_many(
      :guardians,
      Guardian,
      join_through: "children_guardians",
      join_keys: [children_id: :id, guardian_id: :id]
    )

    has_many :attendance, School.Attendance

    # many_to_many(
    #   :attendance,
    #   Attendance,
    #   join_through: "attendance",
    #   join_keys: [children_id: :id, guardian_id: :id]
    # )


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
