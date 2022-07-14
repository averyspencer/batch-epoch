# batch-epoch
(Note: this package is a port of [shell-epoch](https://github.com/averyspencer/shell-epoch) to Windows and thus is meant to be functionally equivalent)

Convert unix epoch time to UTC in pure cmd batch files

Want to use Unix's bourne shell instead? Take a look at my other repository, [shell-epoch](https://github.com/averyspencer/shell-epoch)

## TODO
* Output results in ISO 8601 date/time format
* Does not have the local times feature yet

# usage examples
    >REM Should be July 14th, 2022 at 2:06:44 PM
    >batch-epoch 1657764404
    Month: 7
    Day: 14
    Year: 2022
    Hour: 2
    Minute: 6
    Second: 44
