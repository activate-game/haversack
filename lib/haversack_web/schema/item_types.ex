defmodule HaversackWeb.Schema.ItemTypes do
  use Absinthe.Ecto, repo: Haversack.Repo
  use Absinthe.Schema.Notation

  alias Haversack.Items
  alias Haversack.Dungeons

  object :item do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :type, non_null(:string)
    field :sprite_index, non_null(:integer)
    field :description, :string
    field :damage_dice, :integer
    field :armor_class, :integer
    field :discovered, non_null(:boolean)
    field :effects, list_of(:effect)
    field :dungeon, :dungeon, resolve: assoc(:dungeon)
  end

  object :effect do
    field :property, :string
    field :modifier, :integer
  end

  object :item_queries do
    field :item, :item do
      arg(:id, non_null(:id))
      resolve(fn _, %{id: id}, _ -> {:ok, Items.get_item!(id)} end)
    end

    field :undiscovered_items, list_of(:item) do
      arg(:dungeon_id, non_null(:id))

      resolve(fn _, %{dungeon_id: dungeon_id}, _ ->
        items =
          dungeon_id
          |> Dungeons.get_dungeon!()
          |> Items.list_undiscovered_items()

        {:ok, items}
      end)
    end
  end

  object :item_mutations do
    field :create_item, :item do
      arg(:input, non_null(:item_input))
      resolve(fn _, %{input: attrs}, _ -> Items.create_item(attrs) end)
    end

    field :discover_item, :item do
      arg(:dungeon_id, non_null(:id))

      resolve(fn _, %{dungeon_id: dungeon_id}, _ ->
        item =
          dungeon_id
          |> Dungeons.get_dungeon!()
          |> Items.discover_item()

        {:ok, item}
      end)
    end
  end

  input_object :item_input do
    field :name, non_null(:string)
    field :type, non_null(:string)
    field :sprite_index, non_null(:integer)
    field :description, :string
    field :damage_dice, :integer
    field :armor_class, :integer
    field :discovered, :boolean
    field :effects, list_of(:effect)
    field :dungeon_id, non_null(:id)
  end
end
