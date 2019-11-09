module Diskman
    module System
        # If sudo prompts for the password when a pipeline with pv has already
        # started then we're unable to enter the password. Run sudo --validate
        # first to ensure that we are preauthenticated.
        def self.prepare_sudo_session!
            system('sudo --validate')
        end

        # Execute a command.
        # If sudo is true, ensures sudo is ready before running the command.
        # If safe is true, ensures the user definitely wants to run the command
        # before running it.
        def self.exec!(cmd, safe: true, sudo: true)
            Confirmer.check! if safe
            prepare_sudo_session! if sudo
            puts
            exec cmd
        end

        # Convert bytes into a human-friendly representation.
        def self.bytes2human(b)
            return '0B' if b <= 0

            # Use 1000 to match the misleading way disk capacities are
            # advertised.
            k = 1000

            suffixes = ['T', 'G', 'M', 'K', 'B']

            suffixes.each_with_index do |suffix, i|
                threshold = k ** (suffixes.length - i - 1)
                if b >= threshold
                    return (b / threshold).to_s + suffix
                end
            end
        end
    end
end
