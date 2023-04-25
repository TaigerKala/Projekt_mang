extends KinematicBody2D

onready var animation_player := $AnimationPlayer
onready var pilt := $AnimatedSprite
onready var animation_tree := $AnimationTree
onready var state_machine = animation_tree.get("parameters/playback")

const SPEED := 700.0

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("move_left","move_right","move_up","move_down")
	var velocity := direction * SPEED
	move_and_slide(velocity)
	
	if direction:
		state_machine.travel("move")
		pilt.flip_h = sign(direction.x) == -1
	else:
		state_machine.travel("idle")
	
	if Input.is_action_just_pressed("atk_slam"):
		state_machine.travel("atk_slam")
	if Input.is_action_just_pressed("atk_slash"):
		state_machine.travel("atk_slash")
	if Input.is_action_just_pressed("atk_spin"):
		state_machine.travel("atk_spin")
		
func stop_physics():
	set_physics_process(false)
	return 

func start_physics():
	set_physics_process(true)
	return
