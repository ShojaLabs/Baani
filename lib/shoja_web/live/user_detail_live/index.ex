defmodule ShojaWeb.UserDetailLive.Index do
  use ShojaWeb, :live_view

  alias Shoja.Accounts
  alias Shoja.Accounts.UserDetail

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :user_details, Accounts.list_user_details())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit User detail")
    |> assign(:user_detail, Accounts.get_user_detail!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New User detail")
    |> assign(:user_detail, %UserDetail{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing User details")
    |> assign(:user_detail, nil)
  end

  @impl true
  def handle_info({ShojaWeb.UserDetailLive.FormComponent, {:saved, user_detail}}, socket) do
    {:noreply, stream_insert(socket, :user_details, user_detail)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    user_detail = Accounts.get_user_detail!(id)
    {:ok, _} = Accounts.delete_user_detail(user_detail)

    {:noreply, stream_delete(socket, :user_details, user_detail)}
  end
end
