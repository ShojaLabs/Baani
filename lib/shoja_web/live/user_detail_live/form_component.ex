defmodule ShojaWeb.UserDetailLive.FormComponent do
  use ShojaWeb, :live_component

  alias Shoja.Accounts

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage user_detail records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="user_detail-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:first_name]} type="text" label="First name" />
        <.input field={@form[:last_name]} type="text" label="Last name" />
        <.input field={@form[:bio]} type="text" label="Bio" />
        <.input field={@form[:date_of_birth]} type="date" label="Date of birth" />
        <:actions>
          <.button phx-disable-with="Saving...">Save User detail</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{user_detail: user_detail} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Accounts.change_user_detail(user_detail))
     end)}
  end

  @impl true
  def handle_event("validate", %{"user_detail" => user_detail_params}, socket) do
    changeset = Accounts.change_user_detail(socket.assigns.user_detail, user_detail_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"user_detail" => user_detail_params}, socket) do
    save_user_detail(socket, socket.assigns.action, user_detail_params)
  end

  defp save_user_detail(socket, :edit, user_detail_params) do
    case Accounts.update_user_detail(socket.assigns.user_detail, user_detail_params) do
      {:ok, user_detail} ->
        notify_parent({:saved, user_detail})

        {:noreply,
         socket
         |> put_flash(:info, "User detail updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_user_detail(socket, :new, user_detail_params) do
    case Accounts.create_user_detail(user_detail_params) do
      {:ok, user_detail} ->
        notify_parent({:saved, user_detail})

        {:noreply,
         socket
         |> put_flash(:info, "User detail created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
