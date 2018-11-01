Shader "CuCatMaker/5_CuCatM shader" {
 Properties {
 _Color ("Main Color", Color) = (1,1,1,1)
 _Cutoff ("Alpha Cutoff", Float) = 0.5
 _MainTex ("Base (RGB) Trans (A)", 2D) = "white" {}
 _BlendPower1("Blend_Power1", Range(0, 1)) = 0
 _BlendTex1 ("Blend_01 (RGBA)", 2D) = "black" {}
 _BlendPower2("Blend_Power2", Range(0, 1)) = 0
 _BlendTex2 ("Blend_02 (RGBA)", 2D) = "black" {}
 _BlendPower3("Blend_Power3", Range(0, 1)) = 0
 _BlendTex3 ("Blend_03 (RGBA)", 2D) = "black" {}
 }
  
 SubShader {
 Tags { "RenderType"="Transparent" "IgnoreProjector"="True" "Queue"="Transparent" }
 LOD 250
 Cull back
  
 CGPROGRAM
 #pragma surface surf Lambert
 sampler2D _MainTex;
 fixed4 _Color;
 float _BlendPower1;
 float _BlendPower2;
 float _BlendPower3;
 fixed _Cutoff;
 sampler2D _BlendTex1;
 sampler2D _BlendTex2;
 sampler2D _BlendTex3;
  
 struct Input {
 float2 uv_MainTex;
 float2 uv_BlendTex1;
 float2 uv_BlendTex2;
 float2 uv_BlendTex3;
 };
  
 void surf (Input IN, inout SurfaceOutput o) {
 fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
 half4 blend1 = tex2D(_BlendTex1, IN.uv_BlendTex1);
 half4 blend2 = tex2D(_BlendTex2, IN.uv_BlendTex2);
 half4 blend3 = tex2D(_BlendTex3, IN.uv_BlendTex3);
 c.rgb = lerp (c.rgb, blend1.rgb, blend1.a * _BlendPower1);
 c.rgb = lerp (c.rgb, blend2.rgb, blend2.a * _BlendPower2);
 c.rgb = lerp (c.rgb, blend3.rgb, blend3.a * _BlendPower3);
 c *= _Color;
 o.Albedo = c.rgb;
 o.Alpha = c.a + blend1.a + blend2.a + blend3.a;
 clip(o.Alpha - _Cutoff);
 }
 ENDCG
 }
 
 Fallback "Diffuse"
 }
