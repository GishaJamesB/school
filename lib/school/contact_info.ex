defmodule School.ContactInfo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "contact_info" do
    field :email, :string
    field :mobile_number, :string
    field :home_number, :string
    field :guardian_id, :integer

    timestamps()
  end

  def changeset(changeset, params \\ %{}) do
    changeset
    |> cast(params, [:email, :mobile_number, :home_number, :guardian_id])
  end
end
