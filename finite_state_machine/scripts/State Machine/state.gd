@abstract class_name State extends Resource

var Action: Dictionary = {}
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
@abstract func get_state_name() -> String
@abstract func enter()
@abstract func update(_delta: float, stateMachine)
@abstract func physics_update(_delta: float, parent: Node)
@abstract func exit()


class Idle_State extends State:
	func get_state_name() -> String:
		return "Idle_State"
		
	func enter():
		print("Enter Idle State")
	
	func update(_delta, stateMachine):
		pass
				
	func physics_update(_delta, parent):
		pass
		
	func exit():
		print("Exit Idle State")


class Wander_State extends State:
	var move_direction : Vector2
	var wander_time : float
	
	func get_state_name() -> String:
		return "Wander_State"
	
	func randomize_wander():
		move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
		wander_time = randf_range(1, 3)
				
	func enter():
		randomize_wander()
	
	func update(_delta, stateMachine):
		if wander_time > 0:
			wander_time -= _delta
		else:
			randomize_wander()
	
	func physics_update(_delta, parent):
		parent.velocity = move_direction * parent.get_speed()
	
	func exit():
		print("Exit Wander State")


class Chase_State extends State:
	func get_state_name() -> String:
		return "Chase_State"
		
	func enter():
		print("Enter Chase State")
	
	func update(_delta, stateMachine): 
		pass
	
	func physics_update(_delta, parent):
		pass
		
	func exit():
		print("Exit Chase State")
