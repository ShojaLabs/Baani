defmodule BaaniWeb.Plugs.GetSubscribedSyndicates do
  import Plug.Conn
  alias Baani.Syndicates

  def init(default), do: default

  def call(conn, _opts) do
    user_id = conn.assigns.current_user.id

    case Syndicates.get_subscribed_syndicates(user_id) do
      [] ->
        conn
        |> assign(:subscribed_syndicates, [])

      syndicates ->
        conn
        |> assign(:subscribed_syndicates, syndicates)
    end
  end
end
