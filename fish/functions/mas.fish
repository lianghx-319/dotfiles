function mas
    command mas $argv
    set -l exit_status $status

    if test $exit_status -eq 0
        set -l subcommands install upgrade update uninstall purchase get lucky
        if test (count $argv) -gt 0; and contains $argv[1] $subcommands
            # Use the absolute path to Brewfile in your dotfiles repo
            set -l brewfile "$HOME/code/github.com/lianghx-319/dotfiles/Brewfile"
            if test -f "$brewfile"
                echo "Updating Brewfile at $brewfile..."
                command brew bundle dump --force --file="$brewfile"
            end
        end
    end

    return $exit_status
end
