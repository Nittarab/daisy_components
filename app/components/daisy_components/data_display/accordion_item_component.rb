# frozen_string_literal: true

module DaisyComponents
  module DataDisplay
    class AccordionItemComponent < ViewComponent::Base
      attr_reader :title, :name, :checked, :parent

      def initialize(parent:, title:, name: nil, checked: false, **system_arguments)
        @parent = parent
        @title = title
        @name = name
        @checked = checked
        @system_arguments = system_arguments
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

      attr_reader :system_arguments

      def render_joined_item
        tag.div(**html_attributes, class: joined_classes) do
          render_item_content
        end
      end

      def render_collapse_item
        tag.div(**html_attributes, class: collapse_classes) do
          render_item_content
        end
      end

      def joined_classes
        class_names(
          'collapse join-item',
          { 'collapse-arrow' => parent.arrow && !parent.plus },
          { 'collapse-plus' => parent.plus },
          parent.border_color || 'border border-base-300',
          parent.bg_color || 'bg-base-200',
          system_arguments[:class]
        )
      end

      def collapse_classes
        class_names(
          'collapse',
          { 'collapse-arrow' => parent.arrow && !parent.plus },
          { 'collapse-plus' => parent.plus },
          parent.border_color || 'border border-base-300',
          parent.bg_color || 'bg-base-200',
          system_arguments[:class]
        )
      end

      def html_attributes
        system_arguments.except(:class)
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
        tag.div(class: title_classes) do
          title
        end
      end

      def title_classes
        class_names(
          'collapse-title text-xl font-medium',
          parent.text_color,
          parent.padding
        )
      end

      def render_content
        tag.div(class: content_classes) do
          content
        end
      end

      def content_classes
        class_names(
          'collapse-content',
          parent.text_color,
          parent.padding
        )
      end
    end
  end
end
