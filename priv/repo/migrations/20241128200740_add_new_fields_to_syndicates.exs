defmodule Baani.Repo.Migrations.AddNewFieldsToSyndicates do
  use Ecto.Migration

  def change do
    alter table(:syndicates) do
      add :bio, :text
      add :description, :text
      add :website, :text
      add :logo_url, :text
      add :banner_url, :text
      add :twitter_url, :text
      add :facebook_url, :text
      add :instagram_url, :text
      add :linkedin_url, :text
      add :youtube_url, :text
      add :github_url, :text
    end
  end
end
