extends RigidBody3D

@onready var subMesh = $mesh
@onready var cam = $Camera3D
@export var SPEED = .02
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
		displayStats()
	
		rotation.y += (mousePos.x/winDim.x) * .01
		rotation.y = lerp(rotation.y, 0.0, .005)
		
		rotation.x += (mousePos.y/winDim.y) * .01
		rotation.x = lerp(rotation.x, 0.0, .005)
		
		var tempRot = Vector2(subMesh.rotation.x, subMesh.rotation.y)
		subMesh.look_at(Vector3((subMesh.position.x + mousePos.x)*.75, (subMesh.position.y - mousePos.y)*.75, subMesh.position.z + 500))
		subMesh.rotation.x = lerp_angle(tempRot.x, subMesh.rotation.x, .03)
		subMesh.rotation.y = lerp_angle(tempRot.y, subMesh.rotation.y, .03)
		
		move_and_collide(Vector3(-(mousePos.x/winDim.x) * .1, (mousePos.y/winDim.y) * .1, -SPEED))
	
	cam.position = Vector3(-mousePos.x/winDim.x , mousePos.y/winDim.y + 1, cam.position.z)

func _on_node_3d_game_start():
	ableMove = true

func displayStats():
	$Control/VBoxContainer/HBoxContainer/speed.text = str(round(SPEED))

func _on_area_3d_body_entered(body):
	if body.is_in_group("terrain"):
		ableMove = false
		subMesh.hide()
