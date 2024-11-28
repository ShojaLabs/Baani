defmodule BaaniWeb.SyndicateBar do
  use BaaniWeb, :html

  # import BaaniWeb.CoreComponents

  # alias Phoenix.LiveView.JS
  # import BaaniWeb.Gettext

  def navbar(assigns) do
    ~H"""
    <%= if @current_user do %>
      <div class="card pr-2 min-h-full rounded-lg flex flex-col space-between border-r border-base-200">
        <div class="flex flex-col gap-2 mb-2 flex-1">
          <.link navigate={~p"/syndicates"}>
            <div class="tooltip tooltip-right tooltip-primary" data-tip="Your Dashboard">
              <button class="btn btn-primary w-12 p-0">
                <.icon name="hero-queue-list" class="h-5 w-5" />
              </button>
            </div>
          </.link>
          <button class="btn w-12 p-0">
            <div class="w-8">
              <img src="https://img.icons8.com/?size=100&id=gUClbC7qqETn&format=png&color=000000" />
            </div>
          </button>
          <button class="btn w-12 p-0">
            <div class="w-8">
              <img src="https://img.icons8.com/?size=100&id=owyuBEKvnmkf&format=png&color=000000" />
            </div>
          </button>
          <button class="btn w-12 p-0">
            <div class="w-8">
              <img src="https://img.icons8.com/?size=100&id=Cv2SxtS796Pa&format=png&color=000000" />
            </div>
          </button>
          <button class="btn w-12 p-0">
            <div class="w-8">
              <img src="https://img.icons8.com/?size=100&id=x0LhC1zQa9CB&format=png&color=000000" />
            </div>
          </button>
          <button class="btn w-12 p-0">
            <div class="w-8">
              <img src="https://img.icons8.com/?size=100&id=Yy5q2TjOAQ9D&format=png&color=000000" />
            </div>
          </button>
          <button class="btn w-12 p-0">
            <div class="w-8">
              <img src="https://img.icons8.com/?size=100&id=pe3KKd2Y8ned&format=png&color=000000" />
            </div>
          </button>
          <button class="btn w-12 p-0">
            <div class="w-8">
              <img src="https://img.icons8.com/?size=100&id=EDaShbnpcOD7&format=png&color=000000" />
            </div>
          </button>
        </div>

        <.link navigate={~p"/syndicates"}>
          <div class="tooltip tooltip-right tooltip-primary" data-tip="Find more syndicates!">
            <button class="btn btn-primary btn-outline w-12 p-0">
              <.icon name="hero-globe-asia-australia" class="h-5 w-5" />
            </button>
          </div>
        </.link>
      </div>
    <% end %>
    """
  end
end
