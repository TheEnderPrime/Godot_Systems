extends Node

var States = load("res://scripts/State Machine/state.gd")

var currentState : State

func _ready():
	currentState = States.Idle_State.new()
	currentState.enter()


func _process(delta):
	if currentState:
		currentState.update(delta, self)
		#currentState = change_state(States.stateEnum.WANDER)
		
func _physics_process(delta: float) -> void:
	if currentState:
		currentState.physics_update(delta, get_parent())
 
func change_state(_stateEnum):
	currentState.exit()
	var newState : State = currentState.get_state(_stateEnum)
	newState.enter()
	currentState = newState
