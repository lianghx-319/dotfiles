# Fish parameter completions for the Rush CLI
complete rush --no-files

function __fish_rush
    set -l position (string length (commandline -cp))
    set -l word (commandline -opc)
    rush tab-complete --word "$word" --position "$position"
end

complete rush -x -a "(__fish_rush)"
