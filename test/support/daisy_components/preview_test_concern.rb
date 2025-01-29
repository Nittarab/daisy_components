# frozen_string_literal: true

module DaisyComponents
  module PreviewTestConcern
    extend ActiveSupport::Concern

    class_methods do
      def test_all_preview_examples(preview_class, component_name, exclude: ['playground'])
        exclude = Array(exclude)
        preview_class.examples.reject { |e| exclude.include?(e) }.each do |example|
          define_method(:"test_#{example}_preview") do
            render_preview(example.to_sym)
            preview_container = page.find_by_id('preview-container')
            fixture_path = DaisyComponents::Engine.root.join("test/fixtures/components/#{component_name}/#{example}.html")

            assert File.exist?(fixture_path), "Fixture file missing: #{fixture_path}"

            fixture = File.read(fixture_path)
            normalized_fixture = normalize_html(fixture)
            normalized_preview = normalize_html(preview_container.native.inner_html)

            assert_equal(
              normalized_fixture,
              normalized_preview,
              "Preview '#{example}' does not match fixture.\nExpected:\n#{normalized_fixture}\n\nGot:\n#{normalized_preview}"
            )
          end
        end
      end
    end

    private

    def normalize_html(html)
      doc = Nokogiri::HTML.fragment(html)
      doc.css('button').each do |button|
        button.attributes.keys.each do |attr|
          button.remove_attribute(attr) unless attr == 'class'
        end
      end
      doc.to_html.gsub(/\s+/, ' ').gsub(/>\s+</, '><').strip
    end
  end
end
