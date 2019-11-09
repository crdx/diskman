module Diskman
    class Mtab
        def self.mounted?(name)
            new.find(name)
        end

        def self.mount_point(name)
            new.find(name).chomp.match(/[^ ]+ (?<m>[^ ]+)/)[:m]
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
