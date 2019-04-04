defmodule Haversack.Factory do
  @moduledoc false

  use ExMachina.Ecto, repo: Haversack.Repo

  alias Haversack.Dungeons.{Dungeon, Player}
  alias Haversack.Items.Item

  def dungeon_factory do
    %Dungeon{}
  end

  def player_factory do
    %Player{
      name: "Elminster",
      sprite_index: 0
    }
  end

  def item_factory do
    %Item{
      name: "Vorpal Sword",
      type: "weapon",
      sprite_index: 0
    }
  end
end
