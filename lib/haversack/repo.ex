defmodule Haversack.Repo do
  use Ecto.Repo,
    otp_app: :haversack,
    adapter: Ecto.Adapters.Postgres
end
