defmodule Haversack.Repo.Migrations.CreateItemTypes do
  use Ecto.Migration

  def change do
    create table(:items, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:name, :string, null: false)
      add(:type, :string, null: false)
      add(:sprite_index, :integer, null: false)
      add(:description, :string)
      add(:damage_dice, :integer)
      add(:armor_class, :integer)
      add(:discovered, :boolean, null: false, default: false)
      add(:effects, {:array, :map}, default: [])

      timestamps()
    end
  end
end
