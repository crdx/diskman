module Command
    class Fdisk
        def run
           device = Device.choose
           cmd = device.get_fdisk_command
           System.exec! cmd, safe: false
        end
    end
end
