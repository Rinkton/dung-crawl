extends Node


func _ready():
	g.ui = self
	yield(get_tree().create_timer(0.1), "timeout")
	g.connect("setted_cur_level", self, "_setted_cur_level")
	_setted_cur_level(g.cur_level)
	var player_stats = g.player.get_node("Stats")
	player_stats.connect("setted_max_hp", self, "_setted_max_hp")
	player_stats.connect("setted_hp", self, "_setted_hp")
	player_stats.connect("setted_dmg", self, "_setted_dmg")
	_setted_max_hp(player_stats.max_hp)
	_setted_hp(player_stats.hp)
	_setted_dmg(player_stats.dmg)


func _setted_max_hp(max_hp):
	$MaxHpTab/Label.text = str(max_hp)

func _setted_hp(hp):
	$HpTab/Label.text = str(hp)

func _setted_dmg(dmg):
	$DmgTab/Label.text = str(dmg)

func _setted_cur_level(num):
	$CurLevelTab/Label.text = str(num)
