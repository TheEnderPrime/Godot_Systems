@abstract class_name BehaviorStrategy

var behaviorContext : Behavior
@abstract func process() -> bool


class do_a_thing extends BehaviorStrategy:
	func process() -> bool:
		print("did a thing")
		return true


class stop_a_thing extends BehaviorStrategy:
	func process() -> bool:
		print("HEY STOP")
		return false
