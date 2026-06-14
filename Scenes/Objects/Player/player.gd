extends CharacterBody3D ## Playable characters for all intents and purposes.

const Character: String = "sonic" ## Which character are we dealing with?
const PlayerID: int = 0 ## What player is attached to this guy?

@onready var sprite = $Sprite3D
@onready var animation = $Sprite3D/AnimationPlayer

func _ready():
	pass

func _physics_process(delta):
	pass
