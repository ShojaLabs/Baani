defmodule BaaniWeb.OrganizationLive.FormComponent do
  use BaaniWeb, :live_component

  alias Baani.Organizations

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage organization records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="organization-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:unique_name]} type="text" label="Unique name" />
        <.input field={@form[:description]} type="text" label="Description" />
        <.input field={@form[:logo]} type="text" label="Logo" />
        <.input field={@form[:domain]} type="text" label="Domain" />
        <.input field={@form[:is_private]} type="checkbox" label="Is private" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Organization</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{organization: organization} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Organizations.change_organization(organization))
     end)}
  end

  @impl true
  def handle_event("validate", %{"organization" => organization_params}, socket) do
    changeset = Organizations.change_organization(socket.assigns.organization, organization_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"organization" => organization_params}, socket) do
    save_organization(socket, socket.assigns.action, organization_params)
  end

  defp save_organization(socket, :edit, organization_params)
       when socket.assigns.organization.creator_id == socket.assigns.user_id do
    case Organizations.update_organization(socket.assigns.organization, organization_params) do
      {:ok, organization} ->
        notify_parent({:saved, organization})

        {:noreply,
         socket
         |> put_flash(:info, "Organization updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_organization(socket, :edit, _organization_params),
    do:
      {:noreply,
       socket |> put_flash(:error, "Invalid action") |> push_patch(to: socket.assigns.patch)}

  defp save_organization(socket, :new, organization_params) do
    organization_params = Map.put(organization_params, "creator_id", socket.assigns.user_id)

    case Organizations.create_organization(organization_params) do
      {:ok, organization} ->
        notify_parent({:saved, organization})

        {:noreply,
         socket
         |> put_flash(:info, "Organization created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
