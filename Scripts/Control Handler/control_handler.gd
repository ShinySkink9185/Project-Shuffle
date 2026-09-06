class_name ShuffleControlHandler
extends Node

var player_controlling = 1

func is_action_pressed(action: StringName, exact_match: bool = false):
	return Input.is_action_pressed(action + "_" + str(player_controlling), exact_match)

func is_action_just_pressed(action: StringName, exact_match: bool = false):
	return Input.is_action_just_pressed(action + "_" + str(player_controlling), exact_match)

func is_action_just_released(action: StringName, exact_match: bool = false):
	return Input.is_action_just_released(action + "_" + str(player_controlling), exact_match)
