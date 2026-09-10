extends CanvasLayer

# We put the icons inside the border because animations weren't cooperating with
# changing the position of the stored "Player" nodes, but did cooperate with the
# border for some reason
@onready var player_1_icon = $Player1/Border/Icon
@onready var player_1_border = $Player1/Border

@onready var player_2_icon = $Player2/Border/Icon
@onready var player_2_border = $Player2/Border

@onready var player_3_icon = $Player3/Border/Icon
@onready var player_3_border = $Player3/Border

@onready var player_4_icon = $Player4/Border/Icon
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
