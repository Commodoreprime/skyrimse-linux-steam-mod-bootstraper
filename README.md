# Skyrim (Special Edition) Linux Steam Mod Bootstrapper
Implements mod loading for Skyrim Special Edition on linux by using UnionFS and Mod Organizer 2 in order to launch with mods in a more flexible way

## Installation
*This readme assumes that you have already gotten a mod capable Skyrim working with Proton*

*It also assumes that you have a working Mod Organizer 2 instance located in the prefix used by Skyrim*

This script can be ran from anywhere but for ease of use, it should be placed inside of Skyrim's game directory.
Which can be found by going to `Properties...>Local Files>Browse...`

There is also a supplemetry start script used to launch the game with which should be placed in the same directory as the bootstrap script.

*start.sh requires `zenity` to be installed on the system in order to function*

## Script requirements
* Steam (with Steam Play enabled)
* Skyrim Special Edition (Steam version)
* [protontricks](https://github.com/Matoking/protontricks)
* UnionFS (for most distributions this is going to be packaged as `unionfs-fuse`)
* standard Linux utilities

## Usage
The bootstrap script can be ran at any time, the method for how it is executed is up to you.

One solution is to use the launch options in Steam to launch the script before the game launches (and after for cleanup).
The way to do this is again up to you.

This repository comes with a basic startup wrapper script that'll ask if you want to load mods.
To use modify the launch options in steam to look something like this:

`/path/to/start.sh "%command%"`

Any other wrapper commands or enviroment variables should go inside the quotes as well.

## Expectations
This is not a mod organizer, but is, in fact, a bootstrapper.

This script relies on a mod organizer and other tools such as LOOT to compile a correct load order and to store uncompressed mods.
Basicly do everything except launch the game.

**Load order is not too well understood by this script, it will unify based on the order of `modlist.txt` so loose file overwrite priority is entirly dependent on how `modlist.txt` orders the mods. This will have to be fixed later for more consistent results**

This script runs off of the structure of a portable instance of [Mod Organizer 2](https://github.com/ModOrganizer2/modorganizer)
where all data is under `C:\\Modding\\MO2`.

