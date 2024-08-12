extends Node2D

@onready var main = get_tree().get_root().get_node("Test")
@onready var projectile = load("res://data/images/Entities/Projectiles/projectile.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	shoot()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func shoot():
	var instance = projectile.instantiate()
	instance.dir = rotation
	instance.spawnPos = global_position
	instance.spawnRot = rotation
	instance.zdex = z_index - 1
	main.add_child.call_deferred(instance)


func _on_timer_timeout():
	shoot()
