shader_type canvas_item;

uniform int num_iter=20;
uniform vec2 c=vec2(-.8,.25);
uniform float scale = 3.0;
uniform vec4 col1 = vec4(1.,0.7,.7,1.);
uniform vec4 col2 = vec4(.2,0.,0.,1.);

vec2 squared(vec2 vec){
	return vec2(vec.x*vec.x -vec.y*vec.y, 2.0*vec.x*vec.y);
}

float modulus(vec2 vec){
	return sqrt(vec.x*vec.x + vec.y*vec.y);
}

void fragment() {
	vec2 z = vec2((UV.x - .5) * scale, (UV.y - .5) * scale);
	float intensity = 1.0;

	for(int i=0;i<num_iter;i++){
		z = squared(z)+ c;
		if(modulus(z)>=2.0){
			intensity = float(i) / float(num_iter);
			//COLOR.g = float(i) / float(num_iter);
			break;
		}
	}
	intensity *= intensity;
	if(intensity < 1.0)
		COLOR = intensity*col1 + (1.0-intensity) * col2;
	else
		COLOR= vec4(0.0,0.0,0.0,1.0);
		//else{
		//	COLOR.r = 0.0;
		//	COLOR.g = 0.0;
		//	COLOR.b = 0.0;
		//}
	
	
	//COLOR = vec4(UV.x,UV.y,UV.y*UV.x,.5);
}