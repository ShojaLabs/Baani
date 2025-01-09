defmodule BaaniWeb.Plugs.CheckSyndicateAdmin do
  import Plug.Conn
  import Phoenix.Controller
  alias Baani.Syndicates

  def init(default), do: default

  def call(conn, _opts) do
    user_id = conn.assigns.current_user.id
    syndicate_id = conn.params["id"]

    case Syndicates.get_syndicate!(syndicate_id, user_id) do
      %{is_admin: true} ->
        conn

      _ ->
        conn
        |> put_flash(:error, "You are not authorized to access this page.")
        |> redirect(to: "/syndicates")
        |> halt()
    end
  end
end
