class_name UtilityAIAction extends UtilityAI

# List of Considerations
# Func to Calculate the Score of the Considerations

var consideration: UtilityAIConsideration

func calculate_score() -> float:
	
	return consideration.calculate_score()
