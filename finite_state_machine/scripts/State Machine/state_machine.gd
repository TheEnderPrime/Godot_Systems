extends Node

enum States {IDLE, WANDER, CHASE, ATTACK}

var currentState : State

func on_ready():
	currentState = States.IDLE



func _process(delta):
	if currentState:
		currentState.on_update(delta)
 
