extends ColorRect

@export var pausedColour : Color
@export var unpausedColour : Color

enum PausedStates {
	UNPAUSED,
	PAUSED,
	PAUSING,
	UNPAUSING
}
var pausedState := PausedStates.UNPAUSED


func process(delta):
	if pausedState == PausedStates.PAUSING:
		color = pausedColour
		pausedState = PausedStates.PAUSED
	elif pausedState == PausedStates.UNPAUSING:
		color = unpausedColour
		pausedState = PausedStates.UNPAUSED
		StateStack.PopStack()


func input(event: InputEvent):
	if event.is_action_pressed("Pause"):
		if pausedState < PausedStates.PAUSING:
			TogglePause()


func TogglePause():
	if pausedState == PausedStates.UNPAUSED:
		pausedState = PausedStates.PAUSING
		StateStack.PushStack(self)
	elif pausedState == PausedStates.PAUSED:
		pausedState = PausedStates.UNPAUSING
