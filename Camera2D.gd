extends Camera2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const SPEED = 100
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_pressed("ui_accept")):
		self.zoom *= .97 
	if Input.is_action_pressed("ui_cancel"):	
		self.zoom *= 1.025
	if(Input.is_action_pressed("ui_left")):
		self.position.x -= SPEED * self.zoom.x * delta 
	
	if(Input.is_action_pressed("ui_right")):
		self.position.x += SPEED * self.zoom.x * delta 
	
	
	if(Input.is_action_pressed("ui_up")):
		self.position.y -= SPEED * self.zoom.y * delta 
	
	if(Input.is_action_pressed("ui_down")):
		self.position.y += SPEED * self.zoom.y * delta 
	