defmodule BaaniWeb.ChannelBar do
  use BaaniWeb, :html

  # import BaaniWeb.CoreComponents

  # alias Phoenix.LiveView.JS
  # import BaaniWeb.Gettext

  def navbar(assigns) do
    ~H"""
    <%= if @current_user && !String.starts_with?(@conn.request_path, "/syndicates") do %>
      <div class="card bg-base-100 w-60 min-h-full rounded-none border-r border-base-200 pr-2">
        <button class="btn">Click me</button>
      </div>
    <% end %>
    """
  end
end
