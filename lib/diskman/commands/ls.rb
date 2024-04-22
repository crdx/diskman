module Command
    class Ls
        def run
            puts RootDevice.get_removable.map(&:path)
        end
    end
end
