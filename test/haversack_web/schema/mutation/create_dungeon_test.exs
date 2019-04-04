defmodule HaversackWeb.Schema.Mutation.CreateDungeonTest do
  use HaversackWeb.ConnCase, async: true

  @query """
  mutation ($player: PlayerInput!) {
    createDungeon(player: $player) {
      player {
        name
        spriteIndex
        maxHitpoints
        armorClass
        attackModifier
        damageModifier
        damageDice
        speed
      }
    }
  }
  """

  test "creating a dungeon is successful" do
    conn =
      build_conn()
      |> post("/",
        query: @query,
        variables: %{
          "player" => %{
            "name" => "Elendil",
            "spriteIndex" => 0,
            "maxHitpoints" => 1,
            "armorClass" => 2,
            "attackModifier" => 3,
            "damageModifier" => 4,
            "damageDice" => "1d4",
            "speed" => 5
          }
        }
      )

    assert json_response(conn, 200) == %{
             "data" => %{
               "createDungeon" => %{
                 "player" => %{
                   "name" => "Elendil",
                   "spriteIndex" => 0,
                   "maxHitpoints" => 1,
                   "armorClass" => 2,
                   "attackModifier" => 3,
                   "damageModifier" => 4,
                   "damageDice" => "1d4",
                   "speed" => 5
                 }
               }
             }
           }
  end
end
