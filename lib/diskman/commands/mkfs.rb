module Command
    class Mkfs
        def get_list
            Dir['/usr/bin/mkfs.*'].map do |path|
                path.gsub(%r[^/usr/bin/mkfs.], '')
            end.sort
        end

        def run(list: false)
            if list
                puts get_list
                return
            end

            device = Device.choose
            device.ensure_not_mounted!

            fs = Chooser.new(get_list, what: 'filesystem').select
            cmd = device.get_mkfs_command(fs)

            puts "Filesystem: #{fs.yellow}"
            puts "Device:     #{device.to_s.yellow}"
            puts "Command:    #{cmd.yellow}"

            System.safe_exec!(cmd)
        end
    end
end
