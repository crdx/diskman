require 'colorize'

require 'ostruct'

module Diskman
    def self.root_dir
        File.expand_path('..', __dir__)
    end
end

require_relative 'diskman/chooser'
require_relative 'diskman/commands/choose_device'
require_relative 'diskman/commands/choose_partition'
require_relative 'diskman/commands/clone'
require_relative 'diskman/commands/fdisk'
require_relative 'diskman/commands/ls'
require_relative 'diskman/commands/mkfs'
require_relative 'diskman/commands/write'
require_relative 'diskman/confirmer'
require_relative 'diskman/device'
require_relative 'diskman/mount'
require_relative 'diskman/root_device'
require_relative 'diskman/system'
require_relative 'diskman/version'
