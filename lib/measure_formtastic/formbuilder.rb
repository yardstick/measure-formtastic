module MeasureFormtastic
  class MeasureFormBuilder < ActionView::Helpers::FormBuilder
    def self.configure(name, default = nil)
      class_attribute(name)
      self.send(:"#{name}=", default)
    end

    attr_reader :template

    def initialize(object_name, object, template, options)
      super

      if respond_to?('multipart=') && options.is_a?(Hash) && options[:html]
        self.multipart = options[:html][:multipart]
      end
    end
  end
end
