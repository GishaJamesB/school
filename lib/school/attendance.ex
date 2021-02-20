defmodule School.Attendance do
  use Ecto.Schema

  alias School.Children

  schema "attendance" do
    field :date, :date
    belongs_to :childres, Children
    timestamps()
  end

end
