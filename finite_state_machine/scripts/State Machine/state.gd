@abstract class_name State extends Resource

var target : Node
enum stateEnum {IDLE, CHASE, WANDER, PATROL, FLEE, DEATH}
static func get_state(_stateEnum) -> State:
	match _stateEnum:
		stateEnum.IDLE:
			return State.Idle_State.new()
		stateEnum.CHASE:
			return State.Chase_State.new()
		stateEnum.WANDER:
			return State.Wander_State.new()
		stateEnum.PATROL:
			return State.Patrol_State.new()
		stateEnum.FLEE:
			return State.Flee_State.new()
		stateEnum.DEATH:
			return State.Death_State.new()
		_:
			return State.Idle_State.new()
@abstract func enter(stateMachine)
@abstract func update(_delta: float, stateMachine)
@abstract func physics_update(_delta: float, parent: Node)
@abstract func exit(parent: Node)
@abstract func get_state_name() -> String


class Idle_State extends State:
	func enter(_stateMachine):
		print("Enter Idle State")
	
	func update(_delta, _stateMachine):
		pass
				
	func physics_update(_delta, _parent):
		pass
		
	func exit(_parent):
		print("Exit Idle State")

	func get_state_name() -> String:
		return "Idle_State"


class Wander_State extends State:
	var move_direction : Vector2
	var wander_time : float
				
	func enter(_stateMachine):
		print("Enter Wander State")
		randomize_wander()
	
	func update(_delta, _stateMachine):
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
	
	func update(_delta, _stateMachine): 
		pass
	
	func physics_update(_delta, parent):
		var direction = target.global_position - parent.global_position
		parent.velocity = direction.normalized() * parent.moveSpeed
		
	func exit(parent):
		print("Exit Chase State")
		parent.velocity = Vector2.ZERO

	func get_state_name() -> String:
		return "Chase_State"


class Patrol_State extends State:
	func enter(stateMachine):
		print("Enter Patrol State")
		target = stateMachine.patrolWaypoints.get_start_node()
	
	func update(_delta, _stateMachine): 
		pass
	
	func physics_update(_delta, parent: Node):
		var direction = target.global_position - parent.global_position
		parent.velocity = direction.normalized() * parent.moveSpeed 
		var distance_to_target = parent.global_position.distance_to(target.global_position)
		
		if parent.velocity.length() > distance_to_target:
			target = parent.patrolWaypoints.get_next_point_node()
		
	func exit(_parent):
		print("Exit Patrol State")

	func get_state_name() -> String:
		return "Patrol_State"


class Flee_State extends State:
	var flee_time_max : float = 3
	var flee_time : float = flee_time_max
	
	func enter(stateMachine):
		print("Enter Flee State")
		target = stateMachine.target
	
	func update(_delta, stateMachine): 
		if flee_time > 0:
			flee_time -= _delta
		else:
			if (stateMachine.target != null):
				flee_time = flee_time_max
	
	func physics_update(_delta, parent):
		var direction = -(target.global_position - parent.global_position)
		parent.velocity = direction.normalized() * parent.moveSpeed
		
	func exit(parent):
		print("Exit Flee State")
		parent.velocity = Vector2.ZERO

	func get_state_name() -> String:
		return "Flee_State"


class Death_State extends State:
	func enter(_stateMachine):
		print("Enter Death State")
	
	func update(_delta, _stateMachine): 
		pass
	
	func physics_update(_delta, _parent):
		pass
		
	func exit(_parent):
		print("Exit Death State")

	func get_state_name() -> String:
		return "Death_State"



class Default_State extends State:
	func enter(_stateMachine):
		print("Enter Default State")
	
	func update(_delta, _stateMachine): 
		pass
	
	func physics_update(_delta, _parent):
		pass
		
	func exit(_parent):
		print("Exit Default State")

	func get_state_name() -> String:
		return "Default_State"
