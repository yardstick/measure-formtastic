module MeasureFormtastic
  module Helpers
    module FormHelper
      # All of the following variables can be modified in `config/initializers/measure_formtastic.rb`

      # Allows the `:builder` option on `:form_for` to be changed.
      @@builder = MeasureFormtastic::FormBuilder
      mattr_accessor :builder

      # Sets the default class added to all `<form>` tags.
      @@default_form_class = 'ys_form'
      mattr_accessor :default_form_class

      # Custom proc to handle class inferred from the model's name (Post will be 'post')
      @@default_form_model_class_proc = proc { |klass_name| klass_name }
      mattr_accessor :default_form_model_class_proc

      @@ys_formtastic_field_error_proc = proc { |html_tag, instance_tag| html_tag }
      mattr_accessor :ys_formtastic_field_error_proc

      # The wrapper for the default Rails form builder. You can still access all of the built-in form helper
      # methods such as `text_field`, etc.
      #
      # Use instead of `form_for`.
      def ys_form_for(thing, *args, &proc)
        options = args.extract_options!
        options[:builder] ||= @@builder
        options[:html] ||= {}
        options[:html][:novalidate] = !@@builder.perform_browser_validations unless options[:html].key?(:novalidate)
        options[:custom_namespace] = options.delete(:namespace)

        singularizer = if defined?(ActiveModel::Naming.singular)
          ActiveModel::Naming.method(:singular)
        else
          ActionController::RecordIdentifier.method(:singular_class_name)
        end

        class_names = options[:html][:class] ? options[:html][:class].split(' ') : []
        class_names << @@default_form_class

        # Ex. The class will be 'datepicker' when you specify `:as => :datepicker`.
        # Otherwise, use the model's class.
        model_class_name = case thing
          when String, Symbol then thing.to_s # :post => 'post'
          when Array then options[:as] || singularizer.call(thing[-1].class) # [@post, @comment] => 'comment'
          else options[:as] || singularizer.call(thing.class) # @post => 'post'
        end
        class_names << @@default_form_model_class_proc.call(model_class_name)

        options[:html][:class] = class_names.compact.join(' ')

        with_custom_field_error_proc do
          self.form_for(thing, *(args << options), &proc)
        end
      end

      # Use instead of `fields_for`
      def ys_fields_for(record_name, record_object = nil, options = {}, &block)
        options, record_object = record_object, nil if record_object.is_a?(Hash)
        options[:builder] ||= @@builder
        options[:custom_namespace] = options.delete(:namespace)

        with_custom_field_error_proc do
          self.fields_for(record_name, record_object, options, &block)
        end
      end

    protected

      def with_custom_field_error_proc(&block)
        default_field_error_proc = ::ActionView::Base.field_error_proc
        ::ActionView::Base.field_error_proc = @@ys_formtastic_field_error_proc
        yield
      ensure
        ::ActionView::Base.field_error_proc = default_field_error_proc
      end
    end
  end
end
