extends Actable


export var max_hp := 1


func act(player):
	var audio = AudioStreamPlayer.new()
	get_parent().add_child(audio)
	audio.volume_db = -15
	audio.stream = preload("res://collect.wav")
	audio.play()
	player.get_node("Stats").max_hp = max_hp
	queue_free()

func get_desc():
	return """
	name = {name}
	max_hp = {max_hp}
	""".format([["name", name], ["max_hp", max_hp]])
