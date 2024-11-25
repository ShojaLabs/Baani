defmodule BaaniWeb.Navbar do
  use BaaniWeb, :html

  # import BaaniWeb.CoreComponents

  # alias Phoenix.LiveView.JS
  # import BaaniWeb.Gettext

  def navbar(assigns) do
    ~H"""
    <div class={[
      "relative navbar p-2 bg-base-200 rounded-lg",
      (@current_user && "min-h-fit") || "px-4"
    ]}>
      <div class="navbar-start">
        <.link
          href={~p"/"}
          class="link link-hover btn-sm flex items-center gap-2 text-lg font-semibold px-0"
        >
          <.icon name="hero-microphone-solid" class="w-4 h-4" /> Baani
        </.link>
      </div>
      <div class="navbar-end gap-2">
        <%= if @current_user do %>
          <BaaniWeb.ProfileMenu.menu current_user={@current_user} />
        <% else %>
          <%= unless @conn.request_path == ~p"/users/log_in" do %>
            <.link href={~p"/users/log_in"} class={["btn btn-outline"]}>
              Login
            </.link>
          <% end %>
          <%= unless @conn.request_path == ~p"/users/register" do %>
            <.link
              href={~p"/users/register"}
              class={[
                "btn",
                ((@conn.request_path == ~p"/users/log_in" ||
                    @conn.request_path == ~p"/users/register") && "btn-outline") ||
                  "btn-primary"
              ]}
            >
              Register
            </.link>
          <% end %>
        <% end %>
      </div>
    </div>
    """
  end
end
