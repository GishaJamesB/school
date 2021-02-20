defmodule School.Children do
  use Ecto.Schema

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
end
