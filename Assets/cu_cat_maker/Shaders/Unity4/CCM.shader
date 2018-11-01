Shader "CuCatMaker/CuCatM shader" {
 Properties {
 _Color ("Main Color", Color) = (1,1,1,1)
 _Cutoff ("Alpha Cutoff", Float) = 0.5
 _MainTex ("Base (RGB) Trans (A)", 2D) = "white" {}
 _BlendPower1("Blend_Power1", Range(0, 1)) = 0
 _BlendTex1 ("Blend_01 (RGBA)", 2D) = "black" {}
 _BlendPower2("Blend_Power2", Range(0, 1)) = 0
 _BlendTex2 ("Blend_02 (RGBA)", 2D) = "black" {}
 _DecalTex1 ("Decal_01 (RGBA)", 2D) = "black" {}
 _DecalTex2 ("Decal_02 (RGBA)", 2D) = "black" {}
 _DecalTex3 ("Decal_03 (RGBA)", 2D) = "black" {}
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
 fixed _Cutoff;
 sampler2D _BlendTex1;
 sampler2D _BlendTex2;
 sampler2D _DecalTex1;
 sampler2D _DecalTex2;
 sampler2D _DecalTex3;
  
 struct Input {
 float2 uv_MainTex;
 float2 uv_BlendTex1;
 float2 uv_BlendTex2;
 float2 uv_DecalTex1;
 float2 uv_DecalTex2;
 float2 uv_DecalTex3;
 };
  
 void surf (Input IN, inout SurfaceOutput o) {
 fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
 half4 blend1 = tex2D(_BlendTex1, IN.uv_BlendTex1);
 half4 blend2 = tex2D(_BlendTex2, IN.uv_BlendTex2);
 half4 decal1 = tex2D(_DecalTex1, IN.uv_DecalTex1);
 half4 decal2 = tex2D(_DecalTex2, IN.uv_DecalTex2);
 half4 decal3 = tex2D(_DecalTex3, IN.uv_DecalTex3);
 c.rgb = lerp (c.rgb, blend1.rgb, blend1.a * _BlendPower1);
 c.rgb = lerp (c.rgb, blend2.rgb, blend2.a * _BlendPower2);
 c.rgb = lerp (c.rgb, decal1.rgb, decal1.a);
 c.rgb = lerp (c.rgb, decal2.rgb, decal2.a);
 c.rgb = lerp (c.rgb, decal3.rgb, decal3.a);
 c *= _Color;
 o.Albedo = c.rgb;
 o.Alpha = c.a + blend1.a + blend2.a + decal1.a + decal2.a + decal3.a;
 clip(o.Alpha - _Cutoff);
 }
 ENDCG
 }
 
 Fallback "Diffuse"
 }
