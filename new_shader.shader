shader_type canvas_item;

uniform int num_iter=30;
uniform int pwr = 2;
uniform vec2 c=vec2(-.8,.25);
uniform float scale = 3.0;
//uniform vec4 col1 = vec4(1.,0.7,.7,1.);
uniform vec4 col2 = vec4(0.,0.,0.1,1.);
uniform float r = .1;
uniform float g = 0.9;
uniform float b = 0.7;



vec2 squared(vec2 vec){
	return vec2(vec.x*vec.x -vec.y*vec.y, 2.0*vec.x*vec.y);
}


vec2 mypow(vec2 vec, int power){
	vec2 dummy = vec;
	for(int i=0;i<power - 1;i++){
		dummy = vec2(dummy.x * vec.x - dummy.y * vec.y,   dummy.x * vec.y + dummy.y * vec.x);
	}
	return dummy;
}

float modulus(vec2 vec){
	return sqrt(vec.x*vec.x + vec.y*vec.y);
}

void fragment() {
	vec4 col1 = vec4(r,g,b,1.);
	//vec2 z = vec2((UV.x - .5) * scale, (UV.y - .5) * scale);
	vec2 z = vec2((UV.x - .5) * scale, (UV.y - .5) * -1. * scale);
	
	float intensity = 1.0;

	for(int i=0;i<num_iter;i++){
		z = mypow(z,pwr)+ c;
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