extends CanvasLayer

# We put everything inside a Visuals control tab because of problems with
# moving everything individually. In hindsight, maybe it would've been better
# if this entire node was a Control... I think we'll be fine as-is, though.
@onready var player_1_icon = $Visuals/Player1/Icon
@onready var player_1_border = $Visuals/Player1/Border

@onready var player_2_icon = $Visuals/Player2/Icon
@onready var player_2_border = $Visuals/Player2/Border

@onready var player_3_icon = $Visuals/Player3/Icon
@onready var player_3_border = $Player3/Border

@onready var player_4_icon = $Visuals/Player4/Icon
@onready var player_4_border = $Player4/Border

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Replace our icon.
	# TODO: do that
	pass
	
	# Change the color of our border.
	# TODO: do that


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
