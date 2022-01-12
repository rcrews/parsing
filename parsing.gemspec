# frozen_string_literal: true

require_relative 'lib/parsing/version'

Gem::Specification.new do |spec|
  spec.name = 'parsing'
  spec.version = Parsing::VERSION
  spec.authors = ['Robert Crews']
  spec.email = ['rcrews@cloudera.com']

  spec.summary = 'Write a short summary, because RubyGems requires one.'
  spec.description = 'Write a longer description or delete this line.'
  spec.homepage = 'https://github.com/rcrews/parsing/'
  spec.license = 'Apache-2.0'
  spec.required_ruby_version = '>= 2.6'

  # spec.metadata["allowed_push_host"] = "Set to your gem server 'https://example.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  # spec.metadata['source_code_uri'] = "Put your gem's public repo URL here."
  # spec.metadata['changelog_uri'] = "Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'coderay'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-performance'
  spec.add_development_dependency 'rubocop-rake'
  spec.add_development_dependency 'rubocop-rspec'
  spec.add_development_dependency 'warbler'
  spec.add_development_dependency 'yard'

  spec.add_runtime_dependency 'activesupport', '~> 6'
  spec.add_runtime_dependency 'nokogiri', '~> 1.12'

  spec.metadata = {
    'rubygems_mfa_required' => 'true'
  }
end
