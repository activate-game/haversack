defmodule HaversackWeb.Schema.Mutation.DungeonTest do
  use HaversackWeb.ConnCase, async: true

  @query """
  query ($id: ID!) {
    dungeon(id: $id) {
      id
    }
  }
  """

  test "getting a dungeon is successful" do
    %{id: dungeon_id} = insert(:dungeon)

    conn =
      build_conn()
      |> post("/",
        query: @query,
        variables: %{"id" => dungeon_id}
      )

    assert json_response(conn, 200) == %{
             "data" => %{"dungeon" => %{"id" => dungeon_id}}
           }
  end
end
