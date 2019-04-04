defmodule Haversack.Items do
  @moduledoc """
  The API boundary for the items system.
  """

  import Ecto.Query

  alias Haversack.Items.Item
  alias Haversack.Dungeons.Dungeon
  alias Haversack.Repo

  @doc """
  Gets a single item by `id.

  Raises `Ecto.NoResultsError` if the item does not exist.

  ## Examples

      iex> get_item!(123)
      %Item{}

      iex> get_item!(456)
      ** (Ecto.NoResultsError)

  """
  @spec get_item!(id :: String.t()) :: Item.t()
  def get_item!(id), do: Repo.get!(Item, id)

  @doc """
  Creates a item.

  ## Examples

      iex> create_item(%{field: value})
      {:ok, %Item{}}

      iex> create_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec create_item(map) :: {:ok, Item.t()} | {:error, Ecto.Changeset.t()}
  def create_item(attrs \\ %{}) do
    %Item{}
    |> Item.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a item.

  ## Examples

      iex> update_item(item, %{field: new_value})
      {:ok, %Item{}}

      iex> update_item(item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_item(%Item{} = item, attrs) do
    item
    |> Item.changeset(attrs)
    |> Repo.update()
  end

  @spec list_undiscovered_items(Dungeon.t()) :: [Item.t()]
  def list_undiscovered_items(dungeon) do
    Item
    |> where(dungeon_id: ^dungeon.id)
    |> where(discovered: false)
    |> Repo.all()
  end

  @spec discover_item(Dungeon.t()) :: Item.t() | nil
  def discover_item(dungeon) do
    with items when items != [] <- list_undiscovered_items(dungeon),
         {:ok, item} <- Enum.random(items) |> update_item(%{discovered: true}) do
      item
    else
      {:error, chset} ->
        {:error, chset}

      _ ->
        nil
    end
  end
end
