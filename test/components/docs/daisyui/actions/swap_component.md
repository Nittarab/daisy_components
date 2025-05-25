# Swap Component

The Swap component allows you to toggle between two states with a smooth animation. It's useful for creating toggles, hamburger menus, theme switchers, or any other UI element that needs to switch between two states.

## Basic Usage

```erb
<%= render(DaisyComponents::Actions::SwapComponent.new) do |component| %>
  <%= component.with_on { "ON" } %>
  <%= component.with_off { "OFF" } %>
<% end %>
```

## Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `rotate` | Boolean | `false` | Enables rotation animation |
| `flip` | Boolean | `false` | Enables flip animation |
| `active` | Boolean | `false` | Sets the initial active state |
| `class` | String | `nil` | Additional CSS classes |

## Slots

- `on`: Content to show in the ON state
- `off`: Content to show in the OFF state
- `indeterminate`: Content to show in the indeterminate state (optional)

## Examples

### Simple Text Swap

Basic text swap with primary color:

```erb
<%= render(DaisyComponents::Actions::SwapComponent.new) do |component| %>
  <%= component.with_on do %>
    <div class="font-bold text-primary">ON</div>
  <% end %>
  <%= component.with_off do %>
    <div class="font-bold text-base-content">OFF</div>
  <% end %>
<% end %>
```

### Emoji Swap with Flip

Fun emoji swap with flip animation:

```erb
<%= render(DaisyComponents::Actions::SwapComponent.new(flip: true)) do |component| %>
  <%= component.with_on do %>
    <div class="text-2xl">😄</div>
  <% end %>
  <%= component.with_off do %>
    <div class="text-2xl">😴</div>
  <% end %>
<% end %>
```

### Hamburger Menu Button

Classic hamburger menu with rotate animation:

```erb
<%= render(DaisyComponents::Actions::SwapComponent.new(rotate: true, class: "btn btn-ghost btn-circle")) do |component| %>
  <%= component.with_on do %>
    <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
    </svg>
  <% end %>
  <%= component.with_off do %>
    <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
    </svg>
  <% end %>
<% end %>
```

### Theme Toggle

Theme toggle with sun/moon icons and rotate animation:

```erb
<%= render(DaisyComponents::Actions::SwapComponent.new(rotate: true, class: "btn btn-ghost btn-circle")) do |component| %>
  <%= component.with_on do %>
    <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 3v1m0 16v1m9-9h-1M4 12H3m15.364 6.364l-.707-.707M6.343 6.343l-.707-.707m12.728 0l-.707.707M6.343 17.657l-.707.707M16 12a4 4 0 11-8 0 4 4 0 018 0z" />
    </svg>
  <% end %>
  <%= component.with_off do %>
    <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z" />
    </svg>
  <% end %>
<% end %>
```

### Loading State with Indeterminate

Example using the indeterminate state for loading:

```erb
<%= render(DaisyComponents::Actions::SwapComponent.new(class: "btn")) do |component| %>
  <%= component.with_on do %>
    <span class="flex items-center gap-2">
      Save
      <svg class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
      </svg>
    </span>
  <% end %>
  <%= component.with_off do %>
    <span>Save</span>
  <% end %>
  <%= component.with_indeterminate do %>
    <span class="flex items-center gap-2">
      <svg class="h-4 w-4 animate-spin" fill="none" viewBox="0 0 24 24">
        <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
        <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
      </svg>
      Saving...
    </span>
  <% end %>
<% end %>
```

## Styling

The component can be styled using DaisyUI and Tailwind classes:

- Use `btn` classes for button-like swaps
- Use text utility classes for text content
- Use size utilities for different dimensions
- Use color utilities for different states

## Accessibility

The swap component is built with accessibility in mind:
- Uses semantic HTML with `label` and `input` elements
- Keyboard navigable with Tab and Space/Enter
- State changes are reflected in the DOM structure
- Works with screen readers
- Supports ARIA attributes

## Best Practices

1. **Animation Choice**
   - Use `rotate` for hamburger menus and circular icons
   - Use `flip` for emoji or text that reads well upside down
   - Use no animation for simple toggles

2. **Button Styling**
   - Add `btn` class for clickable buttons
   - Use `btn-ghost` for subtle buttons
   - Use `btn-circle` for round buttons

3. **Size Consistency**
   - Keep icon sizes consistent (e.g., `h-6 w-6`)
   - Use standard button sizes when applicable
   - Maintain padding and spacing 