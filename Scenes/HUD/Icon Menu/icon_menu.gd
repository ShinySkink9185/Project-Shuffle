extends CanvasLayer

# Since they're all unique, we can set the enum to also include number of options.
enum IconMenuTypes {BOARD = 3, SETTINGS = 4, BATTLE = 2}

# TODO: Precioustone Menu. May have to refactor how options are shown for that menu.
# We start at option 1 for BATTLE, and option 2 for BOARD and SETTINGS.

var menu_ready = false # Is the menu ready to display options and handle input?
var option_selected = 0 # What option have we selected in this menu?
var player_selecting = 1 # Which player controller is choosing in the menu?
var can_back_out = false # Can you back out of this menu?

var control_handler = ShuffleControlHandler.new()

# Animations
@onready var animation_global = $AnimationGlobal
@onready var animation_icons = $AnimationIcons

# Icons
@onready var icon_1 = $Control/Icon1
@onready var icon_2 = $Control/Icon2
@onready var icon_3 = $Control/Icon3
@onready var icon_4 = $Control/Icon4
@onready var icons = [icon_1, icon_2, icon_3, icon_4]

@export var type: IconMenuTypes = IconMenuTypes.BOARD

func _ready():
	# Choose which set of icons to use, as well as option hovered.
	match type:
		IconMenuTypes.BOARD:
			animation_icons.play("Board")
			option_selected = 1
		IconMenuTypes.SETTINGS:
			animation_icons.play("Settings")
			option_selected = 1
			can_back_out = true
		IconMenuTypes.BATTLE:
			animation_icons.play("Battle")
		
	# Set what controller our Control Handler will read.
	control_handler.player_controlling = player_selecting

func _process(delta: float) -> void:
	# Handle input
	# Apparently there's a "_input()" function for this kind of purpose,
	# but it doesn't detect if it's just pressed...
	# TODO: maybe for this, have a sensitivity threshold for controllers
	# TODO: account for multiple players
	# TODO: sound feedback
	# TODO: confirm
	if menu_ready == true:
		if control_handler.is_action_just_pressed("move_left"):
			option_selected -= 1
			if option_selected < 0:
				option_selected = type - 1
		if control_handler.is_action_just_pressed("move_right"):
			option_selected += 1
			if option_selected >= type:
				option_selected = 0
	
	# Handle option selection
	var icon_selected = 0
	for icon in icons:
		if icon_selected == option_selected:
			icon.modulate = Color(1, 1, 1)
		else:
			icon.modulate = Color(40.0/256, 40.0/256, 40.0/256)
		icon_selected += 1
	
	if control_handler.is_action_just_pressed("enter"):
		choice_picked()
	
	# If the menu can be backed out of.
	if control_handler.is_action_just_pressed("cancel") and type == IconMenuTypes.SETTINGS:
		var board_icon_menu = load("res://Scenes/HUD/Icon Menu/icon_menu.tscn")
		var board_icon_menu_instance = board_icon_menu.instantiate()
		board_icon_menu_instance.type = IconMenuTypes.BOARD
		get_parent().add_child(board_icon_menu_instance)
		queue_free()
	

# What do we do once we've picked a choice?
# TODO: maybe reverse the entrance once a choice is picked so it looks cleaner?
# TODO: sound effect
func choice_picked():
	match type:
		IconMenuTypes.BOARD:
			match option_selected:
				0:
					# TODO: This opens the Settings icon menu.
					var settings_icon_menu = load("res://Scenes/HUD/Icon Menu/icon_menu.tscn")
					var settings_icon_menu_instance = settings_icon_menu.instantiate()
					settings_icon_menu_instance.type = IconMenuTypes.SETTINGS
					get_parent().add_child(settings_icon_menu_instance)
				1:
					# TODO: This opens the Board Cards menu.
					pass
				2:
					# TODO: This opens the Board Precioustone menu.
					pass
		IconMenuTypes.SETTINGS:
			match option_selected:
				0:
					# TODO: figure out what this does
					pass
				1:
					# TODO: figure out what this does
					pass
				2:
					# TODO: figure out what this does
					pass
				3:
					# TODO: figure out what this does
					pass
		IconMenuTypes.BATTLE:
			match option_selected:
				0:
					# TODO: This opens the Battle Cards menu.
					pass
				1:
					# TODO: This opens the Battle Precioustone menu.
					pass
	
	# After all of that, free ourselves.
	queue_free()
	

# When our appearing animation finishes, unlock control.
func _on_animation_global_animation_finished(anim_name):
	menu_ready = true
