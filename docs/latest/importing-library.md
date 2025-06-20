!> To use the library, it is required
to disable ["Legacy Other Behavior"](https://manual.gamemaker.io/monthly/en/#t=GameMaker_Language%2FGML_Overview%2FInstance%20Keywords%2Fother.htm%23legacy_other_behaviour&rhsearch=legacy%20other%20behavior),
or you will receive unexpected behavior and bugs.

# Importing The Library

You can find the latest version of Eventica [here](https://github.com/AlexInCube/Eventica/releases).
Then download `.yymps` from that page and import into your Game Maker project.
You’ll see a folder called Eventica appear in your asset browser.

If you look inside the Eventica folder, you’ll see a lot of subfolders. 
These subfolders contain functions that comprise the API, the interface that you’ll need to execute Eventica code in your game. 
The `(System)` folder holds code that Eventica requires to operate, and you can forget about it exists. 
You’ll also see a script called `__EventicaConfig` - inside this script settings that control how Eventica works. 
**You should edit these scripts to tailor Eventica to your needs.**


## Updating Eventica {docsify-ignore}
From time to time, we’ll need to release updates to Eventica, either to add new features or to address bugs.

1. Create a backup of your configuration scripts
2. Delete the Eventica folder from the asset browser
3. Import the Eventica .yymps from the GitHub releases page
4. Restore your configuration scripts. Some macros may have changed between versions so take special care when restoring values