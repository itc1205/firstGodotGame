###########################################
# imports/signals

extends Area2D

signal hit

###########################################
# Vars
export var speed = 400

onready var AnimatedNode = get_node("AnimatedSprite")
onready var CollisionPlayerShape = get_node("CollisionShape2D")

var screen_size

############################################
# overloaded funcs
func _ready():
	
	screen_size = get_viewport_rect().size
	hide()
	
func _process(delta):
	
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		AnimatedNode.play()
	else:
		AnimatedNode.stop()
	
	# clamping so we cant leave borders
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	if velocity.x != 0:
		AnimatedNode.animation = "walk"
		AnimatedNode.flip_v = false
		AnimatedNode.flip_h = velocity.x < 0
	elif velocity.y != 0:
		AnimatedNode.animation = "up"
		AnimatedNode.flip_v = velocity.y > 0

func _on_Player_body_entered(_body):
	
	hide()
	
	emit_signal('hit')
	
	# We are gonna disable player collision model so that we are not gonna trigger hit again
	CollisionPlayerShape.set_deferred("disabled", true)
	
#############################################################
# our funcs
func start(pos):
	
	position = pos
	
	show()
	
	CollisionPlayerShape.disabled = false
	
