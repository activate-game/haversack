defmodule Haversack.Dungeons do
  @moduledoc """
  The API boundary for the dungeons system.
  """

  alias Haversack.Dungeons.{Dungeon, Player}
  alias Haversack.Items
  alias Haversack.Repo

  @seed_items [
    %{
      name: "Book",
      type: "artifact",
      sprite_index: 0,
      effects: [%{property: "speed", modifier: 2}]
    },
    %{name: "Amulet", type: "artifact", sprite_index: 0},
    %{name: "Orb", type: "artifact", sprite_index: 0},
    %{name: "Longsword", type: "weapon", sprite_index: 0, damage_dice: "1d8"},
    %{name: "Dagger", type: "weapon", sprite_index: 0, damage_dice: "1d4"},
    %{name: "Warhammer", type: "weapon", sprite_index: 0, damage_dice: "2d6"},
    %{name: "Hide Cuirass", type: "armor", sprite_index: 0, armor_class: 11},
    %{name: "Chainmail", type: "armor", sprite_index: 0, armor_class: 13},
    %{name: "Plate Armor", type: "armor", sprite_index: 0, armor_class: 16}
  ]

  @doc """
  Gets a single dungeon by `id.

  Raises `Ecto.NoResultsError` if the dungeon does not exist.

  ## Examples

      iex> get_dungeon!(123)
      %Dungeon{}

      iex> get_dungeon!(456)
      ** (Ecto.NoResultsError)

  """
  @spec get_dungeon!(id :: String.t()) :: Dungeon.t()
  def get_dungeon!(id), do: Repo.get!(Dungeon, id)

  @doc """
  Creates a dungeon.

  ## Examples

      iex> create_dungeon(%{field: value})
      {:ok, %Dungeon{}}

      iex> create_dungeon(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec create_dungeon() :: {:ok, Dungeon.t()} | {:error, Ecto.Changeset.t()}
  def create_dungeon do
    Repo.insert(%Dungeon{})
  end

  @doc """
  Gets a single player by `id.

  Raises `Ecto.NoResultsError` if the player does not exist.

  ## Examples

      iex> get_player!(123)
      %Player{}

      iex> get_player!(456)
      ** (Ecto.NoResultsError)

  """
  @spec get_player!(id :: String.t()) :: Player.t()
  def get_player!(id), do: Repo.get!(Player, id)

  @doc """
  Creates a player.

  ## Examples

      iex> create_player(%{field: value})
      {:ok, %Player{}}

      iex> create_player(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec create_player(map) :: {:ok, Player.t()} | {:error, Ecto.Changeset.t()}
  def create_player(attrs \\ %{}) do
    %Player{}
    |> Player.changeset(attrs)
    |> Repo.insert()
  end

  @spec seed_dungeon() :: {:ok, Dungeon.t()}
  def seed_dungeon do
    {:ok, dungeon} = create_dungeon()

    create_player(%{
      name: "Player",
      sprite_index: 0,
      dungeon_id: dungeon.id
    })

    Enum.each(@seed_items, fn attrs ->
      attrs
      |> Map.put(:dungeon_id, dungeon.id)
      |> Items.create_item()
    end)

    {:ok,
     dungeon.id
     |> get_dungeon!()
     |> Repo.preload([:player, :items])}
  end
end
