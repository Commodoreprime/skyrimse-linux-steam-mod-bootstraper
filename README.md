# Skyrim (Special Edition) Linux Steam Mod Bootstrapper
Implements mod loading for Skyrim Special Edition on linux by using UnionFS and Mod Organizer 2 in order to launch with mods in a more flexible way

## Installation
This script can be ran from anywhere but for ease of use, it can be placed inside of Skyrim's game directory.

Which can be found by going to `Properties...>Local Files>Browse...`

*This readme assumes that you have already gotten moddable Skyrim working with Proton*

## Script requirements
* Steam (with Steam Play enabled)
* Skyrim Special Edition (Steam version)
* [protontricks](https://github.com/Matoking/protontricks)
* UnionFS (for most distributions this is going to be packaged as `unionfs-fuse`)
* standard Linux utilities

## Usage
This script can be ran at any time, the method of for when it is executed is up to you.

One solution is to use the launch options in Steam to launch the script before the game launches (and after for cleanup).
The way to do this is again up to you, my solution is to use a basic menu to wrapper launch with.

## Expectations
This is not a mod organizer, but is, in fact, a bootstrapper.

This script relies on a mod organizer and other tools such as LOOT to compile a correct load order and to store uncompressed mods.
Basicly do everything except launch the game.

This script runs off of the structure of a portable instance of [Mod Organizer 2](https://github.com/ModOrganizer2/modorganizer)
where all data is under `C:\\Modding\\MO2`.

