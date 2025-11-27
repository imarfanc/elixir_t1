# Components Library

This page showcases various UI components and patterns used throughout the application.

## Interactive Card Component

Here's an advanced card component with hover effects and animations:

```elixir
defmodule ElixirT1Web.Components.Card do
  use Phoenix.Component

  @doc """
  Renders an interactive card with optional image, title, and actions.

  ## Examples

      <.card title="Welcome" image="/images/hero.jpg">
        <p>This is the card content</p>
        <:actions>
          <.button>Learn More</.button>
        </:actions>
      </.card>
  """
  attr :title, :string, required: true
  attr :image, :string, default: nil
  attr :class, :string, default: nil
  
  slot :inner_block, required: true
  slot :actions

  def card(assigns) do
    ~H"""
    <div class={[
      "group relative overflow-hidden rounded-2xl bg-white shadow-lg",
      "transition-all duration-300 hover:shadow-2xl hover:-translate-y-1",
      @class
    ]}>
      <%= if @image do %>
        <div class="aspect-video overflow-hidden">
          <img 
            src={@image} 
            alt={@title}
            class="w-full h-full object-cover transition-transform duration-300 group-hover:scale-110"
          />
        </div>
      <% end %>
      
      <div class="p-6">
        <h3 class="text-2xl font-bold text-gray-900 mb-4">
          {@title}
        </h3>
        
        <div class="text-gray-600 space-y-3">
          <%= render_slot(@inner_block) %>
        </div>
        
        <%= if @actions != [] do %>
          <div class="mt-6 flex gap-3">
            <%= render_slot(@actions) %>
          </div>
        <% end %>
      </div>
      
      <!-- Decorative gradient overlay -->
      <div class="absolute inset-0 bg-gradient-to-br from-blue-500/0 to-purple-500/0 
                  group-hover:from-blue-500/5 group-hover:to-purple-500/5 
                  transition-all duration-300 pointer-events-none">
      </div>
    </div>
    """
  end
end
```

## Modal Component

A fully accessible modal dialog with backdrop:

```elixir
defmodule ElixirT1Web.Components.Modal do
  use Phoenix.Component
  import Phoenix.LiveView

  attr :id, :string, required: true
  attr :show, :boolean, default: false
  attr :on_cancel, JS, default: %JS{}
  
  slot :inner_block, required: true
  slot :title
  slot :footer

  def modal(assigns) do
    ~H"""
    <div
      id={@id}
      phx-mounted={@show && show_modal(@id)}
      phx-remove={hide_modal(@id)}
      class="relative z-50 hidden"
    >
      <!-- Backdrop -->
      <div 
        id={"#{@id}-backdrop"}
        class="fixed inset-0 bg-black/50 backdrop-blur-sm transition-opacity"
        aria-hidden="true"
      />
      
      <!-- Modal panel -->
      <div class="fixed inset-0 overflow-y-auto">
        <div class="flex min-h-full items-center justify-center p-4">
          <div
            id={"#{@id}-panel"}
            class="relative max-w-2xl w-full bg-white rounded-2xl shadow-2xl 
                   transform transition-all"
          >
            <!-- Header -->
            <%= if @title != [] do %>
              <div class="px-6 py-4 border-b border-gray-200">
                <h2 class="text-xl font-semibold text-gray-900">
                  <%= render_slot(@title) %>
                </h2>
              </div>
            <% end %>
            
            <!-- Content -->
            <div class="px-6 py-4">
              <%= render_slot(@inner_block) %>
            </div>
            
            <!-- Footer -->
            <%= if @footer != [] do %>
              <div class="px-6 py-4 border-t border-gray-200 flex justify-end gap-3">
                <%= render_slot(@footer) %>
              </div>
            <% end %>
            
            <!-- Close button -->
            <button
              phx-click={@on_cancel}
              type="button"
              class="absolute top-4 right-4 text-gray-400 hover:text-gray-600"
              aria-label="Close"
            >
              <svg class="w-6 h-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
              </svg>
            </button>
          </div>
        </div>
      </div>
    </div>
    """
  end

  defp show_modal(id) do
    %JS{}
    |> JS.show(to: "##{id}")
    |> JS.show(
      to: "##{id}-backdrop",
      transition: {"transition-opacity ease-out duration-300", "opacity-0", "opacity-100"}
    )
    |> JS.show(
      to: "##{id}-panel",
      transition: {"transition-all ease-out duration-300", "opacity-0 scale-95", "opacity-100 scale-100"}
    )
  end

  defp hide_modal(id) do
    %JS{}
    |> JS.hide(
      to: "##{id}-backdrop",
      transition: {"transition-opacity ease-in duration-200", "opacity-100", "opacity-0"}
    )
    |> JS.hide(
      to: "##{id}-panel",
      transition: {"transition-all ease-in duration-200", "opacity-100 scale-100", "opacity-0 scale-95"}
    )
    |> JS.hide(to: "##{id}", transition: {"block", "block", "hidden"})
  end
end
```

## Usage Examples

### Card Component in Action

```elixir
<.card title="Phoenix LiveView" image="/images/phoenix.jpg">
  <p>Build rich, real-time user experiences with server-rendered HTML.</p>
  <p class="text-sm text-gray-500">No JavaScript framework needed!</p>
  
  <:actions>
    <.button type="button">Get Started</.button>
    <.button type="button" class="bg-gray-200 text-gray-800">Learn More</.button>
  </:actions>
</.card>
```

### Modal Component in Action

```elixir
<.modal id="confirm-modal" show={@show_modal} on_cancel={JS.push("close_modal")}>
  <:title>Confirm Action</:title>
  
  <p>Are you sure you want to proceed with this action?</p>
  
  <:footer>
    <.button phx-click="close_modal" class="bg-gray-200 text-gray-800">
      Cancel
    </.button>
    <.button phx-click="confirm" class="bg-red-600 hover:bg-red-700">
      Confirm
    </.button>
  </:footer>
</.modal>
```

## Component Best Practices

1. **Always use slots** for flexible content composition
2. **Provide sensible defaults** for optional attributes
3. **Include documentation** with `@doc` and examples
4. **Use Tailwind classes** for consistent styling
5. **Add transitions** for smooth user interactions
6. **Make components accessible** with proper ARIA attributes
