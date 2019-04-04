defmodule HaversackWeb.Schema.Mutation.DiscoverItemTest do
  use HaversackWeb.ConnCase, async: true

  @query """
  mutation ($dungeonId: ID!) {
    discoverItem(dungeonId: $dungeonId) {
      id
      discovered
    }
  }
  """

  test "discovering an item succeeds when there is an available item" do
    dungeon = insert(:dungeon)
    item = insert(:item, discovered: false, dungeon_id: dungeon.id)

    conn =
      build_conn()
      |> post("/",
        query: @query,
        variables: %{"dungeonId" => dungeon.id}
      )

    assert json_response(conn, 200) == %{
             "data" => %{
               "discoverItem" => %{"id" => item.id, "discovered" => true}
             }
           }
  end

  test "discovering an item succeeds when there are no available items" do
    dungeon = insert(:dungeon)

    conn =
      build_conn()
      |> post("/",
        query: @query,
        variables: %{"dungeonId" => dungeon.id}
      )

    assert json_response(conn, 200) == %{"data" => %{"discoverItem" => nil}}
  end
end
