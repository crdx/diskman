module Diskman
    class Device
        attr_reader :path

        def initialize(name)
            @name = name
            @path = '/dev/' + name
        end

        def get_fdisk_command
            'sudo fdisk %s' % @path
        end

        def get_mkfs_command(fs)
            'sudo mkfs.%s %s' % [fs, @path]
        end

        def get_write_command(path, bytes)
            if `which 2>/dev/null pv`.length > 0
                pv = 'pv --size %d' % bytes
                dd = 'dd if="%s" | ' + pv + ' | sudo dd of="%s" bs=%d'
            else
                dd = 'sudo dd if="%s" of="%s" bs=%d'
            end

            dd % [path, @path, 4096]
        end

        def to_s
            @path
        end

        private

        def <=>(o)
            @path <=> o.path
        end
    end
end
