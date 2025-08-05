# Accordion Component

The Accordion component allows you to create collapsible content sections. It's useful for FAQs, navigation menus, and any content that needs to be shown/hidden.

## Basic Usage

```erb
<%= render(DaisyComponents::AccordionComponent.new) do |component| %>
  <%= component.with_item(title: "Section 1") do %>
    Content for section 1
  <% end %>
  <%= component.with_item(title: "Section 2") do %>
    Content for section 2
  <% end %>
<% end %>
```

## Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `join` | Boolean | `false` | Join items together with borders |
| `arrow` | Boolean | `false` | Show arrow indicators |
| `plus` | Boolean | `false` | Show plus/minus indicators |
| `radio` | Boolean | `false` | Only allow one item open at a time |
| `class` | String | `nil` | Additional CSS classes |

## Item Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `title` | String/HTML | Required | The title of the accordion item |
| `name` | String | `nil` | Required for radio mode to group items |
| `checked` | Boolean | `false` | Whether the item is initially open |

## Examples

### Arrow Style

```erb
<%= render(DaisyComponents::AccordionComponent.new(arrow: true)) do |component| %>
  <%= component.with_item(title: "Click me") do %>
    This content can be shown or hidden
  <% end %>
<% end %>
```

### Plus/Minus Style

```erb
<%= render(DaisyComponents::AccordionComponent.new(plus: true)) do |component| %>
  <%= component.with_item(title: "Expand me") do %>
    Expandable content here
  <% end %>
<% end %>
```

### Radio Style (Single Open)

```erb
<%= render(DaisyComponents::AccordionComponent.new(radio: true)) do |component| %>
  <%= component.with_item(title: "Item 1", name: "group1", checked: true) do %>
    First item content
  <% end %>
  <%= component.with_item(title: "Item 2", name: "group1") do %>
    Second item content
  <% end %>
<% end %>
```

### Joined Style

```erb
<%= render(DaisyComponents::AccordionComponent.new(join: true, arrow: true)) do |component| %>
  <%= component.with_item(title: "Section 1") do %>
    First section content
  <% end %>
  <%= component.with_item(title: "Section 2") do %>
    Second section content
  <% end %>
<% end %>
```

### Rich Content

```erb
<%= render(DaisyComponents::AccordionComponent.new(arrow: true)) do |component| %>
  <%= component.with_item(title: tag.div(class: "flex items-center gap-2") do %>
    <%= tag.svg(class: "h-5 w-5", fill: "none", viewBox: "0 0 24 24", stroke: "currentColor") do %>
      <%= tag.path(stroke_linecap: "round", stroke_linejoin: "round", stroke_width: 2,
                  d: "M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z") %>
    <% end %>
    Important Information
  <% end %>) do %>
    <div class="prose">
      <p>Rich content with HTML formatting</p>
      <ul>
        <li>Support for icons</li>
        <li>HTML content</li>
        <li>Custom styling</li>
      </ul>
    </div>
  <% end %>
<% end %>
```

## Styling

The component can be styled using DaisyUI and Tailwind classes:

- Use `prose` class for rich text content
- Use `flex` and `gap` utilities for complex titles
- Use border utilities to customize borders
- Use text utilities for title formatting

## Accessibility

The accordion component is built with accessibility in mind:
- Uses semantic HTML structure
- Keyboard navigable
- ARIA attributes for state
- Screen reader friendly

## Best Practices

1. **Content Organization**
   - Group related content together
   - Keep titles concise and descriptive
   - Use appropriate heading levels

2. **Interaction Design**
   - Use arrow style for navigation menus
   - Use plus/minus for expandable content
   - Use radio style for mutually exclusive content

3. **Performance**
   - Avoid deeply nested accordions
   - Keep content reasonably sized
   - Use lazy loading for heavy content 
