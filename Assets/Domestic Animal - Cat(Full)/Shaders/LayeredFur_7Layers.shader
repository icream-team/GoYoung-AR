Shader "4Toon/LayeredFur (7 layers)"
{
	Properties 
	{	
		//------------------------------------------------------------------
		// Params
		//------------------------------------------------------------------

		_Albedo( "Albedo", 2D ) = "white" {}

		[NoScaleOffset]
		_Bump("Normalmap", 2D ) = "bump" {}
		_Bump_Scale("Normalmap scale", Range(1.0, 10.0)) = 1.0

		[NoScaleOffset]
		_Fur_Params("Parameters map", 2D) = "white" {}

		_Metallicity_Scale("Metallicity scale", Range(0.0, 1.0)) = 1.0
		_Smoothness_Scale("Smoothness scale", Range(0.0, 1.0)) = 1.0

		[Header(Fur parameters)]
		[NoScaleOffset]
		_FibersMap("Fibers map", 2D) = "white" {}

		_FibersMap_Scale("Fibers size", Range(0.1, 10.0)) = 3.0
		_LayersSeparation("Layers separation", Range(0.0001, 0.1)) = 0.0025
		_AlphaCutOff("Fiber cutoff", Range(0.0, 1.0)) = 0.333
	}

	SubShader 
	{
		Tags { "RenderType" = "Opaque" "IgnoreProjector"="True" }
		ZWrite On ZTest LEqual

		// Base layer
		
		CGPROGRAM
		#define _NumberOfLayers 5.0
		#define _LayerIndex     0.0

		#pragma only_renderers d3d11 xboxone ps4 opengl
		#pragma surface Surface Standard vertex:Vertex exclude_path:prepass
		#pragma target 4.0
		
		#include "LayeredFurBase.cginc"
		ENDCG

		// Fur layers

		Cull Off

		// [FORWARD]
		// Layer 0
		
		CGPROGRAM
		#define _NumberOfLayers 7.0
		#define _LayerIndex     1.0

		#pragma only_renderers d3d11 xboxone ps4 opengl
		#pragma surface Surface Standard vertex:Vertex alphatest:_AlphaCutOff exclude_path:prepass exclude_path:deferred nometa
		#pragma target 4.0
		
		#include "LayeredFurShell.cginc"
		ENDCG	

		// Layer 1
		
		CGPROGRAM
		#define _NumberOfLayers 7.0
		#define _LayerIndex     2.0

		#pragma only_renderers d3d11 xboxone ps4 opengl
		#pragma surface Surface Standard vertex:Vertex alphatest:_AlphaCutOff exclude_path:prepass exclude_path:deferred nometa
		#pragma target 4.0
		
		#include "LayeredFurShell.cginc"
		ENDCG	

		// Layer 2
		
		CGPROGRAM
		#define _NumberOfLayers 7.0
		#define _LayerIndex     3.0

		#pragma only_renderers d3d11 xboxone ps4 opengl
		#pragma surface Surface Standard vertex:Vertex alphatest:_AlphaCutOff exclude_path:prepass exclude_path:deferred nometa
		#pragma target 4.0
		
		#include "LayeredFurShell.cginc"
		ENDCG	

		// Layer 3
		
		CGPROGRAM
		#define _NumberOfLayers 7.0
		#define _LayerIndex     4.0

		#pragma only_renderers d3d11 xboxone ps4 opengl
		#pragma surface Surface Standard vertex:Vertex alphatest:_AlphaCutOff exclude_path:prepass exclude_path:deferred nometa		
		#pragma target 4.0
		
		#include "LayeredFurShell.cginc"
		ENDCG	

		// Layer 4
		
		CGPROGRAM
		#define _NumberOfLayers 7.0
		#define _LayerIndex     5.0

		#pragma only_renderers d3d11 xboxone ps4 opengl
		#pragma surface Surface Standard vertex:Vertex alphatest:_AlphaCutOff exclude_path:prepass exclude_path:deferred nometa
		#pragma target 4.0

		#include "LayeredFurShell.cginc"
		ENDCG	

		// Layer 5
		
		CGPROGRAM
		#define _NumberOfLayers 7.0
		#define _LayerIndex     6.0

		#pragma only_renderers d3d11 xboxone ps4 opengl
		#pragma surface Surface Standard vertex:Vertex alphatest:_AlphaCutOff exclude_path:prepass exclude_path:deferred nometa
		#pragma target 4.0

		#include "LayeredFurShell.cginc"
		ENDCG	

		// Layer 6
		
		CGPROGRAM
		#define _NumberOfLayers 7.0
		#define _LayerIndex     7.0

		#pragma only_renderers d3d11 xboxone ps4 opengl
		#pragma surface Surface Standard vertex:Vertex alphatest:_AlphaCutOff exclude_path:prepass exclude_path:deferred nometa
		#pragma target 4.0
		
		#include "LayeredFurShell.cginc"
		ENDCG			

		// [DEFERRED]
		// Layer 0
		
		CGPROGRAM
		#define _NumberOfLayers 7.0
		#define _LayerIndex     1.0

		#pragma only_renderers d3d11 xboxone ps4 opengl
		#pragma surface Surface Standard vertex:Vertex alphatest:_AlphaCutOff exclude_path:prepass exclude_path:forward nometa noshadow
		#pragma target 4.0
		
		#include "LayeredFurShell.cginc"
		ENDCG	

		// Layer 1
		
		CGPROGRAM
		#define _NumberOfLayers 7.0
		#define _LayerIndex     2.0

		#pragma only_renderers d3d11 xboxone ps4 opengl
		#pragma surface Surface Standard vertex:Vertex alphatest:_AlphaCutOff exclude_path:prepass exclude_path:forward nometa noshadow
		#pragma target 4.0
		
		#include "LayeredFurShell.cginc"
		ENDCG	

		// Layer 2
		
		CGPROGRAM
		#define _NumberOfLayers 7.0
		#define _LayerIndex     3.0

		#pragma only_renderers d3d11 xboxone ps4 opengl
		#pragma surface Surface Standard vertex:Vertex alphatest:_AlphaCutOff exclude_path:prepass exclude_path:forward nometa noshadow
		#pragma target 4.0
		
		#include "LayeredFurShell.cginc"
		ENDCG	

		// Layer 3
		
		CGPROGRAM
		#define _NumberOfLayers 7.0
		#define _LayerIndex     4.0

		#pragma only_renderers d3d11 xboxone ps4 opengl
		#pragma surface Surface Standard vertex:Vertex alphatest:_AlphaCutOff exclude_path:prepass exclude_path:forward nometa noshadow		
		#pragma target 4.0
		
		#include "LayeredFurShell.cginc"
		ENDCG	

		// Layer 4
		
		CGPROGRAM
		#define _NumberOfLayers 7.0
		#define _LayerIndex     5.0

		#pragma only_renderers d3d11 xboxone ps4 opengl
		#pragma surface Surface Standard vertex:Vertex alphatest:_AlphaCutOff exclude_path:prepass exclude_path:forward nometa noshadow
		#pragma target 4.0

		#include "LayeredFurShell.cginc"
		ENDCG	

		// Layer 5
		
		CGPROGRAM
		#define _NumberOfLayers 7.0
		#define _LayerIndex     6.0

		#pragma only_renderers d3d11 xboxone ps4 opengl
		#pragma surface Surface Standard vertex:Vertex alphatest:_AlphaCutOff exclude_path:prepass exclude_path:forward nometa noshadow
		#pragma target 4.0

		#include "LayeredFurShell.cginc"
		ENDCG	

		// Layer 6
		
		CGPROGRAM
		#define _NumberOfLayers 7.0
		#define _LayerIndex     7.0

		#pragma only_renderers d3d11 xboxone ps4 opengl
		#pragma surface Surface Standard vertex:Vertex alphatest:_AlphaCutOff exclude_path:prepass exclude_path:forward nometa noshadow
		#pragma target 4.0
		
		#include "LayeredFurShell.cginc"
		ENDCG			
	}

	FallBack "Diffuse"
}
