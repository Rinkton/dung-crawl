extends Actable


export var dmg := 1


func act(player):
	var audio = AudioStreamPlayer.new()
	get_parent().add_child(audio)
	audio.volume_db = -15
	audio.stream = preload("res://collect.wav")
	audio.play()
	player.get_node("Stats").dmg = dmg
	queue_free()

func get_desc():
	return """
	name = {name}
	dmg = {dmg}
	""".format([["name", name], ["dmg", dmg]])
