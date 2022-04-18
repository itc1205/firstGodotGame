###########################################
# imports/signals
extends RigidBody2D

###########################################
# Vars

onready var AnimSprite = get_node("AnimatedSprite")

############################################
# overloaded funcs

func _ready():
	AnimSprite.playing = true
	var mob_types = AnimSprite.frames.get_animation_names()
	AnimSprite.animation = mob_types[randi() % mob_types.size()]

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


#############################################################
# our funcs

