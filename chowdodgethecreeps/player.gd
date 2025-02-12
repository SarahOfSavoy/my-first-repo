extends CharacterBody2D
signal hit


@export var speed = 400
@export var bullet_scene: PackedScene
@export var bullet_speed = 250.0
var screen_size
var game_started = false


func _ready() -> void:
	screen_size = get_viewport_rect().size
	
	#hide()


func _physics_process(delta: float) -> void:
	velocity = Vector2.ZERO
	
	velocity = speed * Input.get_vector("move_left","move_right","move_up","move_down")

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	move_and_slide()
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if get_slide_collision_count() > 0 and get_last_slide_collision().get_collider() is Mob:
		hide()
		game_started = false
		hit.emit()
		$CollisionShape2D.set_deferred("disabled", true)
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0
	
	if Input.is_action_just_released("shoot") and game_started:
		var bullet = bullet_scene.instantiate()

		var bullet_spawn_location = position
		
		var direction = get_global_mouse_position() - position
		
		direction = direction.normalized()
		
		bullet.position = bullet_spawn_location
		
		bullet.rotation = direction.angle()
		
		bullet.direction = direction
		
		get_parent().add_child(bullet)



func start(pos):
	game_started = true
	position = pos
	show()
	$CollisionShape2D.disabled = false

func my_func_member2():
	print("Hello from my_func_member2")


func my_func_member1():
    print("Hello I am making a conflict")

here are some more changes
