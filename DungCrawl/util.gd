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

class MyCustomSorter:
	static func sort_ascending(a, b):
		if a[0] > b[0]:
			return true
		return false

func normailize_to(li, sum):
	li = li.duplicate()
	var multiplier = sum / sum(li)
	var i = 0
	while i < len(li):
		li[i] = li[i] * multiplier
		i+=1
	li = safe_round(li)
	return li

func safe_round(li):
	li = li.duplicate()
	var sum = sum(li)
	var remainders = []
	for l in li:
		remainders.append(l - floor(l))
	var my_items = []
	var i = 0
	while i < len(li):
		my_items.append([remainders[i], i])
		i+=1
	my_items.sort_custom(MyCustomSorter, "sort_ascending")
	var j = 0
	while j < len(li):
		li[j] = floor(li[j])
		j+=1
	for k in range(sum - sum(li)):
		li[my_items[k][1]] = li[my_items[k][1]]+1
	return li

func sum(array):
	var sum = 0.0
	for element in array:
		 sum += element
	return sum

