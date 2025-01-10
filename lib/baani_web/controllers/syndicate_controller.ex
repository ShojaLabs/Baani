defmodule BaaniWeb.SyndicateController do
  use BaaniWeb, :controller

  alias Baani.Syndicates
  alias Baani.Syndicates.Syndicate
  require Logger

  def index(conn, _params) do
    id = conn.assigns.current_user.id
    syndicates_list = Syndicates.list_syndicates(id)
    render(conn, :index, data: syndicates_list)
  end

  def new(conn, _params) do
    changeset = Syndicates.change_syndicate(%Syndicate{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"syndicate" => syndicate_params}) do
    id = conn.assigns.current_user.id

    case Syndicates.create_syndicate(syndicate_params) do
      {:ok, syndicate} ->
        Syndicates.create_admin(%{user_id: id, syndicate_id: syndicate.id})

        conn
        |> put_flash(:info, "Syndicate created successfully.")
        |> redirect(to: ~p"/syndicates/#{syndicate}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user_id = conn.assigns.current_user.id
    syndicate_data = Syndicates.get_syndicate!(id, user_id)
    render(conn, :show, data: syndicate_data)
  end

  def edit(conn, %{"id" => id}) do
    syndicate = Syndicates.get_syndicate!(id)
    changeset = Syndicates.change_syndicate(syndicate)
    render(conn, :edit, syndicate: syndicate, changeset: changeset)
  end

  def update(conn, %{"id" => id, "syndicate" => syndicate_params}) do
    syndicate = Syndicates.get_syndicate!(id)

    case Syndicates.update_syndicate(syndicate, syndicate_params) do
      {:ok, syndicate} ->
        conn
        |> put_flash(:info, "Syndicate updated successfully.")
        |> redirect(to: ~p"/syndicates/#{syndicate}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, syndicate: syndicate, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    syndicate = Syndicates.get_syndicate!(id)
    {:ok, _syndicate} = Syndicates.delete_syndicate(syndicate)

    conn
    |> put_flash(:info, "Syndicate deleted successfully.")
    |> redirect(to: ~p"/syndicates")
  end

  def join_syndicate(conn, %{"id" => id}) do
    user_id = conn.assigns.current_user.id
    Syndicates.create_participant(%{user_id: user_id, syndicate_id: id})

    conn
    |> put_flash(:info, "Syndicate joined successfully.")
    |> redirect(to: ~p"/syndicates/#{id}")
  end
end
