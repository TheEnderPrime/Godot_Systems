@abstract class_name State extends Resource

var Action: Dictionary = {}
@abstract func get_state_name() -> String
@abstract func enter()
@abstract func update(_delta: float, stateMachine)
@abstract func exit()

class Idle_State extends State:
	func get_state_name() -> String:
		return "Idle_State"
	func enter():
		print("Enter Idle State")
	#
	func update(_delta, stateMachine):
		print ("Update Idle State")
		stateMachine.change_state(Chase_State)
		
	func exit():
		print("Exit Idle State")

class Wander_State extends State:
	func get_state_name() -> String:
		return "Wander_State"
		
	func enter():
		print("Enter Wander State")
	
	func update(_delta, stateMachine):
		print ("Update Wander State")
		stateMachine.change_state(Idle_State)
	func exit():
		print("Exit Wander State")

class Chase_State extends State:
	func get_state_name() -> String:
		return "Chase_State"
		
	func enter():
		print("Enter Chase State")
	#
	func update(_delta, stateMachine): 
		print ("Update Chase State")
		stateMachine.change_state(Wander_State)
	#
	func exit():
		print("Exit Chase State")
