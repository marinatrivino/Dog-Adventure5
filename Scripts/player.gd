extends CharacterBody2D

@export var speed := 200
@export var jump_force := -400
var gravity := 980

var bones = 0
var anim: AnimationPlayer
var respawn_position: Vector2
var death_y: float = 1200.0
var invulnerable := false

func _physics_process(delta):
	velocity.x = 0
	if Input.is_action_pressed("ui_right"):
		velocity.x += speed
	if Input.is_action_pressed("ui_left"):
		velocity.x -= speed
	# Gravedad
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0  # ⚠️ resetea al tocar el piso

	if is_on_floor() and Input.is_action_just_pressed("ui_accept"):
		velocity.y = jump_force
	
	if global_position.y > death_y:
		print("Cayó abajo, debería morir")
		die()
	
	move_and_slide()


func add_bone():
	bones += 1
	var label = get_node("/root/Level1/HUD/BonesLabel")
	label.text = "Bones: " + str(bones)

func _on_hueso_6_body_entered(body: Node2D) -> void:
	if body.name == "Player": 
		queue_free() 

func _ready():
	anim = $AnimationPlayer
	respawn_position = global_position  


func die():
	if invulnerable:
		return
	print("Player murió")
	if $AnimatedSprite2D.sprite_frames.has_animation("death") \
		and $AnimatedSprite2D.sprite_frames.get_frame_count("death") > 0:
			$AnimatedSprite2D.play("death")
	
	set_physics_process(false)
	if $CollisionShape2D:
		$CollisionShape2D.disabled = true
	GameManager.lose_life()
	
	var timer = get_tree().create_timer(1.0)
	await timer.timeout
	on_respawn()

func on_respawn():
	global_position = GameManager.respawn_position
	velocity = Vector2.ZERO
	
	set_physics_process(true)
	if $CollisionShape2D:
		$CollisionShape2D.disabled = false

	invulnerable = true
	var timer = get_tree().create_timer(1.0)
	await timer.timeout
	invulnerable = false
