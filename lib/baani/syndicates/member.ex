defmodule Baani.Syndicates.Member do
  use Ecto.Schema
  import Ecto.Changeset

  schema "syndicates_members" do
    field :user_id, :id
    field :syndicate_id, :id
    field :role, :string, default: "auditor"
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(syndicate, attrs) do
    syndicate
    |> cast(attrs, [:user_id, :syndicate_id, :role])
    |> validate_required([:user_id, :syndicate_id])
    |> unique_constraint([:user_id, :syndicate_id])
    |> validate_inclusion(:role, ["auditor", "participant", "leader", "admin"])
  end
end
