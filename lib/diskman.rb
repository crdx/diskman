require 'require_all'
require 'colorize'

require 'ostruct'

module Diskman
    def self.root_dir
        File.expand_path('../..', __FILE__)
    end
end

require_rel 'diskman'
