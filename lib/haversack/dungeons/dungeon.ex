defmodule Haversack.Dungeons.Dungeon do
  @moduledoc """
  Represents a dungeon.
  """

  use Haversack.Schema

  alias Haversack.Dungeons.Player
  alias Haversack.Items.Item

  @type t :: %__MODULE__{}

  schema "dungeons" do
    has_one :player, Player
    has_many :items, Item

    timestamps()
  end
end
