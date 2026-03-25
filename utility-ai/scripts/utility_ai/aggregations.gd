class_name UtilityAIAggregation extends UtilityAIConsideration
	
# Handles all SUM, SUB, MULT, DIV aggregations of child considerations

enum AGGREGATION {
	AVG,
	MULT,
	SUM,
	MAX,
	MIN,
}

var considerations : Array

@export var aggregation_type: AGGREGATION = AGGREGATION.MULT

var aggregation_handler = {
	AGGREGATION.AVG: _average,
	AGGREGATION.MULT: _mult,
	AGGREGATION.SUM: _sum,
	AGGREGATION.MAX: _max,
	AGGREGATION.MIN: _min,
	}


func calculate_score() -> float:
	return aggregation_handler[aggregation_type].call()


func _average():
	var num_of_considerations := 0
	var total_sum := 0.0
	for consideration in considerations:
		total_sum += consideration.calculate_score()
		num_of_considerations += 1
		
	if num_of_considerations == 0:
		return 0.0
		
	return total_sum / num_of_considerations


func _mult():
	var num_of_considerations := 0
	var score := 1.0
	for consideration in considerations:
		num_of_considerations += 1
		score *= consideration.calculate_score()

	if num_of_considerations == 0:
		return 0.0
	
	return score


func _sum():
	var num_of_considerations := 0
	var score := 0.0
	for consideration in considerations:
		num_of_considerations += 1
		score += consideration.calculate_score()

	if num_of_considerations == 0:
		return 0.0
	
	return score


func _max():
	var highest_score := 0.0
	for consideration in considerations:
		highest_score = max(consideration.calculate_score(), highest_score)
	
	return highest_score


func _min():
	var highest_score := 0.0
	for consideration in considerations:
		highest_score = min(consideration.calculate_score(), highest_score)
	
	return highest_score
