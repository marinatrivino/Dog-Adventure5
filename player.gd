extends CharacterBody2D

@export var speed := 200
@export var jump_force := -400
var gravity := 980
var bones = 0
var anim: AnimationPlayer

func _physics_process(delta):
	var vel = velocity
	vel.x = 0
	
	if Input.is_action_pressed("ui_right"):
		vel.x += speed
	if Input.is_action_pressed("ui_left"):
		vel.x -= speed

	vel.y += gravity * delta

	if is_on_floor() and Input.is_action_just_pressed("ui_accept"):
		vel.y = jump_force

	velocity = vel
	move_and_slide()

func add_bone():
	bones += 1
	var label = get_node("/root/Level1/HUD/BonesLabel")
	label.text = "Bones: " + str(bones)


func _on_hueso_6_body_entered(body: Node2D) -> void:
	if body.name == "Player": # Si el nodo que entró se llama Perro
		queue_free() # Borra el huesito (como si lo hubiera agarrado)

func _ready():
	anim = $AnimationPlayer

func _physics_process(delta: float) -> void:
	var input_vector = Vector2.ZERO
	input_vector.x =
	input.get_action_strength("ui_right")-
	input.get_action_strength("UI_left")
	input_vector.y =
	input.get_action_strength("ui_down")-
	input.get_action_strength("ui_up")
	
	input_vector = input_vector.normalized()
	
	velocity = input_vector*speed
	move_and_slide()
	
	
	if input_vector !=vector2ZERO:
		if not anim.is_playing() or
		anim.current_animation !="walk":
			anim.play("walk")
			else:
				anim.stop()
