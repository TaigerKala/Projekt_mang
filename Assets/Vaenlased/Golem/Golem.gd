extends KinematicBody2D

enum GolemState {
	IDLE,
	MOVE,
	ATK_PUNCH,
	TAKE_DMG,
	DEATH
}

export var max_speed := 450.0
export var drag_factor := 0.1

var velocity := Vector2.ZERO
var target: KinematicBody2D
var state = GolemState.IDLE

onready var aggro_area := $AggroArea
onready var dmg_area := $DmgArea
onready var animation_tree := $AnimationTree
onready var state_machine = animation_tree.get("parameters/playback")

func _ready() -> void:
	aggro_area.connect("body_entered", self, "_on_player_entered")
	aggro_area.connect("body_exited", self, "_on_player_exited")
	dmg_area.connect("body_entered", self, "_initiate_atk")

func _physics_process(delta: float) -> void:
	#Golemi liikumine
	var direction := Vector2.ZERO
	
	if state == GolemState.ATK_PUNCH:
		pass
	else:
		if target:
			direction = to_local(target.global_position).normalized()
			set_state(GolemState.MOVE)
		
	#Suuna muutus
		var desired_velocity := max_speed * direction
		var steering_vector := desired_velocity - velocity
	
		velocity += steering_vector * drag_factor
	
		velocity = move_and_slide(velocity)
	
		if direction == Vector2.ZERO:
			set_state(GolemState.IDLE)
	
func set_state(new_state):
	state = new_state
	enter_new_state(state)
	
func enter_new_state(state):
	match state:
		GolemState.IDLE:
			state_machine.travel("idle")
		GolemState.MOVE:
			state_machine.travel("move")
		GolemState.ATK_PUNCH:
			state_machine.travel("atk_punch")
		GolemState.TAKE_DMG:
			state_machine.travel("take_dmg")
		GolemState.DEATH:
			state_machine.travel("death")

func _on_player_entered(body: KinematicBody2D) -> void:
	target = body
	set_state(GolemState.MOVE)
	
func _on_player_exited(body: KinematicBody2D) -> void:
	target = null
	
func _initiate_atk(body: KinematicBody2D) -> void:
	if body.is_in_group("Player"):
		set_state(GolemState.ATK_PUNCH)
