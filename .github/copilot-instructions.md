# DaisyComponents AI Coding Instructions

This is a Rails Engine providing ViewComponents for the DaisyUI design system. Understanding the namespace collapsing, testing patterns, and component structure is crucial for effective development.

## Architecture & Namespace Collapsing

**Critical**: This project uses Zeitwerk autoloader with collapsed namespaces. Component classes are flattened despite directory structure:

- **File**: `app/components/daisy_ui/actions/button.rb` → **Class**: `DaisyUI::Button` (NOT `DaisyUI::Actions::Button`)
- **Usage**: `render DaisyUI::Button.new(...)` (ONLY correct way)
- **Wrong**: `DaisyUI::Actions::Button` or `ButtonComponent` (conflicts with preview classes)

**However**: Preview and test classes keep nested modules (`DaisyUI::Actions::ButtonPreview`, `DaisyUI::Actions::ButtonTest`).

The collapse happens in `lib/daisy_ui/engine.rb` via `autoloader.collapse(root.join('app/components/daisy_ui/**'))`.

## Component Development Patterns

### Base Component Structure
All components inherit from `DaisyUI::BaseComponent` which provides:
- `build_argument()` method for validating enum-like parameters
- `classes` helper using `class_names()`
- `@system_arguments` pattern for additional HTML attributes

### Component Classes
```ruby
module DaisyUI
  class Button < BaseComponent
    def initialize(text:, icon: nil, **options)
      # Never use IconsHelper directly in components
      # Icons passed as parameters from previews/views
    end
  end
end
```

## Testing Strategy

### Automated Preview Testing
Every component uses `PreviewTestConcern` for comprehensive fixture-based testing:

```ruby
module DaisyUI
  module Actions
    class ButtonTest < DaisyUI::ComponentTestCase
      include DaisyUI::PreviewTestConcern
      
      test_all_preview_examples(
        preview_class: ButtonPreview,
        component_name: 'button',
        exclude: ['playground'] # Optional exclusions
      )
    end
  end
end
```

**How it works**: Each preview method auto-tests against HTML fixtures in `test/fixtures/components/<component>/<method>.html`. Tests normalize HTML and compare exact output.

### Preview Structure
Preview files follow strict patterns (`test/components/previews/daisy_ui/`):

```ruby
# @label ComponentName
module DaisyUI
  module Actions  # Keep nested modules for previews/tests
    class ComponentPreview < ViewComponent::Preview
      include DaisyUI::IconsHelper # For icons in previews
      
      # @!group Playground
      def playground(...) # Interactive component with all parameters
      # @!endgroup
      
      def example_method_name # Maps to fixture file
        render DaisyUI::Component.new(...) # Component class is collapsed
      end
    end
  end
end
```

## Icon System

**Phosphor Icons** via `DaisyUI::IconsHelper`:
- **In Components**: Accept icons as parameters (`icon: nil`)
- **In Previews/Tests**: Use helper methods (`home_icon`, `github_icon`)
- **Available Icons**: Check `ICONS` constant in `app/helpers/daisy_ui/icons_helper.rb`

## Development Workflow

### Environment Setup
For setting up the development environment, use the automated setup script:
```bash
# Automated environment setup (recommended)
./bin/setup
```

This script will automatically:
- Install mise if not present
- Install the latest Ruby version
- Install Bundler
- Run `bundle install` to install dependencies

### Key Commands
```bash
# Start Lookbook development server
bin/rails server  # → http://localhost:3000/lookbook

# Run tests with coverage
COVERAGE=true bin/rails test

# Code quality checks
./bin/fix_trailing_newlines.sh --check-only
bin/rubocop

# Git hooks setup (one-time)
./bin/setup_hooks.sh
```

### File Organization
- **Components**: `app/components/daisy_ui/{actions,data_display,layout,navigation}/`
- **Previews**: `test/components/previews/daisy_ui/` (mirror component structure)
- **Tests**: `test/components/daisy_ui/` (mirror component structure)
- **Fixtures**: `test/fixtures/components/<component_name>/<example>.html`
- **Test Base**: `test/components/daisy_ui/component_test_case.rb`

## Ruby Style Conventions

**Namespace Style**: Use nested modules, not collapsed class names:
```ruby
# Good
module DaisyUI
  module Actions
    class ButtonTest < DaisyUI::ComponentTestCase
    end
  end
end

# Bad - conflicts with namespace collapsing
class DaisyComponents::ButtonTest < DaisyComponents::ComponentTestCase
end
```

## Dependencies & Integration

- **Core**: Rails 7+, ViewComponent, DaisyUI/TailwindCSS
- **Documentation**: Lookbook (development only)
- **Testing**: Minitest, Capybara, fixture-based comparison
- **Quality**: RuboCop, trailing newline checks, git hooks

The engine configures Lookbook with component grouping (`Actions`, `Data Display`, etc.) and sets up autoloader inflection for `daisy_ui` → `DaisyUI`.
