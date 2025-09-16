extends Node

var behaviorTree : BehaviorTree
@onready var agent: CharacterBody2D = get_parent()
@onready var player: CharacterBody2D = get_node("/root/Game/Player")
@onready var waypoints: Node = agent.patrolWaypoints

func _ready() -> void:
	behaviorTree = BehaviorTree.new("SlimeEnemy") 

	var idleBehavior: Behavior = Behavior.LeafBehavior.new("IdleLeaf", BehaviorStrategy.IdleStrategy.new(agent))
	var wanderBehavior: Behavior = Behavior.LeafBehavior.new("WanderLeaf", BehaviorStrategy.WanderStrategy.new(agent, agent.moveSpeed))
	var patrolBehavior: Behavior = Behavior.LeafBehavior.new("PatrolLeaf", BehaviorStrategy.PatrolStrategy.new(agent, waypoints, agent.moveSpeed))
	var isObjectNearbyBehavior: Behavior = Behavior.LeafBehavior.new("isObjectNearbyLeaf", BehaviorStrategy.isObjectNearbyStrategy.new(player, agent, agent.visionRange))
	var chaseBehavior: Behavior = Behavior.LeafBehavior.new("ChaseLeaf", BehaviorStrategy.ChaseStrategy.new(agent, player, agent.moveSpeed, agent.attackRange))
	
	var randomIdleMovementArray: Array = [
		idleBehavior,
		wanderBehavior,
		patrolBehavior
	]
	var randomIdleMovementSelector: Behavior = Behavior.RandomSelectorBehavior.new("randomIdleMovementSelector",randomIdleMovementArray)
	
	var ChaseAndAttackSequenceArray: Array = [
		isObjectNearbyBehavior,
		chaseBehavior,
		idleBehavior
	]
	var ChaseAndAttackSequence: Behavior = Behavior.SequenceBehavior.new("ChaseAndAttackSequence", ChaseAndAttackSequenceArray)
	
	var canSeePlayerArray: Array = [
		ChaseAndAttackSequence,
		randomIdleMovementSelector
	]
	var canSeePlayer: Behavior = Behavior.SelectorBehavior.new("CanSeePlayer", canSeePlayerArray)
	
	behaviorTree.add_child(canSeePlayer)

func _process(_delta: float) -> void:
	behaviorTree.process()
	#match behaviorTree.process():
		#Behavior.behaviorState.SUCCESS:
			#print("Tree Complete!")
			#queue_free()
		#Behavior.behaviorState.FAILURE:
			#print("Tree FAILURE")
			#queue_free()


class BehaviorTree extends Behavior:
	
	func _init(_name : String):
		super(_name)
	
	func process() -> Behavior.behaviorState:
		for behavior: Behavior in children:
			var result = behavior.process()
			if result != behaviorState.SUCCESS:
				return result 
		return behaviorState.SUCCESS
