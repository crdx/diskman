module Diskman
    class Mount
        def self.is_mounted(name)
            Mount.new.find(name)
        end

        def self.get_mount_point(name)
            Mount.new.find(name).chomp.match(/[^ ]+ (?<m>[^ ]+)/)[:m]
        end

        def find(name)
            lines.grep(%r[^/dev/#{name}\d?\s+]).first
        end

        private

        def lines
            @lines ||= File.read('/etc/mtab').lines
        end
    end
end
