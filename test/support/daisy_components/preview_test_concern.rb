# frozen_string_literal: true

module DaisyComponents
  module PreviewTestConcern
    extend ActiveSupport::Concern

    class_methods do
      def test_all_preview_examples(preview_class:, component_name:, exclude: nil) # rubocop:disable Metrics/AbcSize
        exclude = Array(exclude).push('playground')
        preview_class.examples.reject { |e| exclude.include?(e) }.each do |example|
          define_method(:"test_#{example}_preview") do
            render_preview(example.to_sym)
            preview_container = page.find_by_id('preview-container')
            fixture_path = fixture_path(component_name, example)

            assert File.exist?(fixture_path), "Fixture file missing: #{fixture_path}"

            fixture = File.read(fixture_path)
            preview = preview_container.native.inner_html

            # Normalize both HTML strings before comparison
            normalized_fixture = normalize_html(fixture)
            normalized_preview = normalize_html(preview)

            assert_equal(
              normalized_fixture,
              normalized_preview,
              error_message(example, normalized_fixture, normalized_preview)
            )
          end
        end
      end
    end

    private

    def error_message(example, fixture, preview)
      [
        "Preview '#{example}' does not match fixture.",
        "Expected:\n#{fixture}",
        "Got:\n#{preview}"
      ].join("\n")
    end

    def fixture_path(component_name, example)
      DaisyComponents::Engine.root.join("test/fixtures/components/#{component_name}/#{example}.html")
    end

    def normalize_html(html)
      # Parse the HTML fragment
      document = Nokogiri::HTML5.fragment(html)

      # Sort classes alphabetically for all elements with class attributes
      document.css('[class]').each do |element|
        classes = element['class'].split.sort.join(' ')
        element['class'] = classes
      end

      # Reorder all attributes alphabetically
      document.css('*').each do |element|
        attributes = element.attributes.keys.sort
        attributes.each do |attr|
          value = element[attr]
          element.remove_attribute(attr)
          element.set_attribute(attr, value)
        end
      end

      # Convert to HTML and remove all whitespace, including newlines
      document.to_html.gsub(/>\s+</, '><').gsub(/\s+/, ' ').delete("\n").squish
    end
  end
end
