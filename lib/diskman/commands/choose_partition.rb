module Command
    class ChoosePartition
        def run
            puts RootDevice.choose.choose_with_partitions.path
        end
    end
end
