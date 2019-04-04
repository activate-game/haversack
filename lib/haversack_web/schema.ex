defmodule HaversackWeb.Schema do
  @moduledoc """
  Defines the GraphQL schema.
  """

  use Absinthe.Schema

  import_types(__MODULE__.DungeonTypes)
  import_types(__MODULE__.ItemTypes)

  query do
    import_fields(:dungeon_queries)
    import_fields(:item_queries)
  end

  mutation do
    import_fields(:dungeon_mutations)
    import_fields(:item_mutations)
  end

  scalar :json do
    parse(fn input ->
      case Jason.decode(input.value) do
        {:ok, result} -> result
        _ -> :error
      end
    end)

    serialize(&Jason.encode!/1)
  end
end
