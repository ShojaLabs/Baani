defmodule BaaniWeb.GoogleAuthController do
  alias BaaniWeb.UserAuth
  alias Baani.Accounts
  use BaaniWeb, :controller
  require Logger

  plug Ueberauth

  def request(conn, _params) do
    IO.inspect("TEST")
    IO.inspect(System.get_env("GOOGLE_CLIENT_ID"))
    IO.inspect(Ueberauth.Strategy.Helpers.callback_url(conn))
    Phoenix.Controller.redirect(conn, to: Ueberauth.Strategy.Helpers.callback_url(conn))
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    email = auth.info.email
    conn = fetch_session(conn)

    case Accounts.get_user_by_email(email) do
      nil ->
        # User does not exist, so create a new user
        user_params = %{
          email: email
          # first_name: auth.info.first_name,
          # last_name: auth.info.last_name
        }

        case Accounts.register_oauth_user(user_params) do
          {:ok, user} ->
            UserAuth.log_in_user(conn, user)

          {:error, changeset} ->
            Logger.error("Failed to create user #{inspect(changeset)}.")

            conn
            |> put_flash(:error, "Failed to create user.")
            |> redirect(to: ~p"/")
        end

      user ->
        # User exists, update session or other details if necessary
        UserAuth.log_in_user(conn, user)
    end
  end
end
