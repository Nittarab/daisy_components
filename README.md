# DaisyComponents

DaisyComponents is a Ruby gem that provides a collection of ViewComponents implementing the DaisyUI design system for Rails applications. It combines the power of ViewComponent, TailwindCSS, and DaisyUI to create reusable, maintainable UI components.

## Features

- Built on top of ViewComponent for component-based architecture
- Implements DaisyUI's design system, based on TailwindCSS
- Live preview and documentation with [Lookbook](https://github.com/lookbook-hq/lookbook)
- Comprehensive test coverage with Minitest

## Installation

Add this line to your application's Gemfile:

```ruby
gem "daisy_components"
```

And then execute:
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

## Testing

Run the test suite:

```bash
$ bin/rails test
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b feature/my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin feature/my-new-feature`)
5. Create new Pull Request

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
