extends Node

var behaviorTree : BehaviorTree


func _ready() -> void:
	behaviorTree = BehaviorTree.new("hello") 
	behaviorTree.add_child(Behavior.LeafBehavior.new("WanderLeaf", BehaviorStrategy.WanderStrategy.new()))
	behaviorTree.add_child(Behavior.LeafBehavior.new("IdleLeaf", BehaviorStrategy.IdleStrategy.new()))

func _process(_delta: float) -> void:
	behaviorTree.process()
	

class BehaviorTree extends Behavior:
	
	func _init(_name : String):
		super(_name)
	
	func process() -> Behavior.behaviorState:
		for behavior: Behavior in children:
			var result = behavior.process()
			if result != behaviorState.SUCCESS:
				return result 
		return behaviorState.SUCCESS
