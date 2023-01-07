extends Area2D
class_name Actable


func _ready():
	yield(get_tree().create_timer(0.1), "timeout")
	connect("area_entered", self, "_area_entered")
	connect("mouse_entered", self, "_mouse_entered")
	connect("mouse_exited", self, "_mouse_exited")

func _process(_delta):
	get_node("Sprite").z_index = global_position.y


func act(_player):
	pass

func get_desc() -> String:
	return "N/A"


func _area_entered(player):
	act(player)

func _mouse_entered():
	g.ui.get_node("Info").on(global_position, get_desc()+'\n')

func _mouse_exited():
	g.ui.get_node("Info").off()
