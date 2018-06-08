# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'measure_formtastic/version'

Gem::Specification.new do |s|
  s.name = %q{measure_formtastic}
  s.authors = ['Alecia Vogel']
  s.email = ['a.vogel@yas.getyardstick.com']
  s.version = MeasureFormtastic::VERSION
  s.date = %q{2018-06-08}
  s.summary = %q{A custom formbuilder for Measure, modified from the original Formtastic DSL, versions 0.2.3 and 1.2.3}
  s.files = Dir.glob("lib/**/*")
  s.license = %q{MIT}
  s.require_paths = ["lib"]
  s.post_install_message = %q{}

  s.add_dependency(%q<i18n>, ['>= 0.4'])
  s.add_dependency(%q<activesupport>, ['>= 0.2'])
end
