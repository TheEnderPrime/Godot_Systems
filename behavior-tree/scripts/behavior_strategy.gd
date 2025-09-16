@abstract class_name BehaviorStrategy extends Resource

@abstract func process() -> Behavior.behaviorState
@abstract func reset() -> void


class IdleStrategy extends BehaviorStrategy:
	var agent: CharacterBody2D
	
	func _init (_agent: CharacterBody2D):
		agent = _agent
		
	func process() -> Behavior.behaviorState:
		print("Idle Strategy")
		if "direction" in agent:
			agent.direction = Vector2.ZERO
		agent.velocity = Vector2.ZERO
		return Behavior.behaviorState.RUNNING

	func reset() -> void:
		pass

class WanderStrategy extends BehaviorStrategy:
	var moveDirection : Vector2
	var moveSpeed : float
	var wander_time : float
	var agent: CharacterBody2D
	var wanderTimer: Timer
	
	func _init (_agent: CharacterBody2D, _moveSpeed: float):
		agent = _agent
		moveSpeed = _moveSpeed
		wanderTimer = Timer.new()
		randomize_wander()
		wanderTimer.one_shot = false
		wanderTimer.name = "wanderTimer"
		wanderTimer.timeout.connect(on_wander_timeout)

	func process() -> Behavior.behaviorState:
		print("Wander Strategy")
		if not wanderTimer.is_inside_tree():
			agent.add_child(wanderTimer)
			wanderTimer.start()
		else: 
			wanderTimer.start()
			
		if "direction" in agent:
			agent.direction = moveDirection
		agent.velocity = moveDirection * moveSpeed
		return Behavior.behaviorState.RUNNING
		
	func reset() -> void:
		wanderTimer.stop()
		moveDirection = Vector2.ZERO
		
	func randomize_wander():
		moveDirection = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
		wanderTimer.wait_time = randf_range(1, 3)
		
	func on_wander_timeout() -> Behavior.behaviorState:
		print("WANDER TIMEOUT")
		randomize_wander()
		return Behavior.behaviorState.SUCCESS

class ChaseStrategy extends BehaviorStrategy:
	var agent: CharacterBody2D
	var target: Node
	var moveSpeed: float
	var successRange: float
	
	func _init (_agent: CharacterBody2D, _target: Node, _moveSpeed: float,  _successRange: float):
		agent = _agent
		target = _target
		moveSpeed = _moveSpeed
		successRange = _successRange
		
	func process() -> Behavior.behaviorState:
		print("Chase Strategy")
		var direction = target.global_position - agent.global_position
		agent.velocity = direction.normalized() * moveSpeed
		
		if agent.global_position.distance_to(target.global_position) < successRange:
			return Behavior.behaviorState.SUCCESS

		return Behavior.behaviorState.RUNNING
		
	func reset() -> void:
		agent = null
		target = null
		moveSpeed = 0
		successRange = 0

class PatrolStrategy extends BehaviorStrategy:
	var agent: CharacterBody2D
	var waypoints: Node
	var moveSpeed: float
	var target: Node
	
	func _init (_agent: CharacterBody2D, _waypoints: Node, _moveSpeed: float):
		agent = _agent
		waypoints = _waypoints
		moveSpeed = _moveSpeed
		target = waypoints.get_start_node()
		
	func process() -> Behavior.behaviorState:
		print("Patrol Strategy")
		if(target == null):
			print("NO WAYPOINTS AVAILABLE")
			return Behavior.behaviorState.FAILURE
			
		var direction = target.global_position - agent.global_position
		agent.velocity = direction.normalized() * moveSpeed 
		var distance_to_target = agent.global_position.distance_to(target.global_position)

		if agent.velocity.length() > distance_to_target:
			target = waypoints.get_next_point_node()
			return Behavior.behaviorState.SUCCESS
		return Behavior.behaviorState.RUNNING
			
	func reset() -> void:
		agent = null
		waypoints = null
		moveSpeed = 0
		target = null

class isObjectNearbyStrategy extends BehaviorStrategy:
	var target : Node
	var agent : Node
	var detectionRange
	
	func _init(_target : Node, _agent : Node, _detectionRange):
		target = _target
		agent = _agent
		detectionRange = _detectionRange
		
	func process():
		if agent.global_position.distance_to(target.global_position) < detectionRange:
			print("Object IS Nearby: " + target.name + " --- " + str(agent.global_position.distance_to(target.global_position)) + " < " + str(detectionRange))
			return Behavior.behaviorState.SUCCESS
		print("Object NOT Nearby: " + target.name)
		return Behavior.behaviorState.FAILURE
	
	func reset():
		target = null
		agent = null
		detectionRange = 0
		
class doesObjectExistStrategy extends BehaviorStrategy:
	var target : Node
	
	func _init(_target: Node):
		target = _target
	
	func process():
		if target.visible():
			return Behavior.behaviorState.SUCCESS
		return Behavior.behaviorState.FAILURE
		
	func reset():
		target = null
