defmodule Haversack.Repo.Migrations.CreatePlayers do
  use Ecto.Migration

  def change do
    create table(:players, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:name, :string, null: false)
      add(:sprite_index, :integer, null: false)
      add(:max_hitpoints, :integer, null: false, default: 8)
      add(:armor_class, :integer, null: false, default: 10)
      add(:attack_modifier, :integer, null: false, default: 0)
      add(:damage_modifier, :integer, null: false, default: 0)
      add(:damage_dice, :string, null: false, default: "1d4")
      add(:speed, :integer, null: false, default: 1)

      timestamps()
    end
  end
end
