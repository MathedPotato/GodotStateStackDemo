extends ColorRect

@export var pausedColour : Color
@export var unpausedColour : Color
var pausedState := 0


func process(delta):
	if pausedState >= 2:
		if pausedState == 2:
			color = pausedColour
			pausedState = 1
		else:
			color = unpausedColour
			pausedState = 0
			StateStack.PopStack()


func input(event: InputEvent):
	if event.is_action_pressed("Pause"):
		if pausedState < 2:
			TogglePause()


func TogglePause():
	if pausedState == 0:
		pausedState = 2
		StateStack.PushStack(self)
	elif pausedState == 1:
		pausedState = 3
