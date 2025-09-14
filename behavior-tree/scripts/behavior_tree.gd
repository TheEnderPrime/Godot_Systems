extends Node

var behaviorTree : BehaviorTree

func _ready() -> void:
	behaviorTree = BehaviorTree.new("hello") 
	var sequenceArray : Array = [
		Behavior.LeafBehavior.new("WanderLeaf", BehaviorStrategy.WanderStrategy.new()),
		Behavior.LeafBehavior.new("IdleLeaf", BehaviorStrategy.IdleStrategy.new(get_parent())),
		Behavior.LeafBehavior.new("ChaseLeaf", BehaviorStrategy.ChaseStrategy.new(4, "BARK BARK"))
	]
	
	behaviorTree.add_child(Behavior.LeafBehavior.new("solo idle", BehaviorStrategy.IdleStrategy.new(get_parent())))
	behaviorTree.add_child(Behavior.RandomSequenceBehavior.new("Test Sequence", sequenceArray))
	behaviorTree.add_child(Behavior.LeafBehavior.new("final idle", BehaviorStrategy.IdleStrategy.new(get_parent())))

func _process(_delta: float) -> void:
	#behaviorTree.process()
	match behaviorTree.process():
		Behavior.behaviorState.SUCCESS:
			print("Tree Complete!")
			queue_free()
		Behavior.behaviorState.FAILURE:
			print("Tree FAILURE")
			queue_free()


class BehaviorTree extends Behavior:
	
	func _init(_name : String):
		super(_name)
	
	func process() -> Behavior.behaviorState:
		for behavior: Behavior in children:
			var result = behavior.process()
			if result != behaviorState.SUCCESS:
				return result 
		return behaviorState.SUCCESS
