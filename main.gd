extends Node3D

signal gameStart
var gameStarted = false
var SPEED = 5
var speedCap = 10

@onready var player = $Player
@onready var level = $level
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	# (mousePos.x/winDim.x) * .5, (mousePos.y/winDim.y) * .5
	
	# SPEED = Vector2((player.mousePos.x/player.winDim.x), (player.mousePos.y/player.winDim.y))
	# SPEED = 1/SPEED.distance_to(Vector2(0, 0))
	# SPEED = min(SPEED, speedCap)
	# if(gameStarted):
	# 	level.position.z += SPEED * delta
	

func _on_start_btn_pressed():
	gameStarted = true
	# Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	emit_signal("gameStart")
	$Player/AnimationPlayer.play("driveSubInView")
	$control/mainMenuUI.hide()


func _on_exit_btn_pressed():
	get_tree().quit()
