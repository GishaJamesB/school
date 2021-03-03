defmodule School.Repo.Migrations.CreateDatesTbl do
  use Ecto.Migration

  def change do
    create table(:dates) do
      add :date, :date
    end

    create unique_index(:dates, [:date])

  end
end
