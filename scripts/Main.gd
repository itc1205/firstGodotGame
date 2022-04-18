###########################################
# imports/signals

extends Node

export(PackedScene) var mob_scene

###########################################
# Vars scene tree for the first time.

onready var ScoreTimer = $ScoreTimer
onready var MobTimer = $MobTimer
onready var StartTimer = $StartTimer

onready var Player = $Player

onready var MobStartPos = $MobPath/MobSpawnLocation
onready var StartPos = $StartPosition

onready var HUD = $HUD

onready var Music = $Music
onready var DeathSound = $DeathSound

var score

############################################
# overloaded funcs

func _ready():
	
	randomize()
	
	new_game()

######################
# timers

func _on_StartTimer_timeout():
	
	MobTimer.start()
	ScoreTimer.start()

func _on_ScoreTimer_timeout():
	
	score += 1
	HUD.update_score(score)
	
func _on_MobTimer_timeout():
	
	var mob = mob_scene.instance()
	
	var mob_spawn_location = MobStartPos
	mob_spawn_location.offset = randi()
	
	var direction = mob_spawn_location.rotation + PI / 2
	
	mob.position = mob_spawn_location.position
	
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	var velocity = Vector2(rand_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)

######################

############################################
# funcs

func new_game():
	
	get_tree().call_group("mobs", "queue_free")
	
	score = 0
	
	Player.start(StartPos.position)
	StartTimer.start()
	
	HUD.update_score(score)
	HUD.show_message("Prepare yourslef\nMortal")
	
func game_over():
	
	ScoreTimer.stop()
	MobTimer.stop()
	
	HUD.show_game_over()
	DeathSound.play()
	
