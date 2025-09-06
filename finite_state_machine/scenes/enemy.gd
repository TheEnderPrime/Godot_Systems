extends CharacterBody2D

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine = $StateMachine

var moveSpeed := 20
var target : CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move_and_slide()
	
	if velocity.x > 0 or velocity.x == 0:
		animated_sprite.play("idle")
		
	if velocity.x > 0:
		animated_sprite.flip_h = false
	elif velocity.x < 0:
		animated_sprite.flip_h = true
		
	queue_redraw()


func set_speed(speed: int) -> void:
	moveSpeed = speed

func get_speed() -> int:
	return moveSpeed


func _on_vision_body_entered(body: Node2D) -> void:
	if body != self:
		print("Entered Body")
		state_machine.target = self
		state_machine.change_state(State.stateEnum.CHASE)


func _on_vision_body_exited(body: Node2D) -> void:
	if body != self:
		print("Exitted Body")
		state_machine.target = null
		state_machine.change_state(State.stateEnum.IDLE)

func _draw():
	draw_line(direction.x, direction, Color.RED, 2)
