# frozen_string_literal: true

require 'test_helper'

module DaisyComponents
  module DataDisplay
    class AvatarGroupComponentTest < DaisyComponents::ComponentTestCase
      include DaisyComponents::PreviewTestConcern

      test_all_preview_examples(preview_class: AvatarGroupComponentPreview, component_name: 'avatar_group')
    end
  end
end
