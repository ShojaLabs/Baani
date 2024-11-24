defmodule BaaniWeb.Navbar do
  use BaaniWeb, :html

  # import BaaniWeb.CoreComponents

  # alias Phoenix.LiveView.JS
  # import BaaniWeb.Gettext

  def navbar(assigns) do
    ~H"""
    <div class="relative navbar min-h-fit p-2 bg-base-200 rounded-lg">
      <div class="navbar-start">
        <.link href={~p"/"} class="btn btn-ghost btn-sm">
          <.icon name="hero-microphone-solid" class="w-4 h-4" /> Baani
        </.link>
      </div>
      <div class="navbar-end gap-2">
        <%= if @current_user do %>
          <BaaniWeb.ProfileMenu.menu current_user={@current_user} />
        <% else %>
          <.link href={~p"/users/register"} class="btn btn-primary btn-sm">
            Register
          </.link>
          <.link href={~p"/users/log_in"} class="btn btn-ghost btn-sm">
            Log in
          </.link>
        <% end %>
      </div>
    </div>
    """
  end
end
