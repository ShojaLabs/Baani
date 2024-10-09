defmodule Baani.Accounts.UserProfile do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_profiles" do
    field :primary, :boolean, default: false
    field :username, :string
    field :purpose, :string

    belongs_to :user, Baani.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user_profile, attrs) do
    user_profile
    |> cast(attrs, [:username, :purpose, :primary, :user_id])
    |> validate_required([:username, :purpose, :primary])
    |> foreign_key_constraint(:user_id)
  end
end
