extends CharacterBody2D

@export var patrolWaypoints : Node

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

var moveSpeed := 20
var visionRange: float = 100
var attackRange: float = 15
var target : Node

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	queue_redraw()
	var collision = move_and_collide(velocity * delta)
	if collision:
		print("Collision: ", collision.get_collider().name)
		animated_sprite.play("death")
		animated_sprite.play("idle")
		
	if velocity.x > 0:
		animated_sprite.flip_h = false
	elif velocity.x < 0:
		animated_sprite.flip_h = true

func set_speed(speed: int) -> void:
	moveSpeed = speed

func get_speed() -> int:
	return moveSpeed

func _draw():
	var white: Color = Color.WHITE
	
	draw_circle(Vector2(0, -6), visionRange, white, false)
