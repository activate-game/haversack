defmodule Haversack.Repo.Migrations.CreateDungeons do
  use Ecto.Migration

  def change do
    create table(:dungeons, primary_key: false) do
      add :id, :binary_id, primary_key: true

      timestamps()
    end

    alter table(:players) do
      add(
        :dungeon_id,
        references(:dungeons, type: :binary_id, on_delete: :delete_all)
      )
    end

    alter table(:items) do
      add(
        :dungeon_id,
        references(:dungeons, type: :binary_id, on_delete: :delete_all)
      )
    end

    create(index(:players, :dungeon_id))
    create(index(:items, :dungeon_id))
  end
end
