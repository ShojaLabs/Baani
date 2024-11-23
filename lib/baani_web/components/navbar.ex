defmodule BaaniWeb.Navbar do
  use BaaniWeb, :html

  # import BaaniWeb.CoreComponents

  # alias Phoenix.LiveView.JS
  # import BaaniWeb.Gettext

  def navbar(assigns) do
    ~H"""
    <div class="navbar min-h-4 bg-base-100 sticky top-0 z-50 border-b border-base-200">
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
