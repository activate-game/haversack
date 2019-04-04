defmodule HaversackWeb.Schema.Mutation.CreateItemTest do
  use HaversackWeb.ConnCase, async: true

  @query """
  mutation ($input: ItemInput!) {
    createItem(input: $input) {
      name
      type
      spriteIndex
      dungeon {
        id
      }
    }
  }
  """

  test "creating an item is successful" do
    %{id: dungeon_id} = insert(:dungeon)

    conn =
      build_conn()
      |> post("/",
        query: @query,
        variables: %{
          "input" => %{
            "name" => "Narsil",
            "type" => "weapon",
            "spriteIndex" => 0,
            "dungeonId" => dungeon_id
          }
        }
      )

    assert json_response(conn, 200) ==
             %{
               "data" => %{
                 "createItem" => %{
                   "name" => "Narsil",
                   "type" => "weapon",
                   "spriteIndex" => 0,
                   "dungeon" => %{
                     "id" => dungeon_id
                   }
                 }
               }
             }
  end
end
