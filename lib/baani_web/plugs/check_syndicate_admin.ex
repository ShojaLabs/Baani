defmodule BaaniWeb.Plugs.CheckSyndicateAdmin do
  import Plug.Conn
  import Phoenix.Controller
  alias Baani.Syndicates
  require Logger

  def init(default), do: default

  def call(conn, _opts) do
    user_id = conn.assigns.current_user.id
    syndicate_id = conn.params["id"]

    try do
      case Syndicates.get_syndicate!(syndicate_id, user_id) do
        %{is_admin: true} ->
          conn

        _ ->
          unauthorized_access(conn)
      end
    rescue
      Ecto.NoResultsError ->
        Logger.error("Syndicate not found for ID: #{syndicate_id}")
        unauthorized_access(conn)

      error ->
        Logger.error("An error occurred: #{inspect(error)}")
        unauthorized_access(conn)
    end
  end

  defp unauthorized_access(conn) do
    conn
    |> put_flash(:error, "You are not authorized to access this page.")
    |> redirect(to: "/syndicates")
    |> halt()
  end
end
