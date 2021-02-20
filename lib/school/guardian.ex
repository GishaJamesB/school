defmodule School.Guardian do
  use Ecto.Schema

  alias School.Children

  schema "guardians" do
    field :name, :string
    field :relation, :string
    field :child_id, :integer

    many_to_many :children, Children, join_through: "children_guardians"
  end
end
