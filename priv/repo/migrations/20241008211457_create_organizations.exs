defmodule Baani.Repo.Migrations.CreateOrganizations do
  use Ecto.Migration

  def change do
    create table(:organizations) do
      add :name, :string
      add :unique_name, :string
      add :description, :string
      add :logo, :string
      add :domain, :string
      add :is_private, :boolean, default: false, null: false
      add :creator_id, references(:users, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:organizations, [:creator_id])
  end
end
