extends TextureRect
const SPEED = .1
const MAX_ITER_ACCEL = 110

onready var num_iter = float(self.material.get_shader_param("num_iter"))

var iter_speed = 12 #iter changes per second
var iter_accel = 0
var camera_zoom = 1
signal c_changed(c)
signal hide_ui()

func _process(delta):
	var iter_delta = Input.get_action_strength("iterup") - Input.get_action_strength("iterdown")
	if iter_delta != 0:
		num_iter += (iter_speed + iter_accel) * delta * iter_delta
		num_iter = max(num_iter,0)
		self.material.set_shader_param("num_iter",num_iter)
		iter_accel += 6*delta
		iter_accel = min(iter_accel,MAX_ITER_ACCEL)
	else:
		iter_accel = 0
		
	#move c value
	var lr = Input.get_action_strength("right") - Input.get_action_strength("left")
	var ud = Input.get_action_strength("up") - Input.get_action_strength("down")
	if lr !=0 or ud != 0:
		var c = self.material.get_shader_param("c")
		c.x += lr * SPEED * delta * (1 - (1 - camera_zoom)*(1-camera_zoom))
		c.y += ud * SPEED * delta * (1 - (1 - camera_zoom)*(1-camera_zoom))
		self.material.set_shader_param("c",c)
		emit_signal("c_changed",c)
	
	if Input.is_action_just_pressed("hide_ui"):
		emit_signal("hide_ui")

func _on_ColorPicker_color_changed(color):
	self.material.set_shader_param("r",color.r)
	
	self.material.set_shader_param("g",color.g)
	self.material.set_shader_param("b",color.b)

func _on_Camera2D_zoom_changed(zoom):
	camera_zoom=min(1,zoom.x)