module Diskman
    # Presents the user with a list of items to choose from.
    class Chooser
        def initialize(items, item:)
            @items = items
            @singular = item
            @plural = item + 's'
        end

        def label
            if @items.length > 1
                @plural
            else
                @singular
            end
        end

        def select
            if @items.length == 0
                $stderr.puts 'No %s found'.yellow % @plural
                raise Interrupt
            end

            if @items.length == 1
                $stderr.puts 'Found the following %s.' % label
            else
                $stderr.puts 'Choose from the following %s.' % @plural
            end

            $stderr.puts

            @items.each_with_index do |device, i|
                $stderr.puts '%5d. %s' % [i + 1, device]
            end

            $stderr.puts

            if @items.length == 1
                $stderr.puts 'Press enter to select it.'
                $stdin.gets
                return @items.first
            end

            $stderr.puts 'Enter your selection.'
            $stderr.puts
            $stderr.print '> '

            selection = $stdin.gets.chomp

            $stderr.puts

            if selection.length == 0
                raise Interrupt
            end

            selection = selection.to_i

            if selection <= 0 || selection > @items.length
                $stderr.puts 'Invalid selection'.red
                raise Interrupt
            end

            @items[selection - 1]
        end
    end
end
