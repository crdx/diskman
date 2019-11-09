module Diskman
    # Presents the user with a list of items to choose from.
    class Chooser
        def initialize(items, what:)
            @items = items
            @singular = what
            @plural = what + 's'
        end

        def label
            if @items.length > 1
                @plural
            else
                @singular
            end
        end

        def space
            ' '
        end

        def select
            if @items.length == 0
                puts 'No %s found'.yellow % @plural
                raise Interrupt
            end

            if @items.length == 1
                puts 'Found the following %s.' % label
            else
                puts 'Please pick from the following %s.' % @plural
            end

            puts

            @items.each_with_index do |device, i|
                puts "#{(space * 4) }#{i + 1}. #{device}"
            end

            puts

            if @items.length == 1
                print 'Press any key to select it.'
                $stdin.gets
                return @items.first
            end

            puts 'Enter the number of your selection.'
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
