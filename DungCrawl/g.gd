extends Node


var game
var ui
var player


func _ready():
	pass

func _process(_delta):
	if Input.is_action_pressed("r"):
		get_tree().reload_current_scene()
