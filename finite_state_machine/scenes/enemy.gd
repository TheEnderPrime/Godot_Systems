extends CharacterBody2D

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine = $StateMachine
@onready var idleTimer = $IdleTimer

var moveSpeed := 20
var target : CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	if collision:
		print("Collision: ", collision.get_collider().name)
		state_machine.change_state(State.stateEnum.IDLE)
		animated_sprite.play("damaged")	
	elif velocity.x > 0 or velocity.x == 0:
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
		state_machine.change_state(State.stateEnum.CHASE)


func _on_vision_body_exited(body: Node2D) -> void:
	if body != self:
		print("Exited Body")
		state_machine.target = null
		state_machine.change_state(State.stateEnum.IDLE)
		idleTimer.start()


func _on_idle_timer_timeout() -> void:
	print("Idle Time Out")
	state_machine.change_state(State.stateEnum.WANDER)
