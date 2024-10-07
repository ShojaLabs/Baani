defmodule ShojaWeb.UserProfileLive.Index do
  use ShojaWeb, :live_view

  alias Shoja.Accounts
  alias Shoja.Accounts.UserProfile

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     stream(
       socket,
       :user_profiles,
       Accounts.list_user_profiles_by_user_id(socket.assigns.current_user.id)
     )}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit User profile")
    |> assign(:user_profile, Accounts.get_user_profile!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New User profile")
    |> assign(:user_profile, %UserProfile{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing User profiles")
    |> assign(:user_profile, nil)
  end

  @impl true
  def handle_info({ShojaWeb.UserProfileLive.FormComponent, {:saved, user_profile}}, socket) do
    {:noreply, stream_insert(socket, :user_profiles, user_profile)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    user_profile = Accounts.get_user_profile!(id)
    {:ok, _} = Accounts.delete_user_profile(user_profile)

    {:noreply, stream_delete(socket, :user_profiles, user_profile)}
  end
end
