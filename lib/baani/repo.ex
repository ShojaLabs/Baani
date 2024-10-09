defmodule Baani.Repo do
  use Ecto.Repo,
    otp_app: :baani,
    adapter: Ecto.Adapters.Postgres
end
