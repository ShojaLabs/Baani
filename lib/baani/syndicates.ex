defmodule Baani.Syndicates do
  @moduledoc """
  The Syndicates context.
  """

  import Ecto.Query, warn: false
  alias Baani.Repo

  alias Baani.Syndicates.Syndicate
  alias Baani.Syndicates.Member
  require Logger

  @doc """
  Returns the list of syndicates.

  ## Examples

      iex> list_syndicates()
      [%{syndicate: Syndicate, is_admin: boolean}, ...]

  """

  def list_syndicates(user_id) do
    query =
      from s in Syndicate,
        left_join: m in Member,
        on: m.syndicate_id == s.id and m.user_id == ^user_id,
        select: %{
          syndicate: s,
          is_admin: m.role == "admin"
        }

    Repo.all(query)
  end

  @doc """
  Gets a single syndicate.

  Raises `Ecto.NoResultsError` if the Syndicate does not exist.

  ## Examples

      iex> get_syndicate!(123)
      %Syndicate{}

      iex> get_syndicate!(456)
      ** (Ecto.NoResultsError)

  """
  def get_syndicate!(id), do: Repo.get!(Syndicate, id)

  def get_syndicate!(id, user_id) do
    query =
      from s in Syndicate,
        left_join: m in Member,
        on: m.syndicate_id == s.id and m.user_id == ^user_id,
        where: s.id == ^id,
        select: %{
          syndicate: s,
          is_admin: m.role == "admin",
          is_member: not is_nil(m.role)
        }

    case Repo.one(query) do
      nil -> raise Ecto.NoResultsError, queryable: Syndicate
      result -> result
    end
  end

  @doc """
  Creates a syndicate.

  ## Examples

      iex> create_syndicate(%{field: value})
      {:ok, %Syndicate{}}

      iex> create_syndicate(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_syndicate(attrs \\ %{}) do
    %Syndicate{}
    |> Syndicate.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a syndicate.

  ## Examples

      iex> update_syndicate(syndicate, %{field: new_value})
      {:ok, %Syndicate{}}

      iex> update_syndicate(syndicate, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_syndicate(%Syndicate{} = syndicate, attrs) do
    syndicate
    |> Syndicate.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a syndicate.

  ## Examples

      iex> delete_syndicate(syndicate)
      {:ok, %Syndicate{}}

      iex> delete_syndicate(syndicate)
      {:error, %Ecto.Changeset{}}

  """
  def delete_syndicate(%Syndicate{} = syndicate) do
    Repo.delete(syndicate)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking syndicate changes.

  ## Examples

      iex> change_syndicate(syndicate)
      %Ecto.Changeset{data: %Syndicate{}}

  """
  def change_syndicate(%Syndicate{} = syndicate, attrs \\ %{}) do
    Syndicate.changeset(syndicate, attrs)
  end

  alias Baani.Syndicates.Member

  @doc """
  Returns the list of syndicates_members.

  ## Examples

      iex> list_syndicates_members()
      [%Member{}, ...]

  """
  def list_syndicates_members(id) do
    Repo.all(from m in Member, where: m.syndicate_id == ^id)
  end

  @doc """
  Gets a single member.

  Raises `Ecto.NoResultsError` if the Member does not exist.

  ## Examples

      iex> get_member!(123)
      %Member{}

      iex> get_member!(456)
      ** (Ecto.NoResultsError)

  """
  def get_member!(id), do: Repo.get!(Member, id)

  @doc """
  Creates a member with user_id, syndicate_id and role.

  ## Examples

      iex> create_member(%{user_id: 1, syndicate_id: 2, role: "admin"})
      {:ok, %Member{}}

      iex> create_member(%{user_id: nil, syndicate_id: nil, role: "participant"})
      {:error, %Ecto.Changeset{}}

  """
  def create_member(attrs \\ %{}) do
    %Member{}
    |> Member.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a member.

  ## Examples

      iex> update_member(member, %{field: new_value})
      {:ok, %Member{}}

      iex> update_member(member, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_member(%Member{} = member, attrs) do
    member
    |> Member.changeset(attrs)
    |> Repo.update()
  end

  def create_or_update_member(attrs) do
    %{user_id: user_id, syndicate_id: syndicate_id, role: _role} = attrs

    Logger.debug(
      "Attempting to create or update member with user_id: #{user_id} and syndicate_id: #{syndicate_id}"
    )

    case Repo.get_by(Member, user_id: user_id, syndicate_id: syndicate_id) do
      nil ->
        Logger.debug("No existing member found. Creating a new member.")

        case create_member(attrs) do
          {:ok, member} ->
            Logger.debug("Member created successfully: #{inspect(member)}")
            {:ok, member}

          {:error, changeset} ->
            Logger.error("Failed to create member: #{inspect(changeset)}")
            {:error, changeset}
        end

      member ->
        Logger.debug("Existing member found. Updating member with ID: #{member.id}")

        case update_member(member, attrs) do
          {:ok, updated_member} ->
            Logger.debug("Member updated successfully: #{inspect(updated_member)}")
            {:ok, updated_member}

          {:error, changeset} ->
            Logger.error("Failed to update member: #{inspect(changeset)}")
            {:error, changeset}
        end
    end
  end

  def create_auditor(attrs \\ %{}) do
    create_or_update_member(Map.put(attrs, :role, "auditor"))
  end

  def create_participant(attrs \\ %{}) do
    create_or_update_member(Map.put(attrs, :role, "participant"))
  end

  def create_leader(attrs \\ %{}) do
    create_or_update_member(Map.put(attrs, :role, "leader"))
  end

  def create_admin(attrs \\ %{}) do
    create_or_update_member(Map.put(attrs, :role, "admin"))
  end

  @doc """
  Deletes a member.

  ## Examples

      iex> delete_member(member)
      {:ok, %Member{}}

      iex> delete_member(member)
      {:error, %Ecto.Changeset{}}

  """
  def delete_member(%Member{} = member) do
    Repo.delete(member)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking member changes.

  ## Examples

      iex> change_member(member)
      %Ecto.Changeset{data: %Member{}}

  """
  def change_member(%Member{} = member, attrs \\ %{}) do
    Member.changeset(member, attrs)
  end
end
