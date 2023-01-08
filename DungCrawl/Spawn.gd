extends Node
class_name Spawn


const to_place = [
	[100, "enemy"],
	[15, "armor"],
	[15, "weapon"],
	[5, "potion"],
	[5, "nothing"]
]


func get_obj(level):
	var scores = []
	for X in to_place:
		scores.append(X[0])
	var sum_of_scores = get_sum_of_scores(scores)
	var rand_val = randi() % sum_of_scores
	var list = get_list_by_rand_val(to_place, rand_val)
	var obj = call(list[1], level)
	return obj

func enemy(level):
	var li = [
		[preload("res://Enemies/Slime.tscn"), 10, 100000],
		[preload("res://Enemies/Snake.tscn"), 5500, 10000],
		[preload("res://Enemies/Zombie.tscn"), 5500, 10000],
		[preload("res://Enemies/Demon.tscn"), 6000, 1],
	]
	return grad(li, level)

func armor(level):
	var li = [
		[preload("res://Armor/Clothes.tscn"), 10, 100000],
		[preload("res://Armor/Corslet.tscn"), 5500, 10000],
		[preload("res://Armor/Mightness.tscn"), 6000, 1],
	]
	return grad(li, level)

func weapon(level):
	var li = [
		[preload("res://Weapons/Stick.tscn"), 10, 100000],
		[preload("res://Weapons/Sword.tscn"), 5500, 10000],
		[preload("res://Weapons/Halberd.tscn"), 6000, 1],
	]
	return grad(li, level)

func potion(_level):
	return preload("res://Potion/Potion.tscn").instance()

func nothing(_level):
	return null

func grad(li, level):
	var scores = []
	var x = level
	for l in li:
		var k = l[1]
		var b = l[2]
		scores.append(k*x + b)
	var i = 0
	for l in li:
		l.push_front(scores[i])
		i+=1
	var sum_of_scores = get_sum_of_scores(scores)
	var rand_val = randi() % sum_of_scores
	var obj = get_object_by_rand_val(li, rand_val)
	return obj

func get_sum_of_scores(scores):
	var sum = 0
	for score in scores:
		sum += score
	return sum

func get_object_by_rand_val(li, rand_val):
	var list = get_list_by_rand_val(li, rand_val)
	if list[1] != null:
		return list[1].instance()
	else:
		return null

func get_list_by_rand_val(li, rand_val):
	var sum = 0
	for l in li:
		sum += l[0]
		if sum > rand_val:
			return l
