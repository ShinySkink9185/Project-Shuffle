extends Control

enum IconMenuTypes {BOARD, SETTINGS, BATTLE}

# TODO: Have the different types of menus show up in-game.
# TODO: Have players be able to control it!

var menu_ready = false # Is the menu ready to display options and handle input?
var option_selected = 0 # What option have we selected in this menu?

@export var type: IconMenuTypes

func _process(delta: float) -> void:
	if type == IconMenuTypes.BOARD:
		# TODO: do stuff
		pass
