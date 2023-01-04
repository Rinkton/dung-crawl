extends Node


const DEAD_PLAYER_TEXTURE = preload("res://Player/DeadPlayer.png")
const DEAD_PANEL = preload("res://UI/DeadPanel.tscn")

onready var entity = get_parent()
onready var hp = max_hp setget set_hp

export var max_hp := 10 setget set_max_hp
export var dmg := 1 setget set_dmg

signal setted_hp(hp)
signal setted_max_hp(max_hp)
signal setted_dmg(dmg)


func set_hp(val):
	if val > 0:
		hp = val
	else:
		hp = 0
		if entity.name == "Player":
			var audio = AudioStreamPlayer.new()
			entity.get_parent().add_child(audio)
			audio.volume_db = -10
			audio.stream = preload("res://Player/dead.wav")
			audio.play()
			g.game.get_node("Theme").stop()
			var dead_sprite = Sprite.new()
			dead_sprite.global_position = entity.global_position
			dead_sprite.texture = DEAD_PLAYER_TEXTURE
			entity.get_parent().add_child(dead_sprite)
			g.ui.add_child(DEAD_PANEL.instance())
		entity.queue_free()
	check_hp_and_max_hp()
	emit_signal("setted_hp", hp)

func set_max_hp(val):
	max_hp = val
	check_hp_and_max_hp()
	emit_signal("setted_max_hp", max_hp)

func set_dmg(val):
	dmg = val
	emit_signal("setted_dmg", dmg)


func check_hp_and_max_hp():
	if hp != null and hp > max_hp:
		set_hp(max_hp)
