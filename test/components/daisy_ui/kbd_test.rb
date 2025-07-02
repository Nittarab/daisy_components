# frozen_string_literal: true

require "test_helper"
# Removed explicit requires, relying on autoloading

module DaisyUI
  # Removed DataDisplay module
  class KbdTest < DaisyUI::ComponentTestCase # Ensures it's DaisyUI::KbdTest
    include DaisyUI::PreviewTestConcern

    # KbdPreview should be resolved correctly if its own file is updated (DaisyUI::KbdPreview)
    test_all_preview_examples(preview_class: DaisyUI::KbdPreview, component_name: "kbd")
  end
end
