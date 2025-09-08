extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var speed = 200
@export var friction = 0.01
@export var acceleration = 0.1


func _physics_process(delta: float) -> void:
	var direction = get_input()
	
	# Flip the Sprite
	if direction.x > 0:
		animated_sprite.flip_h = false
	elif direction.x < 0:
		animated_sprite.flip_h = true
		
	# Play animations
	if direction.x == 0 and direction.y == 0:
		animated_sprite.play("idle")
	else:
		animated_sprite.play("run")	
	
	if direction.length() > 0:
		velocity = velocity.lerp(direction.normalized() * speed, acceleration)
	else:
		velocity = velocity.lerp(Vector2.ZERO, friction)

	var collision = move_and_collide(velocity * delta)
	if collision:
		print("Collision: ", collision.get_collider().name)

func get_input():
	var input = Vector2()
	if Input.is_action_pressed('move_right'):
		input.x += 1
	if Input.is_action_pressed('move_left'):
		input.x -= 1
	if Input.is_action_pressed('move_down'):
		input.y += 1
	if Input.is_action_pressed('move_up'):
		input.y -= 1
	return input
