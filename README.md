[![codecov](https://codecov.io/github/Nittarab/daisy_components/graph/badge.svg?token=7ZOMOEG3U9)](https://codecov.io/github/Nittarab/daisy_components)

# DaisyComponents

DaisyComponents is a Ruby gem that provides a collection of ViewComponents implementing the DaisyUI design system for Rails applications. It combines the power of ViewComponent, TailwindCSS, and DaisyUI to create reusable, maintainable UI components.

## Features

- Built on top of ViewComponent for component-based architecture
- Implements DaisyUI's design system, based on TailwindCSS
- Live preview and documentation with [Lookbook](https://github.com/lookbook-hq/lookbook)
- Comprehensive test coverage with Minitest

## Installation

If you are using [mise](https://mise.jdx.dev/) for managing your development tools and environment, ensure you have it installed. You can find the installation instructions [here](https://mise.jdx.dev/getting-started.html).

Once mise is set up, you can install the required Ruby version (as specified in the `.tool-versions` file) by running:

```bash
$ mise install
```

Next, add this line to your application's Gemfile:

```ruby
gem "daisy_components"
```

And then execute to install the gem and other dependencies:
```bash
$ bundle install
```

## Usage
The component library includes Lookbook for development and documentation:

1. Start the development server:
```bash
$ bin/rails server
```

2. Visit http://localhost:3000/lookbook to see the component documentation and playground.

![alt text](<docs/assets/2025-01_screeshot_1.png>)
![alt text](<docs/assets/2025-01_screeshot_2.png>)
![alt text](<docs/assets/2025-01_screeshot_3.png>)

## Testing

Run the test suite:

```bash
$ bin/rails test
```

With coverage:
```bash
$ COVERAGE=true bin/rails test
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b feature/my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin feature/my-new-feature`)
5. Create new Pull Request

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
