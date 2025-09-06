extends Node

var States = load("res://scripts/State Machine/state.gd")

var currentState : State
var target : CharacterBody2D

func _ready():
	currentState = States.Wander_State.new()
	currentState.enter(self)


func _process(delta):
	if currentState:
		currentState.update(delta, self)
		
func _physics_process(delta: float) -> void:
	if currentState:
		currentState.physics_update(delta, get_parent())
 
func change_state(_stateEnum):
	currentState.exit()
	var newState : State = currentState.get_state(_stateEnum)
	newState.enter(self)
	currentState = newState
