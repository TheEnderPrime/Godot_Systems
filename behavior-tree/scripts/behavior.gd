class_name Behavior extends Resource

var name : String
enum behaviorState { RUNNING, SUCCESS, FAILURE,}
var parent : Behavior
var children : Dictionary = {}
var currentChild : int

func _init (_name : String = "defaultBehavior"):
	self.name = _name

func add_child(child : Behavior):
	children[child] = child

func process() -> behaviorState:
	return children[currentChild].process()

func reset() -> void:
	currentChild = 0
	for child : Behavior in children:
		child.reset()


class LeafBehavior extends Behavior:
	var behaviorStrategy : BehaviorStrategy

	func _init (_name: String, _behaviorStrategy : BehaviorStrategy):
		super(_name)
		behaviorStrategy = _behaviorStrategy

	func process() -> behaviorState:
		return behaviorStrategy.process()

	func reset() -> void:
		behaviorStrategy.reset()

class SequenceBehavior extends Behavior:
	pass
	
class SelectorBehavior extends Behavior:
	pass
	
class RandomSequenceBehavior extends Behavior:
	pass
	
class RandomSelectorBehavior extends Behavior:
	pass
	
class InverterBehavior extends Behavior:
	pass
	
class RepeaterBehavior extends Behavior:
	pass
	
class RepeatUntilFailBehavior extends Behavior:
	pass
