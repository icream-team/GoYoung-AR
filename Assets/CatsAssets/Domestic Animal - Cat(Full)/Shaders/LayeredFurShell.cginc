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

	float FiberExt = tex2Dlod(_Fur_Params, float4(v.texcoord.x, v.texcoord.y, 0.0, 0.0)).b;
	v.vertex.xyz  += v.normal * _LayerIndex * _LayersSeparation * FiberExt;

	o.color = v.color;

	return;
}

void Surface(Input input, inout SurfaceOutputStandard output) 
{
	fixed2 uv0 = input.uv_Albedo;

	float  LayerUni   = saturate(_LayerIndex / _NumberOfLayers);

	half3  Normal     = UnpackNormal(tex2D(_Bump, uv0));
		   Normal.xy *= _Bump_Scale;
		   Normal.xy *= 1.0 + LayerUni * 0.25;
		   Normal     = normalize(Normal);
	
	half3  Albedo     = tex2D(_Albedo, uv0).xyz;
	half4  Params     = tex2D(_Fur_Params, uv0);
	half   Metallicity= saturate(Params.a * _Metallicity_Scale);
	half   Smoothness = saturate(Params.g * _Smoothness_Scale);
	half   FurMap     = saturate((Params.b-0.2) * 10.0f);
	half   LayerMask  = tex2D(_FibersMap, (LayerUni * 0.005) + (uv0 * _FibersMap_Scale)).x * FurMap;

		   Albedo    *= lerp(1.0, 0.9, saturate(FurMap-LayerUni));
		   Albedo	 *= Params.r;
		   Smoothness-= lerp(0.0, 0.1, saturate(FurMap-LayerUni));

	output.Alpha      = LayerMask;
	output.Albedo     = Albedo.xyz;
	output.Normal     = Normal;
	output.Metallic   = Metallicity;
	output.Smoothness = Smoothness;
	output.Occlusion  = lerp(Params.r * Params.r, saturate(0.5 + (Params.r * Params.r)), LayerUni);

	return;
}
