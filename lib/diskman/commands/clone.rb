module Command
    class Clone
        def run(file:)
            if File.exist?(file)
                puts ('File exists: ' + file).red
                raise Interrupt
            end

            device = RootDevice.choose
            cmd = device.get_clone_command(file)

            puts "File:    #{file.yellow}"
            puts "Device:  #{device.to_s.yellow}"
            puts "Command: #{cmd.yellow}"

            System.exec!(cmd)
        end
    end
end
