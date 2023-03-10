extends Node2D


const PLAYER = preload("res://Player/Player.tscn")
const exclude = [PLAYER, preload("res://Exit/Exit.tscn")]
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

var generated = []


func _ready():
	randomize()
	yield(get_parent(), "ready")
	generate()


func generate(player_exclude_pos=null):
	var exclude_poses = []
	if player_exclude_pos != null:
		var i = 0
		for c in generated:
			if is_instance_valid(c) and c.name == "Player":
				generated.remove(i)
			i+=1
		exclude_poses.append(player_exclude_pos)
	for g in generated:
		if is_instance_valid(g):
			g.queue_free()
	generated.clear()
	for X in exclude:
		if X == PLAYER and player_exclude_pos != null:
			continue
		var pos
		var just_there := true
		while just_there or pos in exclude_poses:
			pos = Vector2(randi() % end, randi() % end)
			just_there = false
		var x = X.instance()
		g.game.call_deferred("add_child", x)
		generated.append(x)
		x.global_position = global_position + pos * u.block
		exclude_poses.append(pos)
		
	var pos = Vector2(0, 0)
	var sum_of_scores = get_sum_of_scores()
	while pos.y < end:
		var rand_val = randi() % sum_of_scores
		var x = get_object_by_rand_val(rand_val)
		if x != null:
			g.game.call_deferred("add_child", x)
			generated.append(x)
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
