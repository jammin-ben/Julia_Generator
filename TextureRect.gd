extends TextureRect
const SPEED = .1
func _process(delta):
	if(Input.is_action_just_pressed("iterup")):
		var num_iter = self.material.get_shader_param("num_iter")
		self.material.set_shader_param("num_iter",num_iter + 1)
	if(Input.is_action_just_pressed("iterdown")):
		var num_iter = self.material.get_shader_param("num_iter")
		self.material.set_shader_param("num_iter",num_iter - 1)
		
	var lr = Input.get_action_strength("right") - Input.get_action_strength("left")
	var ud = Input.get_action_strength("up") - Input.get_action_strength("down")
	if lr !=0 or ud != 0:
		var c = self.material.get_shader_param("c")
		c.x += lr * SPEED * delta
		c.y += ud * SPEED * delta
		self.material.set_shader_param("c",c)