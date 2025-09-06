@abstract class_name State extends Resource

var target : CharacterBody2D
enum stateEnum {IDLE, CHASE, WANDER}
func get_state(_stateEnum) -> State:
	match _stateEnum:
		stateEnum.IDLE:
			return State.Idle_State.new()
		stateEnum.CHASE:
			return State.Chase_State.new()
		stateEnum.WANDER:
			return State.Wander_State.new()
		_:
			return State.Idle_State.new()
@abstract func enter(stateMachine)
@abstract func update(_delta: float, stateMachine)
@abstract func physics_update(_delta: float, parent: Node)
@abstract func exit(parent: Node)
@abstract func get_state_name() -> String


class Idle_State extends State:
	func enter(stateMachine):
		print("Enter Idle State")
	
	func update(_delta, stateMachine):
		pass
				
	func physics_update(_delta, parent):
		pass
		
	func exit(parent):
		print("Exit Idle State")

	func get_state_name() -> String:
		return "Idle_State"


class Wander_State extends State:
	var move_direction : Vector2
	var wander_time : float
				
	func enter(stateMachine):
		print("Enter Wander State")
		randomize_wander()
	
	func update(_delta, stateMachine):
		if wander_time > 0:
			wander_time -= _delta
		else:
			randomize_wander()
	
	func physics_update(_delta, parent):
		if move_direction != null:
			parent.velocity = move_direction * parent.get_speed()
	
	func exit(parent):
		print("Exit Wander State")
		parent.velocity = Vector2.ZERO
		
	func get_state_name() -> String:
		return "Wander_State"
	
	func randomize_wander():
		move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
		wander_time = randf_range(1, 3)


class Chase_State extends State:
	func enter(stateMachine):
		print("Enter Chase State")
		target = stateMachine.target
	
	func update(_delta, stateMachine): 
		pass
	
	func physics_update(_delta, parent):
		var direction = target.global_position - parent.global_position
		parent.velocity = direction.normalized() * parent.moveSpeed
		
	func exit(parent):
		print("Exit Chase State")
		parent.velocity = Vector2.ZERO

	func get_state_name() -> String:
		return "Chase_State"


class Damaged_State extends State:
	func enter(stateMachine):
		print("Enter Chase State")
	
	func update(_delta, stateMachine): 
		pass
	
	func physics_update(_delta, parent):
		pass
		
	func exit(parent):
		print("Exit Chase State")

	func get_state_name() -> String:
		return "Chase_State"



#class Default_State extends State:
	#func enter(stateMachine):
		#print("Enter Default State")
	#
	#func update(_delta, stateMachine): 
		#pass
	#
	#func physics_update(_delta, parent):
		#pass
		#
	#func exit(parent):
		#print("Exit Default State")
#
	#func get_state_name() -> String:
		#return "Default_State"
