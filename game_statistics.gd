extends Node ## This is our storage of things that are relevant to the current game.
class_name Game_Statistics

# Each player's info.
# Oooo, first time I'm trying dictionaries!!
# Maybe I should've done that instead of classes for the global statistics...
static var player_1_info = {
	"Playing": true, 
	"Character": "sonic",
	"Precioustones": 0,
	"Rings": 0,
	"Duels": 0,
	"Forcejewels": [null, null, null, null, null],
	"Space": 0,
	"Effects": [],
}

static var player_2_info = {
	"Playing": true, 
	"Character": "sonic",
	"Precioustones": 0,
	"Rings": 0,
	"Duels": 0,
	"Forcejewels": [null, null, null, null, null],
	"Space": 0,
	"Effects": [],
}

static var player_3_info = {
	"Playing": true, 
	"Character": "sonic",
	"Precioustones": 0,
	"Rings": 0,
	"Duels": 0,
	"Forcejewels": [null, null, null, null, null],
	"Space": 0,
	"Effects": [],
}

static var player_4_info = {
	"Playing": true, 
	"Character": "sonic",
	"Precioustones": 0,
	"Rings": 0,
	"Duels": 0,
	"Forcejewels": [null, null, null, null, null],
	"Space": 0,
	"Effects": [],
}

static var forcejewels_left = 7
static var current_turn = 1
static var turn_order = [1, 2, 3, 4]

# For future reference. Whenever you add an effect to the player,
# add it to the array as a dictionary, with a "Name" and the "Duration".
# Make sure the duration counts down whenever you need it to.
