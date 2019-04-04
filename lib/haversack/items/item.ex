defmodule Haversack.Items.Item do
  @moduledoc """
  Represents an item in a dungeon.
  """

  use Haversack.Schema
  import Ecto.Changeset

  alias Haversack.Dungeons.Dungeon

  @type t :: %__MODULE__{}

  schema "items" do
    field :name, :string
    field :type, :string
    field :sprite_index, :integer
    field :description, :string
    field :damage_dice, :integer
    field :armor_class, :integer
    field :discovered, :boolean, default: false

    embeds_many :effects, Effect do
      field :property, :string
      field :modifier, :integer
    end

    belongs_to :dungeon, Dungeon

    timestamps()
  end

  @doc false
  @spec changeset(struct(), map()) :: Ecto.Changeset.t()
  def changeset(item, attrs) do
    item
    |> cast(attrs, [
      :name,
      :type,
      :sprite_index,
      :description,
      :damage_dice,
      :armor_class,
      :discovered,
      :dungeon_id
    ])
    |> cast_embed(:effects, with: &effect_changeset/2)
    |> validate_required([:name, :type, :sprite_index])
    |> assoc_constraint(:dungeon)
  end

  defp effect_changeset(schema, params) do
    schema
    |> cast(params, [:property, :modifier])
    |> validate_required([:property, :modifier])
  end
end
