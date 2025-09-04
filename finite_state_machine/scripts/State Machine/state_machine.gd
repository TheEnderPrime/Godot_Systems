extends Node

var 	States = load("res://scripts/State Machine/state.gd")

var currentState : State

func _ready():
	currentState = States.Idle_State.new()


func _process(delta):
	if currentState:
		currentState.update(delta, self)
		print(currentState.get_state_name())
 
func change_state(_state: State):
	currentState = _state
