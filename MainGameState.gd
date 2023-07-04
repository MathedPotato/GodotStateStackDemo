extends Node


func _ready():
	StateStack.PushStack(self)
	for object in find_children("*"):
		print("Child nodes:{0}".format([object.name]))


func _exit_tree():
	StateStack.PopStack()


func process(delta):
	for object in find_children("*"):
		if object.has_method("process"):
			object.process(delta)


func physics_process(delta: float) -> void:
	for object in find_children("*"):
		if object.has_method("physics_process"):
			object.physics_process(delta)


func input(event: InputEvent) -> void:
	for object in find_children("*"):
		if object.has_method("input"):
			object.input(event)


func deactivate_state():
	for object in find_children("*"):
		if object is RigidBody3D:
			object.process_mode = Node.PROCESS_MODE_DISABLED


func reactivate_state():
	for object in find_children("*"):
		if object is RigidBody3D:
			object.process_mode = Node.PROCESS_MODE_INHERIT


func activate_state():
	for object in find_children("*"):
		if object is RigidBody3D:
			object.process_mode = Node.PROCESS_MODE_INHERIT
