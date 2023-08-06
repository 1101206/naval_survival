extends RigidBody3D

@onready var subMesh = $mesh
@onready var cam = $Camera3D
# window dimensions
@export var winDim = Vector2(DisplayServer.window_get_size().x, DisplayServer.window_get_size().y)
@export var mousePos : Vector2 = winDim/2
# false because of the main menu
var ableMove = false

func _input(event):
	if event is InputEventMouseMotion:
		mousePos = Vector2(winDim.x/2 - event.position.x, winDim.y/2 - event.position.y)
	if event is InputEventFromWindow:
		winDim = Vector2(DisplayServer.window_get_size().x, DisplayServer.window_get_size().y)
# Called when the node enters the scene tree for the first time.

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(ableMove):
		move_and_collide(Vector3(-(mousePos.x/winDim.x) * .5, (mousePos.y/winDim.y) * .5, 0))
	position.z = 0.0
	subMesh.look_at(Vector3(subMesh.position.x + mousePos.x, subMesh.position.y - mousePos.y, subMesh.position.z + 600))
	cam.position.x = -mousePos.x/winDim.x * 5
	cam.position.y = mousePos.y/winDim.y * 5 + 1

func _on_node_3d_game_start():
	ableMove = true
