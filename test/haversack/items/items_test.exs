defmodule Haversack.ItemsTest do
  @moduledoc false

  use Haversack.DataCase

  alias Haversack.Items

  describe "items" do
    alias Haversack.Items.Item

    test "get_item/1 returns item with given id" do
      item = insert(:item)
      assert item = Items.get_item!(item.id)
    end

    test "create_item/1 with valid data creates a item" do
      attrs = params_for(:item)

      assert {:ok, %Item{} = item} = Items.create_item(attrs)
      assert item.name == attrs[:name]
    end

    test "create_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Items.create_item(%{})
    end

    test "update_item/2 with valid data updates the item" do
      item = insert(:item, discovered: false)

      assert {:ok, %Item{discovered: discovered} = item} =
               Items.update_item(item, %{discovered: true})

      assert discovered
    end

    test "update_item/2 with invalid data returns error changeset" do
      item = insert(:item)

      assert {:error, %Ecto.Changeset{}} = Items.update_item(item, %{name: nil})
      assert item == Items.get_item!(item.id)
    end

    test "list_undiscovered_items/1 returns a list of undiscovered items in a dungeon" do
      dungeon = insert(:dungeon)
      item = insert(:item, discovered: false, dungeon_id: dungeon.id)
      insert(:item, discovered: true, dungeon_id: dungeon.id)

      assert Items.list_undiscovered_items(dungeon) == [item]
    end

    test "discover_item/1 discovers an item if one exists" do
      dungeon = insert(:dungeon)
      insert(:item, discovered: false, dungeon_id: dungeon.id)

      assert item = Items.discover_item(dungeon)
      assert item.discovered
    end

    test "discover_item/1 returns nil if none exist" do
      dungeon = insert(:dungeon)
      item = insert(:item, discovered: true, dungeon_id: dungeon.id)

      assert Items.discover_item(dungeon) == nil
      assert item.discovered
    end
  end
end
