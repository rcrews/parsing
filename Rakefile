# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'warbler'
require 'yard'

task default: %i[spec rubocop]

RSpec::Core::RakeTask.new(:spec)

RuboCop::RakeTask.new do |t|
  t.options = [
    '--display-cop-names',
    '--display-style-guide',
    '--extra-details',
    '--auto-correct-all'
  ]
end

YARD::Rake::YardocTask.new do |t|
  # t.files   = ['app/**/*.rb', 'lib/**/*.rb', '-', 'doc/FAQ.md', 'doc/Changes.md']
end

desc 'Make jar'
task :warble do
  sh 'warble' # Warbler::Task.new
end
