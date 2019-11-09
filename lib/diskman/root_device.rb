module Diskman
    class RootDevice < Device
        def self.get_removable
            Dir['/sys/block/*/removable'].select do |file|
                File.read(file).strip == '1'
            end.map do |path|
                path =~ /^\/sys\/block\/(.*)\/removable$/ && RootDevice.new($1)
            end.sort
        end

        def self.choose
            Chooser.new(RootDevice.get_removable, what: 'removable device').select
        end

        def get_devices
            Dir[@path + '*'].sort.map do |file|
                file =~ %r[/dev/(.*)] && Device.new($1)
            end.sort
        end

        def choose_block_device
            Chooser.new(get_devices, what: 'device').select
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
