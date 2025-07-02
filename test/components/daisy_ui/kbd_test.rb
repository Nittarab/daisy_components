# frozen_string_literal: true

require 'test_helper'
# Removed explicit requires, relying on autoloading

module DaisyUI
  # Removed DataDisplay module
  # Ensures it's DaisyUI::KbdTest
  class KbdTest < DaisyUI::ComponentTestCase
    include DaisyUI::PreviewTestConcern

    # KbdPreview should be resolved correctly if its own file is updated (DaisyUI::KbdPreview)
    test_all_preview_examples(preview_class: DaisyUI::KbdPreview, component_name: 'kbd')

    # Playground Tests
    def test_playground_default
      render_preview(:playground)
      assert_selector 'kbd.kbd', text: 'Ctrl'
      assert_no_selector '.kbd-xs'
      assert_no_selector '.kbd-sm'
      assert_no_selector '.kbd-md'
      assert_no_selector '.kbd-lg'
      assert_no_selector '.kbd-xl'
    end

    def test_playground_with_custom_text
      render_preview(:playground, params: { text: 'Shift' })
      assert_selector 'kbd.kbd', text: 'Shift'
    end

    def test_playground_with_size_xs
      render_preview(:playground, params: { size: 'xs' })
      assert_selector 'kbd.kbd.kbd-xs', text: 'Ctrl'
    end

    def test_playground_with_size_sm
      render_preview(:playground, params: { size: 'sm' })
      assert_selector 'kbd.kbd.kbd-sm', text: 'Ctrl'
    end

    def test_playground_with_size_md
      render_preview(:playground, params: { size: 'md' })
      assert_selector 'kbd.kbd.kbd-md', text: 'Ctrl'
    end

    def test_playground_with_size_lg
      render_preview(:playground, params: { size: 'lg' })
      assert_selector 'kbd.kbd.kbd-lg', text: 'Ctrl'
    end

    def test_playground_with_size_xl
      render_preview(:playground, params: { size: 'xl' })
      assert_selector 'kbd.kbd.kbd-xl', text: 'Ctrl'
    end

    def test_playground_with_nil_size
      render_preview(:playground, params: { size: nil })
      assert_selector 'kbd.kbd', text: 'Ctrl'
      assert_no_selector '.kbd-xs'
      assert_no_selector '.kbd-sm'
      assert_no_selector '.kbd-md'
      assert_no_selector '.kbd-lg'
      assert_no_selector '.kbd-xl'
    end

    def test_playground_with_custom_text_and_size
      render_preview(:playground, params: { text: 'Enter', size: 'lg' })
      assert_selector 'kbd.kbd.kbd-lg', text: 'Enter'
    end
  end
end
