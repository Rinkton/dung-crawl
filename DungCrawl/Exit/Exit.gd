extends Actable


func act(player):
	g.cur_level+=1
	var generator = g.game.get_node("Generator")
	generator.generate()
	queue_free()

func get_desc():
	return """
	Moves you to another, 
	more deeper level
	"""
