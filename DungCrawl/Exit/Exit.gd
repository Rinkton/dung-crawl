extends Actable


func act(player):
	var generator = g.game.get_node("Generator")
	generator.generate()
	queue_free()
