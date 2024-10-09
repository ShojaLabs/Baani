defmodule Baani.Organizations.Organization do
  use Ecto.Schema
  import Ecto.Changeset

  schema "organizations" do
    field :name, :string
    field :domain, :string
    field :description, :string
    field :unique_name, :string
    field :logo, :string
    field :is_private, :boolean, default: false
    field :creator_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(organization, attrs) do
    organization
    |> cast(attrs, [:name, :unique_name, :description, :logo, :domain, :is_private, :creator_id])
    |> validate_required([:name, :unique_name, :domain])
    |> foreign_key_constraint(:creator_id)
  end
end
