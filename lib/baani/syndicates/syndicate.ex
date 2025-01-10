defmodule Baani.Syndicates.Syndicate do
  use Ecto.Schema
  import Ecto.Changeset

  schema "syndicates" do
    field :title, :string
    field :unique_identifier, :string
    field :bio, :string
    field :description, :string
    field :website, :string
    field :logo_url, :string
    field :banner_url, :string
    field :twitter_url, :string
    field :facebook_url, :string
    field :instagram_url, :string
    field :linkedin_url, :string
    field :youtube_url, :string
    field :github_url, :string

    many_to_many :members, Baani.Accounts.User, join_through: "syndicates_members"

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(syndicate, attrs) do
    syndicate
    |> cast(attrs, [
      :title,
      :unique_identifier,
      :bio,
      :description,
      :website,
      :logo_url,
      :banner_url,
      :twitter_url,
      :facebook_url,
      :instagram_url,
      :linkedin_url,
      :youtube_url,
      :github_url
    ])
    |> validate_required([:title, :unique_identifier, :bio, :description])
    |> validate_length(:unique_identifier, max: 30)
    |> unique_constraint(:unique_identifier)
  end
end
