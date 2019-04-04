defmodule Haversack.DungeonsTest do
  @moduledoc false

  use Haversack.DataCase

  alias Haversack.Dungeons

  describe "dungeons" do
    alias Haversack.Dungeons.Dungeon

    test "get_dungeon/1 returns dungeon with given id" do
      dungeon = insert(:dungeon)
      assert dungeon = Dungeons.get_dungeon!(dungeon.id)
    end

    test "create_dungeon/0 creates a dungeon" do
      assert {:ok, %Dungeon{} = dungeon} = Dungeons.create_dungeon()
    end
  end

  describe "players" do
    alias Haversack.Dungeons.Player

    test "get_player/1 returns player with given id" do
      player = insert(:player)
      assert player = Dungeons.get_player!(player.id)
    end

    test "create_player/1 with valid data creates a player" do
      attrs = params_for(:player)

      assert {:ok, %Player{} = player} = Dungeons.create_player(attrs)
      assert player.name == attrs[:name]
      assert player.sprite_index == attrs[:sprite_index]
      assert player.max_hitpoints == attrs[:max_hitpoints]
      assert player.armor_class == attrs[:armor_class]
      assert player.attack_modifier == attrs[:attack_modifier]
      assert player.damage_modifier == attrs[:damage_modifier]
      assert player.damage_dice == attrs[:damage_dice]
      assert player.speed == attrs[:speed]
    end

    test "create_player/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Dungeons.create_player(%{})
    end
  end
end
