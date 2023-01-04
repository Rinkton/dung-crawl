extends Node2D


const exclude = [preload("res://Player/Player.tscn")]
const to_place = [
	[preload("res://Armor/Clothes.tscn"), 20],
	[preload("res://Armor/Corslet.tscn"), 5],
	[preload("res://Armor/Mightness.tscn"), 2],
	
	[preload("res://Enemies/Slime.tscn"), 100],
	[preload("res://Enemies/Snake.tscn"), 50],
	[preload("res://Enemies/Zombie.tscn"), 50],
	[preload("res://Enemies/Demon.tscn"), 10],
	
	[preload("res://Potion/Potion.tscn"), 35],
	
	[preload("res://Weapons/Stick.tscn"), 20],
	[preload("res://Weapons/Sword.tscn"), 5],
	[preload("res://Weapons/Halberd.tscn"), 1],
	[null, 400],
]
const end = 10

var exclude_poses = []


func _ready():
	yield(get_parent(), "ready")
	randomize()
	for X in exclude:
		var pos = Vector2(randi() % end, randi() % end)
		var x = X.instance()
		g.game.call_deferred("add_child", x)
		x.global_position = global_position + pos * u.block
		exclude_poses.append(pos)
	var pos = Vector2(0, 0)
	var sum_of_scores = get_sum_of_scores()
	while pos.y < end:
		var rand_val = randi() % sum_of_scores
		var x = get_object_by_rand_val(rand_val)
		if x != null:
			g.game.call_deferred("add_child", x)
			x.global_position = global_position + pos * u.block
		var just_there := true
		while just_there or pos in exclude_poses:
			if pos.x == end-1:
				pos = Vector2(0, pos.y+1)
			else:
				pos.x+=1
			just_there = false


func get_sum_of_scores():
	var sum = 0
	for l in to_place:
		sum += l[1]
	return sum

func get_object_by_rand_val(rand_val):
	var sum = 0
	var i = 0
	for l in to_place:
		sum += l[1]
		if sum > rand_val:
			if to_place[i][0] != null:
				return to_place[i][0].instance()
			else:
				return null
		i+=1
