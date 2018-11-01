sampler2D _Albedo;
sampler2D _Bump;
sampler2D _Fur_Params;
sampler2D _FibersMap;
float     _Bump_Scale;
float     _Metallicity_Scale;
float     _Smoothness_Scale;
float     _FibersMap_Scale;
float     _LayersSeparation;

struct Input 
{
	fixed2 uv_Albedo;
	fixed4 color;
	float3 viewDir;
};

void Vertex( inout appdata_full v, out Input o ) 
{
	UNITY_INITIALIZE_OUTPUT( Input, o );
	o.color = v.color;
	return;
}

void Surface(Input input, inout SurfaceOutputStandard output) 
{
	fixed2 uv0 = input.uv_Albedo;

	half3  Normal     = UnpackNormal(tex2D(_Bump, uv0));
		   Normal.xy *= _Bump_Scale;
		   Normal     = normalize(Normal);

	half3  Albedo     = tex2D(_Albedo, uv0).xyz;
	half4  Params     = tex2D(_Fur_Params, uv0);

	half   Metallicity= saturate(Params.a * _Metallicity_Scale);
	half   Smoothness = saturate(Params.g * _Smoothness_Scale);
	half   FurMap     = Params.b;

		   Albedo    *= lerp(1.0, 0.9, FurMap);
		   Smoothness-= lerp(0.0, 0.1, FurMap);

	output.Alpha      = 1.0;
	output.Albedo     = Albedo.xyz;
	output.Normal     = Normal;
	output.Metallic   = Metallicity;
	output.Smoothness = Smoothness;
	output.Occlusion  = Params.r * Params.r;

	return;
}
