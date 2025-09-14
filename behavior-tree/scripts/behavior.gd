class_name Behavior extends Resource

var name : String
enum behaviorState { RUNNING, SUCCESS, FAILURE,}
var children : Array

func _init (_name : String = "defaultBehavior"):
	self.name = _name

func add_child(child : Behavior):
	children.append(child)

func process() -> behaviorState:
	return behaviorState.SUCCESS

func reset() -> void:
	for child : Behavior in children:
		child.reset()


# no children, handles game logic
class LeafBehavior extends Behavior:
	var behaviorStrategy : BehaviorStrategy

	func _init (_name: String, _behaviorStrategy : BehaviorStrategy):
		super(_name)
		behaviorStrategy = _behaviorStrategy

	func process() -> behaviorState:
		print("Enter Leaf: " + name)
		return behaviorStrategy.process()

	func reset() -> void:
		print("Leaf Reset")
		behaviorStrategy.reset()

# process in order, if all pass return success, if one fails immediately return failure
class SequenceBehavior extends Behavior:
	
	var sequence : Array
	var result : behaviorState
	
	func _init(_name: String, _sequence : Array):
		super(_name)
		sequence = _sequence
		
	func process() -> behaviorState:
		print("Enter Sequence (" + name + ") : " + (behaviorState.keys())[result])
		for behavior: Behavior in sequence:
			match behavior.process():
				behaviorState.RUNNING:
					return behaviorState.RUNNING
				behaviorState.FAILURE:
					return behaviorState.FAILURE
		reset()
		return behaviorState.SUCCESS
		
	func reset():
		for behavior: Behavior in sequence:
			print("Sequence Reset: " + behavior.name)
			behavior.reset()

# reorders sequence randomly, then runs as SequenceBehavior
class RandomSequenceBehavior extends SequenceBehavior:
	
	var randomSequence : Array
	
	func _init(_name: String, _sequence : Array):
		super(_name, _sequence)
		for i : int in sequence.size():
			var random = sequence.pick_random()
			randomSequence.append(random)
			sequence.erase(random)
		sequence = randomSequence
		
	func process():
		print("Enter Random Sequence: " + name)
		return super()
		#for i : int in sequence.size():
			#var random = sequence.pick_random()
			#randomSequence.append(random)
			#sequence.erase(random)
		#
		#Behavior.SequenceBehavior.new("RandomSequenceBehavior", randomSequence).process()

# will return a success if any of its children succeed and not process any further children
class SelectorBehavior extends Behavior:
	
	var selection : Array
	var result : behaviorState
	
	func _init(_name: String, _selection: Array):
		super(_name)
		selection = _selection
		
	func process():
		print("Enter Selection: " + name)
		for behavior : Behavior in selection:
			match behavior.process():
				behaviorState.SUCCESS:
					return behaviorState.SUCCESS
				behaviorState.RUNNING:
					return behaviorState.RUNNING
		#reset()
		return behaviorState.FAILURE

# reorders selection randomly, then runs as SelectionBehavior
class RandomSelectorBehavior extends SelectorBehavior:
	var randomSelection : Array
	
	func _init(_name: String, _selection : Array):
		selection = _selection
		for i : int in selection.size():
			var random = selection.pick_random()
			randomSelection.append(random)
			selection.erase(random)
		selection = randomSelection
		
	func process():
		print("Enter Random Selector: " + name)
		return super()
		#for i : int in selector.size():
			#var random = selector.pick_random()
			#randomSelector.append(random)
			#selector.erase(random)
		#
		#Behavior.SelectorBehavior.new("RandomSelectorBehavior", randomSelector).process()

# TODO add priority to all behaviors
# sorts children based on behavior priority then runs as SelectionBehavior
class PrioritySelectorBehavior extends SelectorBehavior:
	pass

# returns opposite of given state (SUCCESS = FAILURE, FAILURE = SUCCESS)
class InverterBehavior extends Behavior:
	
	var result : behaviorState
	
	func _init(_name: String, _result: behaviorState):
		super(name)
		result = _result
	
	func process():
		print("Enter Inverter : " + name)
		if result == behaviorState.SUCCESS:
			return behaviorState.FAILURE
		elif result == behaviorState.FAILURE:
			return behaviorState.SUCCESS
		else:
			return result

# always returns SUCCESS
class SucceederBehavior extends Behavior:
	
	func _init(_name: String):
		super(_name)
		
	func process():
		print("Enter Succeeder: " + name)
		return behaviorState.SUCCESS

# repeats behavior infinitely OR a given number of times
class RepeaterBehavior extends Behavior:
		
	var numOfRepeats : int
	var behaviorStrategy : BehaviorStrategy
	
	func _init(_name: String, _behaviorStrategy: BehaviorStrategy, _numOfRepeats: int = -1):
		super(name)
		numOfRepeats = _numOfRepeats
		behaviorStrategy = _behaviorStrategy
		
	func process():
		print("Enter Repeater: " + name)
		while numOfRepeats > 0:
			behaviorStrategy.process()
			if numOfRepeats != -1:
				numOfRepeats -= 1
		return behaviorState.SUCCESS

# repeats behavior until FAILURE then returns SUCCESS
class RepeatUntilFailBehavior extends Behavior:
	
	var result: behaviorState
	var behaviorStrategy : BehaviorStrategy
	
	func _init(_name: String, _behaviorStrategy: BehaviorStrategy):
		super(name)
		behaviorStrategy = _behaviorStrategy
		
	func process():
		print("Enter Repeat Until Failure: " + name)
		while result != behaviorState.FAILURE: 
			behaviorStrategy.process()	
		return behaviorState.SUCCESS
