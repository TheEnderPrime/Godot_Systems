extends CharacterBody2D

@export var patrolWaypoints : Node

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine = $StateMachine
@onready var idleTimer = $IdleTimer
@onready var deathTimer = $DeathTimer
@onready var wanderTimer = $WanderTimer

var moveSpeed := 20
var target : Node

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	if collision:
		print("Collision: ", collision.get_collider().name)
		state_machine.change_state(State.stateEnum.DEATH)
		animated_sprite.play("death")	
		deathTimer.start()
	elif (velocity.x > 0 or velocity.x == 0) and state_machine.currentState.get_state_name() != state_machine.States.Death_State.new().get_state_name():
		animated_sprite.play("idle")
		
	if velocity.x > 0:
		animated_sprite.flip_h = false
	elif velocity.x < 0:
		animated_sprite.flip_h = true

func set_speed(speed: int) -> void:
	moveSpeed = speed

func get_speed() -> int:
	return moveSpeed

func _on_vision_body_entered(body: Node2D) -> void:
	if body != self:
		print("Entered Body")
		state_machine.target = body
		if randf() < 0.2:
			state_machine.change_state(State.stateEnum.FLEE)
		else:
			state_machine.change_state(State.stateEnum.CHASE)

func _on_vision_body_exited(body: Node2D) -> void:
	if body != self:
		print("Exited Body")
		state_machine.target = null
		state_machine.change_state(State.stateEnum.IDLE)
		idleTimer.start()

func _on_idle_timer_timeout() -> void:
	if state_machine.currentState.get_state_name() == state_machine.States.Idle_State.new().get_state_name():
		print("Idle Time Out")
		state_machine.change_state(State.stateEnum.WANDER)
		wanderTimer.start()
	else:
		print("Idle Time Out IGNORED")

func _on_death_timer_timeout() -> void:
	queue_free()

func _on_wander_timer_timeout() -> void:
	if state_machine.currentState.get_state_name() == state_machine.States.Wander_State.new().get_state_name():
		print("Wander Time Out")
		state_machine.change_state(State.stateEnum.PATROL)
	else:
		print("Wander Time Out IGNORED")
