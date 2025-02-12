extends Node


@export var mob_scene: PackedScene
@export var box_scene: PackedScene
var score


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass


func game_over() -> void:
	$ScoreTimer.stop()
	$MobTimer.stop()
	
	$Wall.hide()
	$Wall2.hide()
	$Wall3.hide()
	$Wall4.hide()
	
	get_tree().call_group("boxes", "queue_free")
	get_tree().call_group("mobs", "queue_free")
	
	$HUD.show_game_over()
	
	$Music.stop()
	$DeathSound.play()


func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	
	$Wall.show()
	$Wall2.show()
	$Wall3.show()
	$Wall4.show()
	
	var box1 = box_scene.instantiate()
	box1.position = Vector2(128,512)
	add_child(box1)
	var box2 = box_scene.instantiate()
	box2.position = Vector2(388,392)
	add_child(box2)
	var box3 = box_scene.instantiate()
	box3.position = Vector2(176,232)
	add_child(box3)
	
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	
	get_tree().call_group("mobs", "queue_free")
	
	$Music.play()


func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()


func _on_score_timer_timeout() -> void:
	score += 1
	
	$HUD.update_score(score)


func _on_mob_timer_timeout() -> void:
	var mob = mob_scene.instantiate()
	mob.scale = Vector2(0.5,0.5)
	
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	
	var direction = mob_spawn_location.rotation + PI / 2
	
	mob.position = mob_spawn_location.position
	
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)
