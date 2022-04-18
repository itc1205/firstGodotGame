###########################################
# imports/signals
extends CanvasLayer

signal start_game

###########################################
# Vars

onready var Message = $Message
onready var MessageTimer = $MessageTimer
onready var StartButton = $StartButton
onready var ScoreLabel = $ScoreLabel

############################################
# overloaded funcs

func _on_StartButton_pressed():
	
	StartButton.hide()
	
	emit_signal("start_game")

func _on_MessageTimer_timeout():
	
	Message.hide()

############################################
# our funcs

func show_message(text):
	
	Message.text = text
	Message.show()
	MessageTimer.start()
	
func show_game_over():
	
	show_message("Your game is over")
	
	yield(MessageTimer, "timeout")
	
	Message.text = "Go on\nDodge them"
	Message.show()
	
	yield(get_tree().create_timer(1), "timeout")
	
	StartButton.show()

func update_score(score):
	
	ScoreLabel.text = str(score)

