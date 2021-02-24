defmodule School.Repo.Migrations.CreateAttendanceTbl do
  use Ecto.Migration

  def change do
    create table(:attendance) do
      add :date, :date
      add :child_id, references(:children)
      timestamps()
    end

  end
end
