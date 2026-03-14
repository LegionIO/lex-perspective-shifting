# frozen_string_literal: true

require_relative 'lib/legion/extensions/perspective_shifting/version'

Gem::Specification.new do |spec|
  spec.name          = 'lex-perspective-shifting'
  spec.version       = Legion::Extensions::PerspectiveShifting::VERSION
  spec.authors       = ['Esity']
  spec.email         = ['matthewdiverson@gmail.com']

  spec.summary       = 'LEX Perspective Shifting'
  spec.description   = 'Systematic multi-viewpoint analysis engine for brain-modeled agentic AI — ' \
                       'cycles through stakeholder, ethical, temporal, and other interpretive frames ' \
                       'to generate richer situational understanding'
  spec.homepage      = 'https://github.com/LegionIO/lex-perspective-shifting'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 3.4'

  spec.metadata['homepage_uri']        = spec.homepage
  spec.metadata['source_code_uri']     = 'https://github.com/LegionIO/lex-perspective-shifting'
  spec.metadata['documentation_uri']   = 'https://github.com/LegionIO/lex-perspective-shifting'
  spec.metadata['changelog_uri']       = 'https://github.com/LegionIO/lex-perspective-shifting'
  spec.metadata['bug_tracker_uri']     = 'https://github.com/LegionIO/lex-perspective-shifting/issues'
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir.glob('{lib,spec}/**/*') + %w[lex-perspective-shifting.gemspec Gemfile]
  end
  spec.require_paths = ['lib']
end
