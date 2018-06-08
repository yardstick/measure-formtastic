# encoding: utf-8
$:.push File.expand_path("../lib", __FILE__)
require 'measure_formtastic/version'

Gem::Specification.new do |s|
  s.name = %q{measure_formtastic}
  s.authors = ['Alecia Vogel']
  s.email = ['a.vogel@yas.getyardstick.com']
  s.version = MeasureFormtastic::VERSION
  s.date = %q{2018-06-08}
  s.summary = %q{A custom formbuilder for Measure, modified from the original Formtastic DSL, versions 0.2.3 and 1.2.3}
  s.license = %q{MIT}

  s.require_paths = %w[lib]
  s.files = `git ls-files -z`.split("\x0")
  s.executables = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.post_install_message = %q{}

  s.add_runtime_dependency('activesupport', '>= 2.0.0')
end
