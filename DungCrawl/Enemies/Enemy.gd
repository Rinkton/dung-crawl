extends Actable
class_name Enemy


func act(player):
	var player_stats = player.get_node("Stats")
	var self_stats = self.get_node("Stats")
	var player_hp = player_stats.hp
	var player_dmg = player_stats.dmg
	var self_hp = self_stats.hp
	var self_dmg = self_stats.dmg
	var final_player_hp = fight(player_hp, player_dmg, self_hp, self_dmg)
	player_stats.hp = final_player_hp
	if player_stats.hp > 0:
		var audio = AudioStreamPlayer.new()
		get_parent().add_child(audio)
		audio.volume_db = -15
		audio.stream = preload("res://Enemies/kill.wav")
		audio.play()
		self_stats.hp = 0

func get_desc():
	var player_stats = g.player.get_node("Stats")
	var self_stats = self.get_node("Stats")
	var player_hp = player_stats.hp
	var player_dmg = player_stats.dmg
	var self_hp = self_stats.hp
	var self_dmg = self_stats.dmg
	return """
	name = {name}
	hp = {hp}
	dmg = {dmg}
	your hp after battle = {fight}
	""".format([["name", name], ["hp", self_stats.hp], ["dmg", self_stats.dmg], 
	["fight", fight(player_hp, player_dmg, self_hp, self_dmg)]])

func fight(player_hp, player_dmg, self_hp, self_dmg):
	var final_player_hp = player_hp - ceil(float(self_hp) / player_dmg) * self_dmg
	if final_player_hp < 0:
		final_player_hp = 0
	return final_player_hp
