# frozen_string_literal: true

require 'test_helper'

class DaisyComponents::Actions::SwapComponentTest < DaisyComponents::ComponentTestCase
  include ActionView::Helpers::TagHelper

  def test_renders_basic_swap
    render_inline(DaisyComponents::Actions::SwapComponent.new) do |component|
      component.with_on { 'ON' }
      component.with_off { 'OFF' }
    end

    assert_selector('label.swap')
    assert_selector('.swap-on', text: 'ON')
    assert_selector('.swap-off', text: 'OFF')
    assert_selector('input[type="checkbox"]', visible: false)
  end

  def test_renders_with_rotate
    render_inline(DaisyComponents::Actions::SwapComponent.new(rotate: true)) do |component|
      component.with_on { 'ON' }
      component.with_off { 'OFF' }
    end

    assert_selector('label.swap.swap-rotate')
  end

  def test_renders_with_flip
    render_inline(DaisyComponents::Actions::SwapComponent.new(flip: true)) do |component|
      component.with_on { 'ON' }
      component.with_off { 'OFF' }
    end

    assert_selector('label.swap.swap-flip')
  end

  def test_renders_active_state
    render_inline(DaisyComponents::Actions::SwapComponent.new(active: true)) do |component|
      component.with_on { 'ON' }
      component.with_off { 'OFF' }
    end

    assert_selector('label.swap.swap-active')
  end

  def test_renders_with_custom_classes
    render_inline(DaisyComponents::Actions::SwapComponent.new(class: 'btn btn-ghost btn-circle')) do |component|
      component.with_on { 'ON' }
      component.with_off { 'OFF' }
    end

    assert_selector('label.swap')
    assert_selector('label.btn')
    assert_selector('label.btn-ghost')
    assert_selector('label.btn-circle')
  end

  def test_renders_with_indeterminate_state
    render_inline(DaisyComponents::Actions::SwapComponent.new) do |component|
      component.with_on { 'ON' }
      component.with_off { 'OFF' }
      component.with_indeterminate { 'LOADING' }
    end

    assert_selector('.swap-indeterminate', text: 'LOADING')
  end

  def test_renders_with_svg_content
    render_inline(DaisyComponents::Actions::SwapComponent.new) do |component|
      component.with_on do
        '<svg class="h-6 w-6"><path d="M1 1"/></svg>'.html_safe
      end
      component.with_off do
        '<svg class="h-6 w-6"><path d="M2 2"/></svg>'.html_safe
      end
    end

    assert_selector('.swap-on svg.h-6.w-6')
    assert_selector('.swap-off svg.h-6.w-6')
  end

  def test_combines_multiple_modifiers
    render_inline(DaisyComponents::Actions::SwapComponent.new(
                    rotate: true,
                    flip: true,
                    active: true,
                    class: 'custom-class'
                  )) do |component|
      component.with_on { 'ON' }
      component.with_off { 'OFF' }
    end

    assert_selector('label.swap')
    assert_selector('label.swap-rotate')
    assert_selector('label.swap-flip')
    assert_selector('label.swap-active')
    assert_selector('label.custom-class')
  end
end
