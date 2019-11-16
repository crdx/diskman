module Diskman
    class Device
        attr_reader :name
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
            dd = 'sudo dd if="%s" of="%s" bs=%dK status=progress'
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
