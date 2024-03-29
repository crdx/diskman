module Command
    class Mkfs
        def get_list
            Dir['/sbin/mkfs.*'].map do |path|
                path.gsub(%r[^/sbin/mkfs.], '')
            end.sort
        end

        def run(list: false)
            if list
                puts get_list
                return
            end

            device = RootDevice.choose
            device = device.choose_with_partitions

            fs = Chooser.new(get_list, item: 'filesystem').select
            cmd = device.get_mkfs_command(fs)

            puts "Filesystem: #{fs.yellow}"
            puts "Device:     #{device.to_s.yellow}"
            puts "Command:    #{cmd.yellow}"

            System.exec!(cmd)
        end
    end
end
