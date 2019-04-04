defmodule HaversackWeb.Router do
  use HaversackWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", HaversackWeb do
    pipe_through :api
  end

  scope "/" do
    pipe_through :api

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: HaversackWeb.Schema,
      socket: MyAppWeb.UserSocket

    forward "/", Absinthe.Plug, schema: HaversackWeb.Schema
  end
end
