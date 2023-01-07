extends Actable


export var ap := 1


func act(player):
	var audio = AudioStreamPlayer.new()
	get_parent().add_child(audio)
	audio.volume_db = -15
	audio.stream = preload("res://collect.wav")
	audio.play()
	player.get_node("Stats").ap = ap
	queue_free()

func get_desc():
	return """
	name = {name}
	armor points = {ap}
	""".format([["name", name], ["ap", ap]])
