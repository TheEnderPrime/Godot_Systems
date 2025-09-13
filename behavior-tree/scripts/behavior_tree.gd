extends Node

var behaviorTree : BehaviorTree
var overallResult: Behavior.behaviorState

func _ready() -> void:
	behaviorTree = BehaviorTree.new("hello") 
	var sequenceArray : Array = [
		Behavior.LeafBehavior.new("WanderLeaf", BehaviorStrategy.WanderStrategy.new()),
		Behavior.LeafBehavior.new("IdleLeaf", BehaviorStrategy.IdleStrategy.new()),
		Behavior.LeafBehavior.new("ChaseLeaf", BehaviorStrategy.ChaseStrategy.new(10, "BARK BARK"))
	]
	behaviorTree.add_child(Behavior.SequenceBehavior.new("test", sequenceArray))

func _process(_delta: float) -> void:
	overallResult = behaviorTree.process()
	
	if overallResult == Behavior.behaviorState.FAILURE:
		print("Farewell Cruel World!")
		queue_free()
	

class BehaviorTree extends Behavior:
	
	func _init(_name : String):
		super(_name)
	
	func process() -> Behavior.behaviorState:
		for behavior: Behavior in children:
			var treeResult = behavior.process()
			if treeResult != behaviorState.SUCCESS:
				return treeResult 
		return behaviorState.SUCCESS
