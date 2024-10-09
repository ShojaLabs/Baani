defmodule Shoja.Repo.Migrations.CreateUserDetails do
  use Ecto.Migration

  def change do
    create table(:user_details) do
      add :first_name, :string
      add :last_name, :string
      add :bio, :string
      add :date_of_birth, :date
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:user_details, [:user_id])
  end
end
