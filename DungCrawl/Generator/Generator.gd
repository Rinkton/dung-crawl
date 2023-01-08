extends Node2D


const PLAYER = preload("res://Player/Player.tscn")
const exclude = [PLAYER, preload("res://Exit/Exit.tscn")]
const end = 10

var spawn = Spawn.new()


func _ready():
	randomize()
	yield(get_parent(), "ready")
	generate()


func generate():
	clear_all_but_player()
	var exclude_poses = []
	if g.player!=null:
		var player_exclude_pos = u.pos2game_pos(g.player.pre_pos + g.player.dir * u.block)
		exclude_poses.append(player_exclude_pos)
	for X in exclude:
		if X == PLAYER and g.player!=null:
			continue
		var pos
		var just_there := true
		while just_there or pos in exclude_poses:
			pos = Vector2(randi() % end, randi() % end)
			just_there = false
		var x = X.instance()
		g.game.call_deferred("add_child", x)
		x.global_position = global_position + pos * u.block
		exclude_poses.append(pos)
	var pos = Vector2(0, 0)
	while pos.y < end:
		var x = spawn.get_obj(g.cur_level)
		while pos in exclude_poses:
			pos = plus_to_pos(pos)
		if x != null:
			g.game.call_deferred("add_child", x)
			x.global_position = global_position + pos * u.block
		pos = plus_to_pos(pos)

func clear_all_but_player():
	for area in $Area2D.get_overlapping_areas():
		if area is Actable:
			area.queue_free()

func plus_to_pos(pos):
	if pos.x == end-1:
		pos = Vector2(0, pos.y+1)
	else:
		pos.x+=1
	return pos
