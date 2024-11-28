defmodule Baani.Syndicates do
  @moduledoc """
  The Syndicates context.
  """

  import Ecto.Query, warn: false
  alias Baani.Repo

  alias Baani.Syndicates.Syndicate

  @doc """
  Returns the list of syndicates.

  ## Examples

      iex> list_syndicates()
      [%Syndicate{}, ...]

  """
  def list_syndicates do
    Repo.all(Syndicate)
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
end
