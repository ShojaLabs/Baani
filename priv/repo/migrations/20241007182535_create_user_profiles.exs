defmodule Shoja.Repo.Migrations.CreateUserProfiles do
  use Ecto.Migration

  def change do
    create table(:user_profiles) do
      add :username, :string
      add :purpose, :string
      add :primary, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:user_profiles, [:user_id])
  end
end
