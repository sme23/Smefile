
# Smefile

Buildfile environment containing all of my various wizardry, installation-configurable. Also comes with a test map, for personal testing purposes. All hacks + the test map can be individually toggled on or off from `_CONFIG.event`. 




## To Fix

- Port back fixed hook for breakable terrain forcing map anims

## WIP

- Swarp staff
- Final boss immunities (can be set per-character?)
- Gaiden Megaquake (the SoV version that can't kill units)

## Todo

- Add glowy colors in battle to status rework
- Ballista expansion
- MMB modules for biorhythm, fatigue, laguz bars, and holy blood
- Inverse weapon locks (anyone BUT defined char or class can wield)
- Fatigue costs for combat arts, instead of durability costs
- Expand sacred weapon battle music to arbitrary weapon/song ID pairs
- Items addon for Laguz Bars
- Buy-Only and Sell-Only shops (probably will need new text control codes)
- Rewrite super arena hack entirely
- Jedah's thing where you're unable to attack, but you still initiate battle and just get a popup instead of actually attacking and your round is cancelled entirely unless the 4/8/12/16 requirement is met
	- configurable the turns that are a multiple of 4 version or the every 4th attack version, though the latter will use 2 bits of debuff table space to track how many times you've been attacked
- Ledge terrain (if units can pass this terrain, they do so by jumping from one end to the other)
- Option for setting additional fatigue costs if a unit has holy blood / major blood

## Todo but afraid of doing because big menus and CHAX

- Tellius Base
	- Skill Add/Remove menu (+ capacity, + giving skill scrolls when removed)
	- Forging menu (using kirb's forging system)
	- Base Convos menu
	- Items menu (the one from the prep screen verbatim)
	- Bonus Exp menue
	- Supports menu
	- Shops menu (includes Forging & shops are either buy-only or sell-only)
	- Guide menu accessible (a la RD Library)
	- Can save at base menu
	
	- At prep screen
		- only get the map view menu 
		- map view menu contains Select Units
		- map view menu contains Items, but you can't use the convoy
		- map view menu contains Return, which goes back to the base (probably with some event schenanigans)
		- Can save at prep menu


- TRS/RD Party Split Menu
	- Menu allowing for separating the party into four groups
		- configurable unit cap for each group
		- units are selected and moved between four panels, one in each corner
		- Select toggles the selected panel between the four, then cursor will scroll
		- table containing a function to run for each unit to check if they should be allowed to be moved out of a certain party
		- table containing default party settings for each unit
		- externalized values for caps on each party's size
	- Which group is designated by a flag (can't be in debuff data)
	- Automatically hides from the party everyone in the second group
	- ASMCs + event macros for easily swapping the current party


- Weapon Type Extension
	- rewrite every area that checks for weapon level, rewrite stat screen page 3, use icon rework stuff that's already been done to get weapon type icons beyond the first 8, 


- Height Map
	- Gives each tile on the map a height value
	- Needs somewhere a full-sized map can be stored in RAM, since tile changes exist
	- Needs fully updated when a map is loaded, a tile change is triggered, or a save is loaded
	- Needs some way of designating the height map in ROM based on the layout of the map itself (could you define height at 1 position and have it autofill the rest of the height map based on terrain generally used to denote height? or a fully manual way, probably a tool with a GUI or something with a layer in Tiled and a new version of tmx2ea to account for it)
	- Needs a visual indicator of the height of a given tile (use terrain window?)
	- If a unit is trying to attack from a higher height to a lower height by an amount >1, the attacker gains a hit/atk advantage and the defender a hit/atk disadvantage; inverse if attacking from >1 height lower to higher
	
	
- Walkies (Exploration Maps)
	- Lets you walk around a map like in gaiden
	- Proc loaded (via ASMC?) as a blocking child proc of GAMECTRL
	- Looped function for getting inputs
		- D-pad direction 
			- check if 1 tile in direction pressed is within the map bounds
			- check if 1 tile in direction pressed is passable given unit's terrain costs (not 255)
			- check if 1 tile in direction pressed is currently occupied by another unit
			- if is passable, valid, and unoccupied, move onto tile
			- if it is not passable but there is a unit there AND the controlled unit has a talk convo with them, initiate the talk convo instead
		- A button
			- if a unit is 1 tile above and there is a talk convo between your unit and that unit, initiate that event
			- if you are standing on a map object or specific terrain (arenas), do the thing associated with using the unit menu to access it based on the map object ID, ignoring checks where present (lockpick/key/locktouch requirements, etc)
			- if neither of these find anything, open the map menu
	- Run MiscBasedEvents every time you move a unit (unless this gets laggy)
	- Looped function also checks for units 1 tile above, and displays an indicator over them if they can be talked to
	- Map objects that activate when simply stepped upon in this mode and run events (running AFEVs & AREAs in this mode would probably be super laggy)