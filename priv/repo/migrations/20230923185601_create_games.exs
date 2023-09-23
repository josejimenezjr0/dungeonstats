defmodule DungeonStats.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :name, :string
      add :slug, :string
      add :started_at, :utc_datetime
      add :ended_at, :utc_datetime
      add :last_move_at, :utc_datetime

      timestamps()
    end

    create unique_index(:games, [:slug])
  end
end
