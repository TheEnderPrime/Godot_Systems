@abstract class_name BehaviorStrategy extends Resource

@abstract func process() -> Behavior.behaviorState
@abstract func reset() -> void


class IdleStrategy extends BehaviorStrategy:
	var agent: CharacterBody2D
	
	func _init (_agent: CharacterBody2D):
		agent = _agent
		
	func process() -> Behavior.behaviorState:
		print("Idle Strategy")
		return Behavior.behaviorState.SUCCESS

	func reset() -> void:
		pass

class WanderStrategy extends BehaviorStrategy:
	func _init ():
		pass
		
	func process() -> Behavior.behaviorState:
		print("Wander Strategy")
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
		print("Chase Strategy")
		while chaseTime >= 0:
			print("Chase Strategy - Chasing (" + str(chaseTime) + ")")
			#if chaseTime > 0:
				#print("Chase Strategy - " + chaseBark)
				#return Behavior.behaviorState.RUNNING
			if chaseTime == 0: 
				print("Chase Strategy - GOT EM")
				reset()
				return Behavior.behaviorState.SUCCESS
			chaseTime -= 1
		print("Chase Strategy - FAILURE")
		reset()
		return Behavior.behaviorState.FAILURE
		
	func reset() -> void:
		chaseTime = 0
		chaseBark = ""

class PatrolStrategy extends BehaviorStrategy:
	func _init ():
		pass
		
	func process() -> Behavior.behaviorState:
		print("Patrol Strategy")
		return Behavior.behaviorState.FAILURE
		
	func reset() -> void:
		pass

class isObjectNearbyStrategy extends BehaviorStrategy:
	
	var target : Node
	var agent : Node
	var detectionRange
	
	func _init(_target : Node, _agent : Node, _detectionRange):
		target = _target
		agent = _agent
		detectionRange = _detectionRange
		
	func process():
		if agent.distanceTo(target) < detectionRange:
			return Behavior.behaviorState.SUCCESS
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
