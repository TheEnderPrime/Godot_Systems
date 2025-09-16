extends Node

# HOW TO USE:
# add marker2D nodes underneath the Waypoint scene node
#
# ENTER/INIT
# target = parentNode.waypointNode.get_start_node()
# 
# PHYSICS PROCESS LOOP
# var direction = target.global_position - parentNode.global_position
# parentNode.velocity = direction.normalized() * parentNode.moveSpeed 
# var distance_to_target = parentNode.global_position.distance_to(target.global_position)
#		
# if parentNode.velocity.length() > distance_to_target:
#	target = parentNode.waypointNode.get_next_point_node()

var active_point_index := 0

func get_start_node() -> Node:
	print(get_children())
	if get_children() == []:
		print("NO WAYPOINTS AVAILABLE. ADDING DEFAULT NODE AT AGENT LOCATION")
		var marker2D = Marker2D.new()
		var parent = get_node("../Waypoints")
		marker2D.global_position = parent.get_parent().global_position
		parent.add_child(marker2D)
	return get_child(0)
	
func get_current_point_node() -> Node:
	return get_child(active_point_index)
	
func get_next_point_node():
	active_point_index = (active_point_index + 1) % get_child_count() # handles looping back to beginning if needed
	return get_current_point_node()
