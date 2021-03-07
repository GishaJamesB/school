defmodule School.Repo.Migrations.CreateAttendanceTbl do
  use Ecto.Migration

  def change do
    create table(:attendance) do
      add :date_id, references(:dates)
      add :children_id, references(:children)
      timestamps()
    end

    create unique_index(:attendance, [:date_id, :children_id], name: :date_child)

  end
end
