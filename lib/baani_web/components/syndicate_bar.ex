defmodule BaaniWeb.SyndicateBar do
  use BaaniWeb, :html

  # import BaaniWeb.CoreComponents

  # alias Phoenix.LiveView.JS
  # import BaaniWeb.Gettext

  def navbar(assigns) do
    ~H"""
    <%= if @current_user do %>
      <div class="card bg-base-100 w-60 min-h-full rounded-none border-r border-base-200 pr-2">
        <button class="btn">Click me</button>
      </div>
    <% end %>
    """
  end
end
