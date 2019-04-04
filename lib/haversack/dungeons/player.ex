defmodule Haversack.Dungeons.Player do
  @moduledoc """
  Represents a player in a dungeon.
  """

  use Haversack.Schema
  import Ecto.Changeset

  alias Haversack.Dungeons.Dungeon

  @type t :: %__MODULE__{}

  schema "players" do
    field :name, :string
    field :sprite_index, :integer
    field :max_hitpoints, :integer, default: 8
    field :armor_class, :integer, default: 10
    field :attack_modifier, :integer, default: 0
    field :damage_modifier, :integer, default: 0
    field :damage_dice, :string, default: "1d4"
    field :speed, :integer, default: 1

    belongs_to :dungeon, Dungeon

    timestamps()
  end

  @attrs [
    :name,
    :sprite_index,
    :max_hitpoints,
    :armor_class,
    :attack_modifier,
    :damage_modifier,
    :damage_dice,
    :speed,
    :dungeon_id
  ]

  @doc false
  @spec changeset(struct(), map()) :: Ecto.Changeset.t()
  def changeset(player, attrs) do
    player
    |> cast(attrs, @attrs)
    |> validate_required([:name, :sprite_index])
    |> assoc_constraint(:dungeon)
  end
end
