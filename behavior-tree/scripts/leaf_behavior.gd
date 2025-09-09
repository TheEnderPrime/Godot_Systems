class_name LeafBehavior extends Behavior

var behaviorStrategy : BehaviorStrategy #= BehaviorStrategy.do_a_thing.new() 

func LeafBehavior(_behaviorStrategy : BehaviorStrategy):
	behaviorStrategy = _behaviorStrategy

func process() -> behaviorState:
	var result = behaviorStrategy.process()
	if result: 
		return behaviorState.RUNNING 
	else: 
		return behaviorState.FAILURE
