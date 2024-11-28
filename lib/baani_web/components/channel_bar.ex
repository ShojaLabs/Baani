defmodule BaaniWeb.ChannelBar do
  use BaaniWeb, :html

  # import BaaniWeb.CoreComponents

  # alias Phoenix.LiveView.JS
  # import BaaniWeb.Gettext

  def navbar(assigns) do
    ~H"""
    <%= if @current_user do %>
      <div class="card p-2 bg-base-200 w-20 min-h-full rounded-lg flex flex-col gap-2">
        <button class="btn btn-lg btn-neutral">1</button>
        <button class="btn btn-lg btn-neutral">2</button>
        <button class="btn btn-lg btn-neutral">3</button>
        <button class="btn btn-lg btn-neutral">4</button>
        <button class="btn btn-lg btn-neutral">1</button>
        <button class="btn btn-lg btn-neutral">2</button>
        <button class="btn btn-lg btn-neutral">3</button>
        <button class="btn btn-lg btn-neutral">4</button>
        <button class="btn btn-lg btn-neutral">1</button>
        <button class="btn btn-lg btn-neutral">2</button>
        <button class="btn btn-lg btn-neutral">3</button>
        <button class="btn btn-lg btn-neutral">4</button>
      </div>
    <% end %>
    """
  end
end
