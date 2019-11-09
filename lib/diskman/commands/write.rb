module Command
    class Write
        def run(file:)
            if !File.exists?(file)
                puts ('Unable to read ' + file).red
                raise Interrupt
            end

            device = Device.choose
            device.ensure_not_mounted!

            size = File.size(file)
            cmd = device.get_write_command(file, size)

            puts "File:    #{file.yellow} (#{System.bytes2human(size)})"
            puts "Device:  #{device.to_s.yellow}"
            puts "Command: #{cmd.yellow}"

            System.safe_exec!(cmd)
        end
    end
end
