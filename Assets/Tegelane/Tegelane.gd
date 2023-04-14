extends KinematicBody2D

onready var sprite := $Pilt

const SPEED := 700.0

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("move_left","move_right","move_up","move_down")
	var velocity := direction * SPEED
	move_and_slide(velocity)
	
	if direction:
		sprite.flip_h = sign(direction.x) == -1
