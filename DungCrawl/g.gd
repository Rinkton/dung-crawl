extends Node


var game
var ui
var player
var cur_level := 1 setget set_cur_level

signal setted_cur_level(num)


func set_cur_level(val):
	cur_level = val
	emit_signal("setted_cur_level", cur_level)
