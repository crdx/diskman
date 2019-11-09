module Diskman
    class Device
        attr_reader :path

        def initialize(name)
            @name = name
            @path = '/dev/' + name
        end

        def self.get_removable
            Dir['/sys/block/*/removable'].select do |file|
                File.read(file).strip == '1'
            end.map do |path|
                path =~ /^\/sys\/block\/(.*)\/removable$/ && Device.new($1)
            end.sort
        end

        def self.choose
            Chooser.new(Device.get_removable, what: 'removable device').select
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

        def ensure_not_mounted!
            if mounted?
                puts ('Warning: device appears to be mounted at ' + get_mount_point).yellow
                puts 'Not continuing'.red
                raise Interrupt
            end
        end

        def mounted?
            Mount.is_mounted(@name)
        end

        def get_mount_point
            Mount.get_mount_point(@name)
        end

        def to_s
            @path + ' [' + [size, label].reject(&:empty?).join(', ') + ']'
        end

        private

        def <=>(o)
            @path <=> o.path
        end

        def get_int_prop(name)
            get_prop(name).to_i
        end

        def get_prop(name)
            file = "/sys/class/block/%s/%s" % [@name, name]
            File.read(file).strip.gsub(/\s+/, ' ')
        end

        def label
            [get_prop('device/vendor'), get_prop('device/model')].reject(&:empty?).join(' ')
        end

        def size_bytes
            get_int_prop('size') * get_int_prop('queue/logical_block_size')
        end

        def size
            System.bytes2human(size_bytes)
        end
    end
end
