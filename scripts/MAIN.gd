extends Node

export(PackedScene) var enemy_scene
var score
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize() 

func game_over():
	$CanvasLayer.show_game_over()
	$Score.stop()
	$EnemyTimer.stop()
	get_tree().call_group("enemies", "queue_free")

func new_game():
	score = 0
	$CanvasLayer.update_score(score)
	$CanvasLayer.show_message("Get Ready")
	$Player.start($Startposition.position)
	$Start.start()


func _on_Start_timeout():
	$EnemyTimer.start()
	$Score.start()


func _on_Score_timeout():
	score +=1 
	$CanvasLayer.update_score(score)


func _on_EnemyTimer_timeout():
	var enemy = enemy_scene.instance()
	var enemy_spawn_location = get_node("EnemyPath/PathFollow2D")
	enemy_spawn_location.offset = randi()
	var direction = enemy_spawn_location.rotation + PI / 2
	enemy.position = enemy_spawn_location.position
	direction += rand_range(-PI / 4, PI / 4)
	enemy.rotation = direction

	var velocity = Vector2(rand_range(150.0, 250.0), 0.0)
	enemy.linear_velocity = velocity.rotated(direction)

	add_child(enemy) 



