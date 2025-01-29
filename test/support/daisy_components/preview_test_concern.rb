# frozen_string_literal: true

module DaisyComponents
  module PreviewTestConcern
    extend ActiveSupport::Concern

    class_methods do
      def test_all_preview_examples(preview_class, component_name, exclude: ['playground']) # rubocop:disable Metrics/AbcSize
        exclude = Array(exclude)
        preview_class.examples.reject { |e| exclude.include?(e) }.each do |example|
          define_method(:"test_#{example}_preview") do
            render_preview(example.to_sym)
            preview_container = page.find_by_id('preview-container')
            fixture_path = fixture_path(component_name, example)

            assert File.exist?(fixture_path), "Fixture file missing: #{fixture_path}"

            fixture = File.read(fixture_path)
            normalized_fixture = normalize_html(fixture)
            normalized_preview = normalize_html(preview_container.native.inner_html)

            assert_preview_matches_fixture(example, normalized_fixture, normalized_preview)
          end
        end
      end
    end

    private

    def normalize_html(html)
      doc = Nokogiri::HTML.fragment(html)
      doc.css('button').each do |button|
        button.attributes.each_key do |attr|
          button.remove_attribute(attr) unless attr == 'class'
        end
      end
      doc.to_html.gsub(/\s+/, ' ').gsub(/>\s+</, '><').strip
    end

    def error_message(example, fixture, preview)
      [
        "Preview '#{example}' does not match fixture.",
        "Expected:\n#{fixture}",
        "Got:\n#{preview}"
      ].join("\n")
    end

    def assert_preview_matches_fixture(example, fixture, preview)
      assert_equal(
        normalize_html(fixture),
        normalize_html(preview),
        error_message(example, fixture, preview)
      )
    end

    def fixture_path(component_name, example)
      DaisyComponents::Engine.root.join("test/fixtures/components/#{component_name}/#{example}.html")
    end
  end
end
