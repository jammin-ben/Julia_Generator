extends TextureRect
const SPEED = .1
const MAX_ITER_ACCEL = 50

onready var num_iter = float(self.material.get_shader_param("num_iter"))

var iter_speed = 12 #iter changes per second
var iter_accel = 0

signal c_changed(c)

func _process(delta):
	var iter_delta = Input.get_action_strength("iterup") - Input.get_action_strength("iterdown")
	if iter_delta != 0:
		num_iter += (iter_speed + iter_accel) * delta * iter_delta
		self.material.set_shader_param("num_iter",num_iter)
		iter_accel += 3*delta
		iter_accel = min(iter_accel,MAX_ITER_ACCEL)
	else:
		iter_accel = 0
	var lr = Input.get_action_strength("right") - Input.get_action_strength("left")
	var ud = Input.get_action_strength("up") - Input.get_action_strength("down")
	if lr !=0 or ud != 0:
		var c = self.material.get_shader_param("c")
		c.x += lr * SPEED * delta
		c.y += ud * SPEED * delta
		self.material.set_shader_param("c",c)
		emit_signal("c_changed",c)