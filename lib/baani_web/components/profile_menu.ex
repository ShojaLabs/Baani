defmodule BaaniWeb.ProfileMenu do
  use BaaniWeb, :html

  # import BaaniWeb.CoreComponents

  # alias Phoenix.LiveView.JS
  # import BaaniWeb.Gettext

  def menu(assigns) do
    ~H"""
    <div x-data="{ dropdownOpen: false }" class="relative">
      <button @click="dropdownOpen=true" class="btn flex items-center btn-sm">
        <img
          src="https://cdn.devdojo.com/images/may2023/adam.jpeg"
          class="object-cover w-5 h-5 border rounded-full border-base-200"
        />
        <span class="text-xs"><%= @current_user.email %></span>
      </button>

      <div
        x-show="dropdownOpen"
        @click.away="dropdownOpen=false"
        x-transition:enter="ease-out duration-200"
        x-transition:enter-start="-translate-y-2"
        x-transition:enter-end="translate-y-0"
        class="absolute top-0 z-50 w-56 mt-8 -translate-x-1/2 left-10"
        x-cloak
      >
        <div class="p-1 mt-1 bg-base-100 rounded-lg shadow-xl border border-base-200">
          <div class="px-2 py-1.5 text-sm font-semibold">My Account</div>
          <div class="h-px my-1 -mx-1 bg-base-200"></div>
          <.link
            href={~p"/users/settings"}
            class="relative flex cursor-default select-none hover:bg-base-200 items-center rounded px-2 py-1.5 text-sm outline-none transition-colors data-[disabled]:pointer-events-none data-[disabled]:opacity-50 hover:cursor-pointer"
          >
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="24"
              height="24"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
              class="w-4 h-4 mr-2"
            >
              <path d="M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2"></path>
              <circle cx="12" cy="7" r="4"></circle>
            </svg>
            <span>Profile</span>
            <span class="ml-auto text-xs tracking-widest opacity-60">⇧⌘P</span>
          </.link>
          <.link
            href={~p"/users/settings"}
            class="relative flex cursor-default select-none hover:bg-base-200 items-center rounded px-2 py-1.5 text-sm outline-none transition-colors data-[disabled]:pointer-events-none data-[disabled]:opacity-50 hover:cursor-pointer"
          >
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="24"
              height="24"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
              class="w-4 h-4 mr-2"
            >
              <rect width="20" height="16" x="2" y="4" rx="2" ry="2"></rect>
              <path d="M6 8h.001"></path>
              <path d="M10 8h.001"></path>
              <path d="M14 8h.001"></path>
              <path d="M18 8h.001"></path>
              <path d="M8 12h.001"></path>
              <path d="M12 12h.001"></path>
              <path d="M16 12h.001"></path>
              <path d="M7 16h10"></path>
            </svg>
            <span>Keyboard shortcuts</span>
            <span class="ml-auto text-xs tracking-widest opacity-60">⌘K</span>
          </.link>
          <div class="h-px my-1 -mx-1 bg-base-200"></div>
          <.link
            href={~p"/users/log_out"}
            method="delete"
            class="relative flex cursor-default select-none hover:bg-base-200 items-center rounded px-2 py-1.5 text-sm outline-none transition-colors focus:text-accent-foreground data-[disabled]:pointer-events-none data-[disabled]:opacity-50 hover:cursor-pointer"
          >
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="24"
              height="24"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
              class="w-4 h-4 mr-2"
            >
              <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"></path>
              <polyline points="16 17 21 12 16 7"></polyline>
              <line x1="21" x2="9" y1="12" y2="12"></line>
            </svg>
            <span>Log out</span>
            <span class="ml-auto text-xs tracking-widest opacity-60">⇧⌘Q</span>
          </.link>
        </div>
      </div>
    </div>
    """
  end
end
