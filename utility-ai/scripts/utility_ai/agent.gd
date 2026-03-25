class UtilityAIAgent extends UtilityAI:
	
	var currentTopAction: UtilityAI
	var actions: Array
	
	@export var enabled:= false
	
	# Emitted when the highest scored action changed.
	signal top_action_changed(currentTopAction)


	func _physics_process(_delta: float) -> void:
		if not enabled:
			return
		process_actions()


	func process_actions() -> void:
		var topAction = get_highest_utility_action(actions)

		# if different to current highest action, signal
		if topAction != null and topAction != currentTopAction:
			currentTopAction = topAction
			top_action_changed.emit(currentTopAction)


	func get_highest_utility_action(actions: Array) -> UtilityAIAction:
		var highest_utility_action: UtilityAIAction
		var current_highest_utility_score:= 0.0
		
		for action in actions:
			var actionScore = action.calculate_score()
			if actionScore >= current_highest_utility_score:
				current_highest_utility_score = actionScore
				highest_utility_action = action
		return highest_utility_action
