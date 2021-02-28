defmodule School.Dates do
  use Ecto.Schema

  alias School.Children

  schema "dates" do
    field :date, :date
    many_to_many :children, Children, join_through: "attendance"
  end

end
