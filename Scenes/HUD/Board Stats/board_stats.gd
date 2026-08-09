extends CanvasLayer

@onready var animation = $AnimationPlayer

@onready var player1 = {
	"Icon": $Player1/Icon,
	"Precioustones": $Player1/PrecioustoneCount.text,
	"Rings": $Player1/RingCount.text,
}

@onready var player2 = {
	"Icon": $Player2/Icon,
	"Precioustones": $Player2/PrecioustoneCount.text,
	"Rings": $Player2/RingCount.text,
}

@onready var player3 = {
	"Icon": $Player3/Icon,
	"Precioustones": $Player3/PrecioustoneCount.text,
	"Rings": $Player3/RingCount.text,
}

@onready var player4 = {
	"Icon": $Player4/Icon,
	"Precioustones": $Player4/PrecioustoneCount.text,
	"Rings": $Player4/RingCount.text,
}

@onready var players = [player1, player2, player3, player4]

# TODO: fill out info according to game statistics

func _process(delta):
	for player in players:
		var 
