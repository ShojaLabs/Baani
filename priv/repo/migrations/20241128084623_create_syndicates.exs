defmodule Baani.Repo.Migrations.CreateSyndicates do
  use Ecto.Migration

  def change do
    create table(:syndicates) do
      add :title, :string
      add :unique_identifier, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:syndicates, [:unique_identifier])

    create table(:syndicates_members) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :syndicate_id, references(:syndicates, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:syndicates_members, [:user_id, :syndicate_id])
  end
end
