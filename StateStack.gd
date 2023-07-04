extends Node
# This is the main state stack object that runs on game launch as a singleton.
# It essentially relays built-in function calls (_process, _physics_process and _input)
#  to the object at the top of the stack (usually a scene root node, which then relays
#  those same function calls to it's children), calling that object's process, physics_process
#  and input functions (note the absence of the underscore prefix).
# For this to work properly, this does rely on making sure all objects (with possible exceptions)
#  use the non-underscore versions of those functions (making a script template helps with this).
# The state stack proves to be useful in managing the active state of groups and subgroups of
#  objects, and is particularly useful when implementing a pause screen.

var stack : Array


func _process(delta: float) -> void:
	if stack.size() == 0: return
	if stack.back().has_method("process"):
		stack.back().process(delta)
	if stack.back().has_method("inactive_process"):
		stack.back().inactive_process(delta)


func _physics_process(delta: float) -> void:
	if stack.size() == 0: return
	if stack.back().has_method("physics_process"):
		stack.back().physics_process(delta)
	if stack.back().has_method("inactive_physics_process"):
		stack.back().inactive_physics_process(delta)


func _input(event: InputEvent) -> void:
	if stack.size() == 0: return
	if stack.back().has_method("input"):
		stack.back().input(event)
	if stack.back().has_method("inactive_input"):
		stack.back().inactive_input(event)


func PushStack(state: Node) -> void:
	if stack.size() > 0 and stack.back().has_method("deactivate_state"):
		stack.back().deactivate_state()
	stack.push_back(state)
#	state.tree_exiting.connect(PopStack)
	if stack.back().has_method("activate_state"):
		stack.back().activate_state()


func PopStack() -> Node:
	var topState = stack.pop_back()
	if stack.size() == 0: return
	if stack.back().has_method("reactivate_state"):
		stack.back().reactivate_state()
	return topState
