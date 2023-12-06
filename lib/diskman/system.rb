module Diskman
    module System
        # Execute a command.
        #
        # If safe is true, ensures the user definitely wants to run the command before running it.
        def self.exec!(cmd, safe: true)
            Confirmer.check! if safe
            puts
            exec(cmd)
        end

        # Convert bytes into a human-friendly representation.
        def self.bytes2human(b)
            return '0B' if b <= 0

            # Use 1000 to match the misleading way disk capacities are
            # advertised.
            k = 1000

            suffixes = %w[T G M K B]

            suffixes.each_with_index do |suffix, i|
                threshold = k ** (suffixes.length - i - 1)
                if b >= threshold
                    return (b / threshold).to_s + suffix
                end
            end
        end
    end
end
