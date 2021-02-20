defmodule School.ContactInfo do
  use Ecto.Schema

  alias School.Guardian

  schema "contact_info" do
    field :email, :string
    field :mobile_number, :string
    field :home_number, :string

    belongs_to :guradians, Guardian
  end
end
