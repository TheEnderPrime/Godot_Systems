class_name Behavior extends Resource

var name : String
enum behaviorState { RUNNING, SUCCESS, FAILURE,}
var parent : Behavior
var children : Dictionary = {}
var currentChild : int

func Behavior (_name : String = "behavior"):
	self.name = _name

func add_child(child : Behavior):
	children[child] = child

func process() -> behaviorState:
	return children[currentChild].process()

func reset() -> void:
	currentChild = 0
	for child : Behavior in children:
		child.reset()
