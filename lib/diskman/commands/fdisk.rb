module Command
    class Fdisk
        def run
            root_device = RootDevice.choose
            cmd = root_device.get_fdisk_command
            System.exec!(cmd, safe: false)
        end
    end
end
