defmodule Shoja.Repo do
  use Ecto.Repo,
    otp_app: :shoja,
    adapter: Ecto.Adapters.Postgres
end
