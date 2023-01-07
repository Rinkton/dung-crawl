extends Node


const block = 8
const to_first_block_vec = Vector2(12, 12)


func pos2game_pos(pos):
	var game_pos = (pos - to_first_block_vec) / block
	return game_pos
