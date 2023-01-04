extends Node2D


func _ready():
	off()


func on(pos, text):
	global_position = pos
	$Label.text = text
	yield(get_tree().create_timer(0,1), "timeout")
	$NinePatchRect.rect_size = $Label.rect_size + $Label.rect_size * 0.1
	$NinePatchRect.mouse_filter = Control.MOUSE_FILTER_STOP
	visible = true

func off():
	$NinePatchRect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	visible = false
