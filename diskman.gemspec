require_relative 'lib/diskman/version'

Gem::Specification.new do |spec|
    spec.homepage = 'https://github.com/crdx/diskman'
    spec.summary = 'Interactive command line interface for safely managing disks'
    spec.name = 'diskman'
    spec.version = Diskman::VERSION
    spec.author = 'crdx'
    spec.license = 'GPLv3'
    spec.metadata['rubygems_mfa_required'] = 'true'

    spec.required_ruby_version = '>= 3.0'

    spec.files = Dir['lib/**/*']
    spec.executables = ['diskman']

    spec.add_dependency 'colorize', '~> 0.8.1'
    spec.add_dependency 'docopt', '~> 0.6.1'
    spec.add_dependency 'require_all', '~> 3.0'

    spec.add_development_dependency 'rake', '~> 13.0'
end
