extends Area2D


const spd = 25
const start_bound = Vector2(4, 4)
const end_bound = Vector2(92, 92)

var moving := false
var dir : Vector2
var pre_pos


func _ready():
	g.player = self

func _process(_delta):
	get_node("Sprite").z_index = global_position.y

func _physics_process(delta):
	if not moving:
		dir = Vector2(
			Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
			Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up"))
	if dir.length() > 0 and not dir.length() > 1:
		moving = true
	if moving:
		if pre_pos == null:
			var audio = AudioStreamPlayer.new()
			get_parent().add_child(audio)
			audio.volume_db = -30
			audio.stream = preload("res://Player/step.wav")
			audio.play()
			pre_pos = global_position
		if not check_bounds(pre_pos + dir * u.block):
			moving = false
			pre_pos = null
		else:
			global_position = global_position.move_toward(pre_pos + dir * u.block, spd * delta)
			if pre_pos + dir * u.block == global_position:
				moving = false
				pre_pos = null


func check_bounds(pos):
	if (pos.x > start_bound.x and pos.y > start_bound.y and 
	pos.x < end_bound.x and pos.y < end_bound.y):
		return true
	else: return false
