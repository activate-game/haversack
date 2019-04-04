defmodule HaversackWeb.Schema.Query.UndiscoveredItemsTest do
  use HaversackWeb.ConnCase, async: true

  @query """
  query ($dungeonId: ID!) {
    undiscoveredItems(dungeonId: $dungeonId) {
      id
    }
  }
  """

  test "getting undiscovered items returns the correct results" do
    dungeon = insert(:dungeon)
    item = insert(:item, discovered: false, dungeon_id: dungeon.id)
    insert(:item, discovered: true, dungeon_id: dungeon.id)

    conn =
      build_conn()
      |> post("/",
        query: @query,
        variables: %{"dungeonId" => dungeon.id}
      )

    assert json_response(conn, 200) == %{
             "data" => %{"undiscoveredItems" => [%{"id" => item.id}]}
           }
  end
end
