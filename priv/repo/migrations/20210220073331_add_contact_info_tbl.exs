defmodule School.Repo.Migrations.AddContactInfoTbl do
  use Ecto.Migration

  def change do
    create table(:contact_info) do
      add :email, :string
      add :mobile_number, :string
      add :home_number, :integer
      add :guardian_id, references(:guardians)
      add :child_id, references(:children)

      timestamps()
    end
  end
end
