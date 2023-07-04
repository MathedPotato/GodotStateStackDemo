extends AnimationPlayer

enum processModes {
	Process,
	Physics
}

@export var actualProcessMode : processModes

func process(delta):
	if actualProcessMode == processModes.Process and playback_process_mode == ANIMATION_PROCESS_MANUAL:
		advance(delta)

func physics_process(delta):
	if actualProcessMode == processModes.Physics and playback_process_mode == ANIMATION_PROCESS_MANUAL:
		advance(delta)
