class_name UtilityAIConsideration extends UtilityAI

@export var curve: Curve:
	set(value):
		curve = value

func calculate_score() -> float:
	return _apply_curve(score())

func _apply_curve(score: float) -> float:
	if curve == null:
		push_error("'curve' not defined for '%s' consideration." % self.name)
		return 0.0

	return curve.sample_baked(score)

func score() -> float:
	return 0.0
