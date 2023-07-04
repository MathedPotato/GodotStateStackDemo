extends Node


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
