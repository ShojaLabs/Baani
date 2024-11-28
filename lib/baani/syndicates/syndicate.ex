defmodule Baani.Syndicates.Syndicate do
  use Ecto.Schema
  import Ecto.Changeset

  schema "syndicates" do
    field :title, :string
    field :unique_identifier, :string

    many_to_many :members, Baani.Accounts.User, join_through: "syndicates_members"

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(syndicate, attrs) do
    syndicate
    |> cast(attrs, [:title, :unique_identifier])
    |> validate_required([:title, :unique_identifier])
    |> unique_constraint(:unique_identifier)
  end
end
