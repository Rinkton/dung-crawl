extends Actable


func act(player):
	var audio = AudioStreamPlayer.new()
	get_parent().add_child(audio)
	audio.volume_db = -15
	audio.stream = preload("res://Potion/potion.wav")
	audio.play()
	var player_stats = player.get_node("Stats")
	player_stats.hp = player_stats.max_hp
	queue_free()

func get_desc():
	return """
	Make your health
	go up to max
	"""
