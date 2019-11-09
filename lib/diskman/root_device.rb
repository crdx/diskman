module Diskman
    class RootDevice < Device
        def self.get_removable
            Dir['/sys/block/*/removable'].select do |file|
                File.read(file).strip == '1'
            end.map do |path|
                path =~ %r[^/sys/block/(.*)/removable$]x && RootDevice.new($1)
            end.sort
        end

        def self.choose
            Chooser.new(RootDevice.get_removable, item: 'removable device').select
        end

        def choose_with_partitions
            Chooser.new(get_with_partitions, item: 'block device').select
        end

        def ensure_not_mounted!
            if mounted?
                puts ('Warning: device appears to be mounted at ' + mount_point).yellow
                puts 'Not continuing'.red
                raise Interrupt
            end
        end

        def to_s
            @path + ' [' + [size, label].reject(&:empty?).join(', ') + ']'
        end

        private

        def get_with_partitions
            Dir[@path + '*'].sort.map do |file|
                file =~ %r[/dev/(.*)] && Device.new($1)
            end.sort
        end

        def get_int_prop(name)
            get_prop(name).to_i
        end

        def get_prop(name)
            file = "/sys/class/block/%s/%s" % [@name, name]
            File.read(file).strip.gsub(/\s+/, ' ')
        end

        def label
            parts = [get_prop('device/vendor'), get_prop('device/model')]
            parts.reject(&:empty?).join(' ')
        end

        def size_bytes
            get_int_prop('size') * get_int_prop('queue/logical_block_size')
        end

        def size
            System.bytes2human(size_bytes)
        end

        def mounted?
            Mtab.mounted?(@name)
        end

        def mount_point
            Mtab.mount_point(@name)
        end
    end
end
