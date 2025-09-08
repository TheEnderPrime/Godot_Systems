extends Node

var active_point_index := 0

func get_start_node() -> Node:
	return get_child(0)
	
func get_current_point_node() -> Node:
	return get_child(active_point_index)
	
func get_next_point_node():
	active_point_index = (active_point_index + 1) % get_child_count() # handles looping back to beginning if needed
	return get_current_point_node()
