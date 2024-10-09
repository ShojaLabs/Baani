defmodule Baani.Accounts.UserDetail do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_details" do
    field :first_name, :string
    field :last_name, :string
    field :bio, :string
    field :date_of_birth, :date

    belongs_to :user, Baani.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user_detail, attrs) do
    user_detail
    |> cast(attrs, [:first_name, :last_name, :bio, :date_of_birth, :user_id])
    |> validate_required([:first_name, :last_name, :bio, :date_of_birth])
    |> foreign_key_constraint(:user_id)
  end
end
