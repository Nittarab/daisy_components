---
applyTo: '**'
---

General info
- There should be a component class named ComponentName.
- The class should be under app/components/<namespace>/<component-name>.rb/
- The component class can have subcomponents. The subcomponents can be generic or specific to the parent component.

Workflow:
This project looks more like the portability of a component library from pure CSS as DaisyUI is, to ViewComponets
for this reason when we start working on a new componets the first step is to scrape all the preview

```
./bin/scrape_component <component_name>

```

This create the fixture into the folder
tests/fixture/components/<namespace>/<component-name>/<preview_name>.html

As I said this is not a new library is a porting effort from a CSS framework to a Ruby component library.
For each fixture that we have in the tests/fixture/components/<namespace>/<component-name> folder, we need to create a corresponding preview method in the tests/components/previews/<namespace>/<component-name>_preview.rb file.


For the preview System we are using Lookbook. https://lookbook.build/api

THe preview looks like this

```

      # Active Buttons
      # ---------------
      # Buttons with active state
      def active_buttons
        render_with_template
      end

```

the template is in tests/components/previews/<namespace>/<component-name>_preview/<method_name>.html.erb
if we can't render in 1 line the component otherwise we have the example in the preview 

```

      # Card with a dash border
      # ---------------
      # Example of a card with a dashed border
      def card_with_a_dash_border
        render DaisyUI::Card.new(
          title: 'Card Title',
          description: 'A card component has a figure, a body part, and inside body there are title and actions parts',
          button: { text: 'Buy Now', color: :primary, justify: :end },
          variant: :dash,
          class: 'w-96'
        )
      end
```      

Test:
 - The component needs to be tested. file in tests/components/<namespace>/<component-name>_test.rb
 - The test should use the PreviewTestConcern to test all the preview
 

 The Card components and its subcomponents are a perfect example to learn how to design API and how to approach complex situation.


To ensure that the component is complete and tests, all the Fixture need to be implemented in the tests/components/previews/<namespace>/<component-name>_preview.rb file and we have to archive a 99% of code coverage and branch coverage. To get this information run the comand 
```
COVERAGE=true rails test
```
then. we can reade the coverage.xml with 
```
 ./bin/parse_coverage.rb --file "app/components/daisy_ui/<namespace>/<component-name>.rb"
 ```
