defmodule School.Repo.Migrations.AddChildGuardianLinkTbl do
  use Ecto.Migration

  def change do
    create table(:children_guardians) do
      add :child_id, references(:children)
      add :guardian_id, references(:guardians)
      timestamps()
    end
  end
end
