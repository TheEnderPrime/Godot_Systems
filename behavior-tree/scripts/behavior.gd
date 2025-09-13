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

# no children, handles game logic
class LeafBehavior extends Behavior:
	var behaviorStrategy : BehaviorStrategy

	func _init (_name: String, _behaviorStrategy : BehaviorStrategy):
		super(_name)
		behaviorStrategy = _behaviorStrategy

	func process() -> behaviorState:
		return behaviorStrategy.process()

	func reset() -> void:
		behaviorStrategy.reset()

# process in order, if all pass return success, if one fails immediately return failure
class SequenceBehavior extends Behavior:
	
	var sequence : Array
	var result : behaviorState
	
	func _init(_name: String, _sequence : Array):
		super(_name)
		sequence = _sequence
		
	func process() -> behaviorState:
		print("Enter Sequence Behavior : " + (behaviorState.keys())[result])
		for behavior: Behavior in sequence:
			result = behaviorState.RUNNING
			while result == behaviorState.RUNNING:
				print(behavior.name + " : " + (behaviorState.keys())[result])
				result = behavior.process()
				if result == behaviorState.FAILURE:
					return result
		return behaviorState.SUCCESS
		
	func reset():
		for behavior: Behavior in sequence:
			behavior.reset()

# will return a success if any of its children succeed and not process any further children
class SelectorBehavior extends Behavior:
	
	var selection : Array
	var result : behaviorState
	
	func _init(_name: String, _selection: Array):
		super(_name)
		selection = _selection
		
	func process():
		for behavior : Behavior in selection:
			result = behavior.process()
			if result == behaviorState.SUCCESS:
				return result
		return behaviorState.FAILURE

# reorders sequence randomly, then runs as SequenceBehavior
class RandomSequenceBehavior extends Behavior:
	
	var sequence : Array
	var randomSequence : Array
	var result : behaviorState
	
	func _init(_name: String, _sequence : Array):
		super(_name)
		sequence = _sequence
		
	func process():
		for i : int in sequence.size():
			var random = sequence.pick_random()
			randomSequence.append(random)
			sequence.erase(random)
		
		Behavior.SequenceBehavior.new("RandomSequenceBehavior", randomSequence).process()

# reorders selection randomly, then runs as SelectionBehavior
class RandomSelectorBehavior extends Behavior:
	var selector : Array
	var randomSelector : Array
	var result : behaviorState
	
	func _init(_name: String, _selector : Array):
		super(_name)
		selector = _selector
		
	func process():
		for i : int in selector.size():
			var random = selector.pick_random()
			randomSelector.append(random)
			selector.erase(random)
		
		Behavior.SelectorBehavior.new("RandomSelectorBehavior", randomSelector).process()

# returns opposite of given state (SUCCESS = FAILURE, FAILURE = SUCCESS)
class InverterBehavior extends Behavior:
	
	var result : behaviorState
	
	func _init(_name: String, _result : behaviorState):
		super(name)
		result = _result
	
	func process():
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
		while result != behaviorState.FAILURE: 
			behaviorStrategy.process()	
		return behaviorState.SUCCESS
