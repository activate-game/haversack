defmodule HaversackWeb.Schema.DungeonTypes do
  use Absinthe.Ecto, repo: Haversack.Repo
  use Absinthe.Schema.Notation

  alias Haversack.Dungeons

  object :dungeon do
    field :id, non_null(:id)
    field :player, :player, resolve: assoc(:player)
    field :items, list_of(:item), resolve: assoc(:items)
  end

  object :player do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :sprite_index, non_null(:integer)
    field :max_hitpoints, non_null(:integer)
    field :armor_class, non_null(:integer)
    field :attack_modifier, non_null(:integer)
    field :damage_modifier, non_null(:integer)
    field :damage_dice, non_null(:string)
    field :speed, non_null(:integer)
    field :dungeon, :dungeon, resolve: assoc(:dungeon)
  end

  object :dungeon_queries do
    field :dungeon, :dungeon do
      arg(:id, non_null(:id))
      resolve(fn _, %{id: id}, _ -> {:ok, Dungeons.get_dungeon!(id)} end)
    end
  end

  object :dungeon_mutations do
    field :create_dungeon, :dungeon do
      arg(:player, non_null(:player_input))

      resolve(fn _, %{player: attrs}, _ ->
        with {:ok, dungeon} = result <- Dungeons.create_dungeon(),
             {:ok, _} <-
               Dungeons.create_player(Map.put(attrs, :dungeon_id, dungeon.id)) do
          result
        else
          _ ->
            {:error, :failed}
        end
      end)
    end
  end

  input_object :player_input do
    field :name, non_null(:string)
    field :sprite_index, non_null(:integer)
    field :max_hitpoints, :integer
    field :armor_class, :integer
    field :attack_modifier, :integer
    field :damage_modifier, :integer
    field :damage_dice, :string
    field :speed, :integer
  end
end
