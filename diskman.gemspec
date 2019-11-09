require_relative 'lib/diskman/version'

Gem::Specification.new do |spec|
    spec.homepage = 'https://github.com/crdx/diskman'
    spec.summary  = 'Interactive command line interface for safely managing disks'
    spec.name     = 'diskman'
    spec.version  = Diskman::VERSION
    spec.author   = 'crdx'
    spec.license  = 'MIT'

    spec.files    = Dir['{lib,res}/**/*']
    spec.executables = ['diskman']

    spec.add_runtime_dependency 'require_all', '~> 2.0'
    spec.add_runtime_dependency 'colorize',    '~> 0.8.1'
    spec.add_runtime_dependency 'docopt',      '~> 0.6.1'

    spec.add_development_dependency 'simplecov', '~> 0.17.0'
    spec.add_development_dependency 'rspec',     '~> 3.8'
    spec.add_development_dependency 'rake',      '~> 12.3'
end
