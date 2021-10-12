require 'require_all'
require 'colorize'

require 'ostruct'

module Diskman
    def self.root_dir
        File.expand_path('..', __dir__)
    end
end

require_rel 'diskman'
