extends Node

var States = load("res://scripts/State Machine/state.gd")

@onready var parentNode = get_parent() # enemy, player, platform
@onready var stateLabel = parentNode.get_node_or_null("StateLabel") # Needs Label under root parent. State_Machine doesn't move apparently
@onready var patrolWaypoints : Node = parentNode.patrolWaypoints

var currentState : State
var target : CharacterBody2D

func _ready():
	change_state(State.stateEnum.PATROL)
	currentState.enter(self)

func _process(delta):
	if currentState:
		currentState.update(delta, self)
	
	if stateLabel != null:
		stateLabel.text = currentState.get_state_name().to_upper()
		
func _physics_process(delta: float) -> void:
	if currentState:
		currentState.physics_update(delta, parentNode)
 
func change_state(_stateEnum):
	if (currentState != null):
		currentState.exit(parentNode)
	var newState : State = State.get_state(_stateEnum)
	newState.enter(self)
	currentState = newState
