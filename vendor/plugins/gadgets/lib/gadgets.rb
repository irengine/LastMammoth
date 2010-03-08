# Gadgets
module ActionView
  module Helpers
    module FormHelper
      def tabular_form_for(record_or_name_or_array, *args, &proc)
        concat("<table>")
        form_for(record_or_name_or_array, (args.extract_options! || {}).merge(:builder => TabularFormBuilder), &proc)
        concat("</table>")
      end

      def fieldset_form_for(record_or_name_or_array, *args, &proc)
        concat("<fieldset>")
        form_for(record_or_name_or_array, (args.extract_options! || {}).merge(:builder => FieldsetFormBuilder), &proc)
        concat("</fieldset>")
      end
    end
    
    class TabularFormBuilder < ActionView::Helpers::FormBuilder
      (field_helpers + %w(date_select file_field) - %w(hidden_field)).each do |selector|
        src = <<-END_SRC
          def #{selector}(field, options = {})
            @template.content_tag("tr",
            @template.content_tag("th", object.class.human_attribute_name(field.to_s) + ":") +
            @template.content_tag("td", super))
          end
        END_SRC
        class_eval src, __FILE__, __LINE__
      end

      def select(method, choices, options = {}, html_options = {})
        @template.content_tag("tr",
          @template.content_tag("th", object.class.human_attribute_name(method.to_s) + ":") +
            @template.content_tag("td", super))
      end

      def submit(field, options = {})
        @template.content_tag("tr", @template.content_tag("td", super, :colspan => "2", :class=> "submit"))
      end
    end

    # name: license_number, Employee_license_number
    class FieldsetFormBuilder < ActionView::Helpers::FormBuilder
      (field_helpers + %w(date_select file_field) - %w(hidden_field)).each do |selector|
        src = <<-END_SRC
          def #{selector}(field, options = {})
            @template.content_tag("p",
            @template.content_tag("label", caption(field.to_s) + ":") + super)
          end
        END_SRC
        class_eval src, __FILE__, __LINE__
      end

      def legend(title)
        @template.content_tag("legend", title)
      end

      def select(method, choices, options = {}, html_options = {})
        @template.content_tag("p",
          @template.content_tag("label", caption(method.to_s) + ":") + super)
      end

      def submit(field, options = {})
        @template.content_tag("p", super, :class=> "submit")
      end

      protected

      def caption(label)
        names = label.split("__")
        if names.length == 1
          object.class.human_attribute_name(label)
        else
          Object.const_get(names[0]).human_attribute_name(names[1])
        end
      end
    end
  end
end