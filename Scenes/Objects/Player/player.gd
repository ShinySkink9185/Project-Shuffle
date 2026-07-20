extends CharacterBody3D ## Playable characters for all intents and purposes.

# TODO: when the character is switched or when the player is initialized, reload all of our animations
const Character: String = "sonic" ## Which character are we dealing with?
const PlayerID: int = 0 ## What player is attached to this guy?

@onready var sprite = $Sprite3D
@onready var animation = $Sprite3D/AnimationPlayer

func _ready():
	pass

func _physics_process(delta):
	pass
