defmodule School.Repo.Migrations.AddGuradianTbl do
  use Ecto.Migration

  def change do
    create table(:guardians) do
      add :name, :string
      add :relation, :string
      add :child_id, :integer

      timestamps()
      # flush()
    end
  end
end
