# encoding: utf-8
require 'active_support'

module MeasureFormtastic
  extend ActiveSupport::Autoload

  autoload :Helpers

  eager_autoload do
    autoload :FormBuilder
  end
end
