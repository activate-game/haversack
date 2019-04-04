defmodule HaversackWeb.Schema.Mutation.ItemTest do
  use HaversackWeb.ConnCase, async: true

  @query """
  query ($id: ID!) {
    item(id: $id) {
      id
      name
      type
      spriteIndex
      effects {
        property
        modifier
      }
    }
  }
  """

  test "getting an item is successful" do
    %{id: item_id} =
      insert(:item,
        name: "Narsil",
        type: "weapon",
        sprite_index: 0,
        effects: [%{property: "strength", modifier: 1}]
      )

    conn =
      build_conn()
      |> post("/",
        query: @query,
        variables: %{"id" => item_id}
      )

    assert json_response(conn, 200) == %{
             "data" => %{
               "item" => %{
                 "id" => item_id,
                 "name" => "Narsil",
                 "type" => "weapon",
                 "spriteIndex" => 0,
                 "effects" => [%{"property" => "strength", "modifier" => 1}]
               }
             }
           }
  end
end
