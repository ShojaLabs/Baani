defmodule ShojaWeb.UserProfileLive.FormComponent do
  use ShojaWeb, :live_component

  alias Shoja.Accounts

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage user_profile records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="user_profile-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:username]} type="text" label="Username" />
        <.input field={@form[:purpose]} type="text" label="Purpose" />
        <.input field={@form[:primary]} type="checkbox" label="Primary" />
        <:actions>
          <.button phx-disable-with="Saving...">Save User profile</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{user_profile: user_profile} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Accounts.change_user_profile(user_profile))
     end)}
  end

  @impl true
  def handle_event("validate", %{"user_profile" => user_profile_params}, socket) do
    changeset = Accounts.change_user_profile(socket.assigns.user_profile, user_profile_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"user_profile" => user_profile_params}, socket) do
    save_user_profile(socket, socket.assigns.action, user_profile_params)
  end

  defp save_user_profile(socket, :edit, user_profile_params) do
    case Accounts.update_user_profile(socket.assigns.user_profile, user_profile_params) do
      {:ok, user_profile} ->
        notify_parent({:saved, user_profile})

        {:noreply,
         socket
         |> put_flash(:info, "User profile updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_user_profile(socket, :new, user_profile_params) do
    user_profile_params = Map.put(user_profile_params, "user_id", socket.assigns.user_id)

    case Accounts.create_user_profile(user_profile_params) do
      {:ok, user_profile} ->
        notify_parent({:saved, user_profile})

        {:noreply,
         socket
         |> put_flash(:info, "User profile created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
