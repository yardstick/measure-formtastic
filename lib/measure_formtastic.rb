require 'active_support'

module MeasureFormtastic #:nodoc:
  extend ActiveSupport::Autoload

  autoload :Helpers

  eager_autoload do
    autoload :FormBuilder
  end
end
