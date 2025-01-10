defmodule Baani.Repo.Migrations.AddSyndicateMemberRole do
  use Ecto.Migration

  def change do
    alter table(:syndicates_members) do
      add :role, :string, default: "auditor", null: false
    end
  end
end
