extends Node

var Start : Behavior

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Start = LeafBehavior.new() 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(Start.process())
	
