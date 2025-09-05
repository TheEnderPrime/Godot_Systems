extends CharacterBody2D

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

var moveSpeed := 20

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


func set_speed(speed: int) -> void:
	moveSpeed = speed

func get_speed() -> int:
	return moveSpeed
