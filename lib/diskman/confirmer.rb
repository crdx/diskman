module Diskman
    # Confirms whether the user wants to do something destructive.
    class Confirmer
        YES = 'YES'

        def self.check!
            new.check!
        end

        def check!
            puts
            puts 'Are you sure? Type "%s" if so.' % YES
            puts

            print '> '

            if $stdin.gets.chomp != YES
                raise Interrupt
            end
        end
    end
end
