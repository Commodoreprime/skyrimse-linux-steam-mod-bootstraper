#!/bin/bash
# Implements a unified file system for modding Skyrim Special Edition

helpfile="skyrimse-mod-bootstraper [--decouple]
Utilizes UnionFS to combine multiple mod directories into a single Data folder
Options:
  --decouple    Undo steps taken by the behavior of the bootstrapper
  --help        Prints this then quits
"
[ "$1" = "--help" ] && {
  printf "$helpfile"
  exit 0
}

# Fetch runtime directories
STEAM_APPID="489830"
GAME_FILE_DIR="$(protontricks -c "sh -c 'echo -e \$PWD'" "$STEAM_APPID")"
WINE_PREFIX_DIR="$(protontricks -c "sh -c 'echo -e \$WINEPREFIX'" "$STEAM_APPID")"

APPDATA_DIR="$WINE_PREFIX_DIR/drive_c/users/steamuser/Local Settings/Application Data/Skyrim Special Edition"

# Move into Game directory
cd "$GAME_FILE_DIR"

case "$1" in
  "--decouple")
    /usr/bin/fusermount -u "./Data" 2>/dev/null
    if [ -d ./Data.base ]; then
      if [ "$(/usr/bin/ls -l ./Data | grep -v '^total' | wc -l)" -eq 0 ]; then
        mv Data.base/* ./Data
        rm -r Data.base
    fi; fi
    if [ -L "$APPDATA_DIR" ]; then 
      rm "$APPDATA_DIR"
      mv "$APPDATA_DIR.old" "$APPDATA_DIR"
    fi
    exit 0 ;;
  *);;
esac

# Mod Organizer 2
#TODO: Maybe make these dynamic?
MO2_DIR="$WINE_PREFIX_DIR/drive_c/Modding/MO2"
MO2_MODS_DIR="$MO2_DIR/mods"
MO2_PROFILE="Default"

MODLIST_FILE="$MO2_DIR/profiles/$MO2_PROFILE/modlist.txt"

# UnionFS command arguments
UFS_BRANCH_STRING="Data.base/"

# Append only enabled mods
while read -r modname; do
  UFS_BRANCH_STRING="$UFS_BRANCH_STRING:$MO2_MODS_DIR/$modname/"
done < <(cat "$MODLIST_FILE" | grep '^+' | cut -c 2- | tr -d '\015')

# Move original Data directory to new .base varient so unionfs does not freak out
mv Data ./Data.base

# unionfs freaks out if there is no directory to mount to
mkdir ./Data

/usr/bin/unionfs "$UFS_BRANCH_STRING" ./Data

[ -d "$APPDATA_DIR" ] && mv "$APPDATA_DIR" "$APPDATA_DIR.old"
/usr/bin/ln -srnf "$MO2_DIR/profiles/$MO2_PROFILE" "$APPDATA_DIR"

exit 0
