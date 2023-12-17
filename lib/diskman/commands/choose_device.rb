module Command
    class ChooseDevice
        def run
            puts RootDevice.choose.path
        end
    end
end
