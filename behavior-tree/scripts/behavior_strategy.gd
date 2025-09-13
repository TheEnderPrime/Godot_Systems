@abstract class_name BehaviorStrategy extends Resource

@abstract func process() -> Behavior.behaviorState
@abstract func reset() -> void


class IdleStrategy extends BehaviorStrategy:
	func _init ():
		pass
		
	func process() -> Behavior.behaviorState:
		print("Idling")
		return Behavior.behaviorState.FAILURE

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
	var chaseTime: int
	var chaseBark: String
	
	func _init (_chaseTime: int, _chaseBark: String):
		chaseTime = _chaseTime
		chaseBark = _chaseBark
		
	func process() -> Behavior.behaviorState:
		print("Chase Strategy - Process")
		while chaseTime >= 0:
			print("Chase Strategy - Chasing (" + str(chaseTime) + ")")
			#if chaseTime > 0:
				#print("Chase Strategy - " + chaseBark)
				#return Behavior.behaviorState.RUNNING
			if chaseTime == 0: 
				print("Chase Strategy - GOT EM")
				return Behavior.behaviorState.SUCCESS
			chaseTime -= 1
		print("Chase Strategy - FAILURE")
		return Behavior.behaviorState.FAILURE
		
	func reset() -> void:
		chaseTime = 0
		chaseBark = ""
		pass

class PatrolStrategy extends BehaviorStrategy:
	func _init ():
		pass
		
	func process() -> Behavior.behaviorState:
		print("HEY STOP")
		return Behavior.behaviorState.FAILURE
		
	func reset() -> void:
		pass
