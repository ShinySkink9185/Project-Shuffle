extends CanvasLayer

enum IconMenuTypes {BOARD, SETTINGS, BATTLE}

# TODO: Have the different types of menus show up in-game.
# TODO: Have players be able to control it!
# We start at option 1 for BATTLE, and option 2 for BOARD and SETTINGS.

var menu_ready = false # Is the menu ready to display options and handle input?
var option_selected = 0 # What option have we selected in this menu?

@onready var animation_global = $AnimationGlobal
@onready var animation_icons = $AnimationIcons

@export var type: IconMenuTypes

func _ready():
	# Choose which set of icons to use.
	match type:
		IconMenuTypes.BOARD:
			animation_icons.play("Board")
		IconMenuTypes.SETTINGS:
			animation_icons.play("Settings")
		IconMenuTypes.BATTLE:
			animation_icons.play("Battle")

func _process(delta: float) -> void:
	if type == IconMenuTypes.BOARD:
		# TODO: do stuff
		pass
