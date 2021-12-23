# frozen_string_literal: true

Warbler::Config.new do |config|
  # The excludes directive excudes only from war....
  # https://github.com/jruby/warbler/blob/master/warble.rb#L20
  # https://www.rubydoc.info/gems/warbler/2.0.5/Warbler/Config#excludes-instance_method
  config.excludes = FileList[
    '.*',
    'bin/',
    'config/',
    'Rakefile',
    'sig/',
    'spec/'
  ]
  config.manifest_file = 'config/MANIFEST.MF'
  # https://github.com/jruby/jruby/issues/5740
  config.features = %w[compiled]
  config.executable = 'exe/parsing'
end
