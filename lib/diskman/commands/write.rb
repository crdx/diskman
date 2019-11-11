module Command
    class Write
        def run(file:)
            if !File.exists?(file)
                puts ('Unable to read ' + file).red
                raise Interrupt
            end

            device = RootDevice.choose
            size = File.size(file)
            cmd = device.get_write_command(file, size)

            puts "File:    #{file.yellow} (#{System.bytes2human(size)})"
            puts "Device:  #{device.to_s.yellow}"
            puts "Command: #{cmd.yellow}"

            System.exec! cmd
        end
    end
end
