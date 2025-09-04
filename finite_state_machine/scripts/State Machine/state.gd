@abstract class_name State

var Action: Dictionary = {}
@abstract func on_enter()
@abstract func on_update(_delta: float)
@abstract func on_exit()

class IdleState extends State:
	func on_enter():
		print("Enter Idle State")
	#
	func on_update(_delta):
		print ("Update Idle State")
	#
	func on_exit():
		print("Exit Idle State")

class WanderState extends State:
	func on_enter():
		print("Enter Wander State")
	#
	func on_update(_delta):
		print ("Update Wander State")
	#
	func on_exit():
		print("Exit Wander State")

class ChaseState extends State:
	func on_enter():
		print("Enter Chase State")
	#
	func on_update(_delta):
		print ("Update Chase State")
	#
	func on_exit():
		print("Exit Chase State")
