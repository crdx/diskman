module Diskman
    class System
        # If sudo prompts for the password when a pipeline with pv has already
        # started then we're unable to enter the password. Run a pointless
        # command with sudo first to ensure that we can accept keyboard input
        # for the password, if necessary.
        def self.prepare_sudo!
            system('sudo ls >/dev/null')
        end

        # Execute a command.
        # If sudo is true, ensures sudo is ready before running the command.
        # If safe is true, ensures the user definitely wants to run the command
        # before running it.
        def self.exec!(cmd, safe: false, sudo: true)
            Confirmer.check! if safe
            prepare_sudo! if sudo
            puts
            system(cmd)
        end

        def self.safe_exec!(cmd)
            exec!(cmd, safe: true)
        end

        # Convert bytes into a human-friendly representation.
        def self.bytes2human(b)
            return '0B' if b <= 0

            # Use 1000 to match the misleading way disk capacities are
            # advertised.
            k = 1000

            suffices = ['T', 'G', 'M', 'K', 'B']

            suffices.each_with_index do |suffix, i|
                threshold = k ** (suffices.length - i - 1)
                if b >= threshold
                    return (b / threshold).to_s + suffix
                end
            end
        end
    end
end
