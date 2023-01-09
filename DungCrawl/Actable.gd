extends Area2D
class_name Actable


var on_mouse := false
var had_off_many_visibles := false


func _ready():
	yield(get_tree().create_timer(0.1), "timeout")
	var on_mouse_control = Control.new()
	on_mouse_control.rect_position = Vector2(-4, -4)
	on_mouse_control.rect_size = Vector2(8, 8)
	on_mouse_control.connect("mouse_entered", self, "_mouse_entered")
	on_mouse_control.connect("mouse_exited", self, "_mouse_exited")
	add_child(on_mouse_control)
	connect("area_entered", self, "_area_entered")
	

func _process(_delta):
	get_node("Sprite").z_index = global_position.y
	if on_mouse and Input.is_action_pressed("shift"):
		for actable in u.get_actable_children_in_game():
			if u.delete_numeration_in_name(name) != u.delete_numeration_in_name(actable.name):
				actable.visible = false
		if g.ui.get_node("Info").show:
			g.ui.get_node("Info").off()
		had_off_many_visibles = true
	elif had_off_many_visibles:
		for actable in u.get_actable_children_in_game():
			actable.visible = true
		had_off_many_visibles = false


func act(_player):
	pass

func get_desc() -> String:
	return "N/A"


func _area_entered(player):
	act(player)

func _mouse_entered():
	g.ui.get_node("Info").on(global_position, get_desc()+'\n')
	on_mouse = true

func _mouse_exited():
	g.ui.get_node("Info").off()
	on_mouse = false
