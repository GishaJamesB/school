defmodule School.Repo.Migrations.AddChildrenTbl do
  use Ecto.Migration

  def change do
    create table(:children) do
      add :name, :string
      add :gender, :string
      add :contact_no, :string
      add :medical_condition, :string
      add :remarks, :string

      timestamps()
      # flush()
    end
  end
end
