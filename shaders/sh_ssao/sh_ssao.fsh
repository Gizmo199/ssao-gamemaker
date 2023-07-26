#define SAMP_NUM 16

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D	normal;
uniform sampler2D	depth;
uniform vec3		samples[SAMP_NUM];
uniform mat4		projmat;
varying mat4		v_vProjInv;

uniform float		radius;
uniform float		bias;
uniform float		magnitude;
uniform float		contrast;

vec4 wfdepth(float d){
	vec4 clip_space = vec4(v_vTexcoord * 2. - 1., d * 2. - 1., 1.);
	vec4 view_space = v_vProjInv * clip_space;
	return view_space / view_space.w;
}
float random(vec2 co){
    return fract(sin(dot(co, vec2(12.9898, 78.233))) * 43758.5453);
}
void main()
{
	// Uniforms (hard-coded for now)
	float samp_num	= 16.;
	//float radius    = 1.;
	//float bias      = .4;
	//float magnitude = 1.;
	//float contrast  = 2.;
	
	// Make it happen cap'n
	vec4 pos = wfdepth(texture2D(gm_BaseTexture, v_vTexcoord).r);
	vec3 nrm = texture2D(normal, v_vTexcoord).xyz * 2. - 1.;
	vec3 noise = normalize(vec3(
		random(v_vTexcoord*2.), 
		random(v_vTexcoord/2.), 
		random(v_vTexcoord)
	));
	
	vec3 tang = normalize(noise - nrm * dot(noise, nrm));
	vec3 bino = cross(nrm, tang);
	mat3 tbn = mat3(tang, bino, nrm);
	
	float occlusion = .0;
	for ( int i = 0; i < SAMP_NUM; ++i ){
		vec3 sample_position = tbn * samples[i];
		sample_position = pos.xyz + sample_position * radius;
		
		vec4 offset_uv	= vec4(sample_position, 1.);
		offset_uv		= projmat * offset_uv;
		offset_uv.xyz  /= offset_uv.w;
		offset_uv.xy	= offset_uv.xy * .5 + .5;
		
		vec4 offset_position = wfdepth(texture2D(gm_BaseTexture, offset_uv.xy).r);
		float occluded = ( sample_position.z + bias <= offset_position.z ? 0. : 1. );
		occluded *= smoothstep(0., 1., radius / abs(pos.z - offset_position.z));
		occlusion += occluded;
	}
	occlusion /= samp_num;
	occlusion = pow(occlusion, magnitude);
	occlusion = contrast * ( occlusion - .5 ) * .5;
	gl_FragColor = vec4(vec3(1.-occlusion), 1.);
}
