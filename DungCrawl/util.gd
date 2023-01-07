extends Node


const block = 8
const to_first_block_vec = Vector2(12, 12)


func pos2game_pos(pos):
	var game_pos = (pos - to_first_block_vec) / block
	return game_pos

func delete_numeration_in_name(name):
	if '@' in name:
		return name.split('@')[1]
	else:
		return name
