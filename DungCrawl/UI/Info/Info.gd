extends Node2D


var show := false
# TODO: Since the special control node for its had appeared it's don't need the code of this hard ain't it?


func _ready():
	off()

func _process(delta):
	if show or not $Timer.is_stopped():
		$NinePatchRect.rect_size = $Label.rect_size + $Label.rect_size * 0.1
		$NinePatchRect.mouse_filter = Control.MOUSE_FILTER_STOP
		visible = true
	else:
		$NinePatchRect.mouse_filter = Control.MOUSE_FILTER_IGNORE
		visible = false


func on(pos, text):
	global_position = pos
	$Label.text = text
	show = true

func off():
	show = false
	$Timer.start()
