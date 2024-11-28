defmodule BaaniWeb.SyndicateController do
  use BaaniWeb, :controller

  alias Baani.Syndicates
  alias Baani.Syndicates.Syndicate

  def index(conn, _params) do
    syndicates = Syndicates.list_syndicates()
    render(conn, :index, syndicates: syndicates)
  end

  def new(conn, _params) do
    changeset = Syndicates.change_syndicate(%Syndicate{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"syndicate" => syndicate_params}) do
    case Syndicates.create_syndicate(syndicate_params) do
      {:ok, syndicate} ->
        conn
        |> put_flash(:info, "Syndicate created successfully.")
        |> redirect(to: ~p"/syndicates/#{syndicate}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    syndicate = Syndicates.get_syndicate!(id)
    render(conn, :show, syndicate: syndicate)
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
end
