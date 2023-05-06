extends KinematicBody2D

export var max_speed := 450.0
export var drag_factor := 0.1

var velocity := Vector2.ZERO
var target: KinematicBody2D

onready var aggro_area := $AggroArea
onready var animation_tree := $AnimationTree
onready var state_machine = animation_tree.get("parameters/playback")

func _ready() -> void:
	aggro_area.connect("body_entered", self, "_on_player_entered")
	aggro_area.connect("body_exited", self, "_on_player_exited")

func _physics_process(delta: float) -> void:
	#Golemi liikumine
	var direction := Vector2.ZERO
	state_machine.travel("idle")
	
	if target:
		direction = to_local(target.global_position).normalized()
		state_machine.travel("move")

	#Suuna muutus
	var desired_velocity := max_speed * direction
	var steering_vector := desired_velocity - velocity
	
	velocity += steering_vector * drag_factor
	
	velocity = move_and_slide(velocity)

func _on_player_entered(enemy: KinematicBody2D) -> void:
	target = enemy
	
func _on_player_exited(enemy: KinematicBody2D) -> void:
	target = null
	
func atk_enemy():
	state_machine.travel("atk_punch")

