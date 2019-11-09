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
                puts 'No %s found'.yellow % @plural
                raise Interrupt
            end

            if @items.length == 1
                puts 'Found the following %s.' % label
            else
                puts 'Choose from the following %s.' % @plural
            end

            puts

            @items.each_with_index do |device, i|
                puts "%6d. %s" % [i + 1, device]
            end

            puts

            if @items.length == 1
                puts 'Press any key to select it.'
                $stdin.gets
                return @items.first
            end

            puts 'Enter your selection.'
            puts
            print '> '

            selection = $stdin.gets.chomp

            puts

            if selection.length == 0
                raise Interrupt
            end

            selection = selection.to_i

            if selection <= 0 || selection > @items.length
                puts 'Invalid selection'.red
                raise Interrupt
            end

            @items[selection - 1]
        end
    end
end
