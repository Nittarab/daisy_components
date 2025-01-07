# frozen_string_literal: true

module DaisyComponents
  module DataDisplay
    class AccordionItemComponent < ViewComponent::Base
      attr_reader :title, :name, :checked, :parent

      def initialize(parent:, title:, name: nil, checked: false)
        @parent = parent
        @title = title
        @name = name
        @checked = checked
        super()
      end

      def call
        if parent.join
          render_joined_item
        else
          render_collapse_item
        end
      end

      private

      def render_joined_item
        tag.div(class: 'collapse collapse-arrow join-item border border-base-300') do
          render_item_content
        end
      end

      def render_collapse_item
        tag.div(class: collapse_classes) do
          render_item_content
        end
      end

      def collapse_classes
        class_names(
          'collapse',
          'collapse-arrow': parent.arrow && !parent.plus,
          'collapse-plus': parent.plus,
          'border border-base-300 bg-base-200': true
        )
      end

      def render_item_content
        safe_join([
                    render_input,
                    render_title,
                    render_content
                  ])
      end

      def render_input
        if parent.radio
          tag.input(type: 'radio', name: name, checked: checked)
        else
          tag.input(type: 'checkbox', checked: checked)
        end
      end

      def render_title
        tag.div(class: 'collapse-title text-xl font-medium') do
          title
        end
      end

      def render_content
        tag.div(class: 'collapse-content') do
          content
        end
      end
    end
  end
end
