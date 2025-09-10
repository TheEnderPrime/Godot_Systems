@abstract class_name BehaviorStrategy extends Resource

@abstract func process() -> Behavior.behaviorState
@abstract func reset() -> void


class IdleStrategy extends BehaviorStrategy:
	func _init ():
		pass
		
	func process() -> Behavior.behaviorState:
		print("Idling")
		return Behavior.behaviorState.SUCCESS

	func reset() -> void:
		pass


class WanderStrategy extends BehaviorStrategy:
	func _init ():
		pass
		
	func process() -> Behavior.behaviorState:
		print("HEY WANDER")
		return Behavior.behaviorState.SUCCESS
		
	func reset() -> void:
		pass

class ChaseStrategy extends BehaviorStrategy:
	func _init ():
		pass
		
	func process() -> Behavior.behaviorState:
		print("HEY STOP")
		return Behavior.behaviorState.FAILURE
		
	func reset() -> void:
		pass


class PatrolStrategy extends BehaviorStrategy:
	func _init ():
		pass
		
	func process() -> Behavior.behaviorState:
		print("HEY STOP")
		return Behavior.behaviorState.FAILURE
		
	func reset() -> void:
		pass
