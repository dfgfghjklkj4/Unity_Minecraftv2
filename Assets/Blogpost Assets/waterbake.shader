Shader "underwater"
{
    Properties
    {
        Vector1_f108b0f6f7ad4a0fa7970936cde8c93a("Depth", Float) = 0
        Vector1_77a8669616464cc68eec17e9163052aa("Depth Strength", Range(0, 2)) = 0
        Color_b5081859698940efa07a6cc68ff92e70("Shallow Water Color", Color) = (0.02352941, 0.509804, 0.427451, 1)
        _Shallow_Water_Color_2("Shallow Water Color 2", Color) = (0, 0.5157235, 0.7735849, 0.6901961)
        Color_2bad1140d6ae465a8b096ead483f5370("Deep Water Color", Color) = (0, 0.413565, 0.4339623, 0)
        Color_1("Deep Water Color 2", Color) = (0, 0.2356971, 0.4352941, 0)
        Vector1_0360d732cbbf426e841ca433b0e337aa("Normal Strength", Float) = 0
        [NoScaleOffset]Texture2D_2d2e087224e24282b84a086f3316e6e8("Main Normal", 2D) = "white" {}
        Vector2_c2fe4e7c2a7649b28d7ab078fdadda1c("Main Normal Tiling", Vector) = (0.5, 0.5, 0, 0)
        Vector1_7614a6098dec470e8a4e96a5c8551362("Main Wave Speed", Float) = 22
        [NoScaleOffset]Texture2D_21a78e051aa84ab49c73d2364e78102f("Second Normal", 2D) = "white" {}
        Vector2_73fa27b3bcf64608a50eed7c1d0d3411("Second Normal Tiling", Vector) = (0.5, 0.5, 0, 0)
        Vector1_898460d8305d4dfe9af1298eb6f67082("Second Wave Speed", Float) = 5
        Color_6e3aa9f38d68448bb94d493ef4e3c30a("Foam Color", Color) = (1, 0.9494789, 0.664151, 0)
        Vector1_0d98869735ab4e73a0e4bb36589d00c0("Foam Strength", Float) = 0.5
        Vector1_aace7401fb3a402e9f06de96963c9b84("Foam Distance", Float) = 0.3
        [NoScaleOffset]Texture2D_d65eb6e07c30447ca446c38272609586("Foam Texture", 2D) = "white" {}
        Vector2_2832e3b0590c4ee98f806b14c0f54c5b("Foam Texture Tilling", Vector) = (0.94, 5, 0, 0)
        _Panning("Panning", Vector) = (0.04, 0, 0, 0)
        _DistortionScale("DistortionScale", Float) = 4
        _DistortionSpeed("DistortionSpeed", Float) = 0
        _DistortionIntensity("DistortionIntensity", Range(0, 1)) = 0.2
        _FoamNoiseTilling("FoamNoiseTilling", Vector) = (5, 5, 0, 0)
        _NoiseScale("NoiseScale", Float) = -7.38
        _Layer1_Scale("Layer1 Scale", Range(0, 1)) = 0.47
        _Layer2_Scale("Layer2 Scale", Range(0, 1)) = 0.44
        Vector1_dcce861f82224ec1ac55aa94df3b3d12("Displacement", Float) = 0
        Vector1_3606b8114ded4a74a4e4834f8bf7dc12("Tide Frequency", Range(1, 10)) = 1
        Vector1_69bcaf9cf50f40a2bef27afe006bbc8f("Smoothness", Range(0, 1)) = 0.8
        [NoScaleOffset]_PlanarReflectionTexture("PlanarReflectionTexture", 2D) = "black" {}
        _RefractionDistrotion("RefractionDistrotion", Range(-1, 1)) = 0
        _Relection_Strength("Relection Strength", Range(0, 1)) = 0.65
        [HideInInspector]_QueueOffset("_QueueOffset", Float) = 0
        [HideInInspector]_QueueControl("_QueueControl", Float) = -1
        [HideInInspector][NoScaleOffset]unity_Lightmaps("unity_Lightmaps", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset]unity_LightmapsInd("unity_LightmapsInd", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset]unity_ShadowMasks("unity_ShadowMasks", 2DArray) = "" {}
    }
    SubShader
    {
        Tags
        {
            "RenderPipeline"="UniversalPipeline"
            "RenderType"="Transparent"
            "UniversalMaterialType" = "Lit"
            "Queue"="Transparent"
            "ShaderGraphShader"="true"
            "ShaderGraphTargetId"="UniversalLitSubTarget"
        }
        Pass
        {
            Name "Universal Forward"
            Tags
            {
                "LightMode" = "UniversalForward"
            }
        
        // Render State
        Cull Front
        Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
        ZTest LEqual
        ZWrite Off
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 4.5
        #pragma exclude_renderers gles gles3 glcore
        #pragma multi_compile_instancing
        #pragma multi_compile_fog
        #pragma instancing_options renderinglayer
        #pragma multi_compile _ DOTS_INSTANCING_ON
        #pragma vertex vert
        #pragma fragment frag
        
        // DotsInstancingOptions: <None>
        // HybridV1InjectedBuiltinProperties: <None>
        
        // Keywords
        #pragma multi_compile _ _SCREEN_SPACE_OCCLUSION
        #pragma multi_compile _ LIGHTMAP_ON
        #pragma multi_compile _ DYNAMICLIGHTMAP_ON
        #pragma multi_compile _ DIRLIGHTMAP_COMBINED
        #pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN
        #pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
        #pragma multi_compile _ _ADDITIONAL_LIGHT_SHADOWS
        #pragma multi_compile _ _REFLECTION_PROBE_BLENDING
        #pragma multi_compile _ _REFLECTION_PROBE_BOX_PROJECTION
        #pragma multi_compile _ _SHADOWS_SOFT
        #pragma multi_compile _ LIGHTMAP_SHADOW_MIXING
        #pragma multi_compile _ SHADOWS_SHADOWMASK
        #pragma multi_compile _ _DBUFFER_MRT1 _DBUFFER_MRT2 _DBUFFER_MRT3
        #pragma multi_compile _ _LIGHT_LAYERS
        #pragma multi_compile _ DEBUG_DISPLAY
        #pragma multi_compile _ _LIGHT_COOKIES
        #pragma multi_compile _ _CLUSTERED_RENDERING
        // GraphKeywords: <None>
        
        // Defines
        
        #define _NORMALMAP 1
        #define _NORMAL_DROPOFF_TS 1
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define ATTRIBUTES_NEED_TEXCOORD1
        #define ATTRIBUTES_NEED_TEXCOORD2
        #define VARYINGS_NEED_POSITION_WS
        #define VARYINGS_NEED_NORMAL_WS
        #define VARYINGS_NEED_TANGENT_WS
        #define VARYINGS_NEED_TEXCOORD0
        #define VARYINGS_NEED_VIEWDIRECTION_WS
        #define VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
        #define VARYINGS_NEED_SHADOW_COORD
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_FORWARD
        #define _FOG_FRAGMENT 1
        #define _SURFACE_TYPE_TRANSPARENT 1
        #define _ALPHATEST_ON 1
        #define REQUIRE_DEPTH_TEXTURE
        #define REQUIRE_OPAQUE_TEXTURE
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DBuffer.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
             float4 uv1 : TEXCOORD1;
             float4 uv2 : TEXCOORD2;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float3 positionWS;
             float3 normalWS;
             float4 tangentWS;
             float4 texCoord0;
             float3 viewDirectionWS;
            #if defined(LIGHTMAP_ON)
             float2 staticLightmapUV;
            #endif
            #if defined(DYNAMICLIGHTMAP_ON)
             float2 dynamicLightmapUV;
            #endif
            #if !defined(LIGHTMAP_ON)
             float3 sh;
            #endif
             float4 fogFactorAndVertexLight;
            #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
             float4 shadowCoord;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
             float2 MainNormal;
             float2 SecondNormal;
             float2 FoamDirection1;
             float2 FoamDirection2;
        };
        struct SurfaceDescriptionInputs
        {
             float3 TangentSpaceNormal;
             float3 WorldSpacePosition;
             float4 ScreenPosition;
             float4 uv0;
             float2 MainNormal;
             float2 SecondNormal;
             float2 FoamDirection1;
             float2 FoamDirection2;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
             float3 AbsoluteWorldSpacePosition;
             float4 uv0;
             float3 TimeParameters;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float3 interp0 : INTERP0;
             float3 interp1 : INTERP1;
             float4 interp2 : INTERP2;
             float4 interp3 : INTERP3;
             float3 interp4 : INTERP4;
             float4 interp5 : INTERP5;
             float4 interp6 : INTERP6;
             float3 interp7 : INTERP7;
             float4 interp8 : INTERP8;
             float4 interp9 : INTERP9;
             float4 interp10 : INTERP10;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.positionWS;
            output.interp1.xyz =  input.normalWS;
            output.interp2.xyzw =  input.tangentWS;
            output.interp3.xyzw =  input.texCoord0;
            output.interp4.xyz =  input.viewDirectionWS;
            #if defined(LIGHTMAP_ON)
            output.interp5.xy =  input.staticLightmapUV;
            #endif
            #if defined(DYNAMICLIGHTMAP_ON)
            output.interp6.xy =  input.dynamicLightmapUV;
            #endif
            #if !defined(LIGHTMAP_ON)
            output.interp7.xyz =  input.sh;
            #endif
            output.interp8.xyzw =  input.fogFactorAndVertexLight;
            #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
            output.interp9.xyzw =  input.shadowCoord;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            output.interp5.zw =  input.MainNormal;
            output.interp6.zw =  input.SecondNormal;
            output.interp10.xy =  input.FoamDirection1;
            output.interp10.zw =  input.FoamDirection2;
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.positionWS = input.interp0.xyz;
            output.normalWS = input.interp1.xyz;
            output.tangentWS = input.interp2.xyzw;
            output.texCoord0 = input.interp3.xyzw;
            output.viewDirectionWS = input.interp4.xyz;
            #if defined(LIGHTMAP_ON)
            output.staticLightmapUV = input.interp5.xy;
            #endif
            #if defined(DYNAMICLIGHTMAP_ON)
            output.dynamicLightmapUV = input.interp6.xy;
            #endif
            #if !defined(LIGHTMAP_ON)
            output.sh = input.interp7.xyz;
            #endif
            output.fogFactorAndVertexLight = input.interp8.xyzw;
            #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
            output.shadowCoord = input.interp9.xyzw;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            output.MainNormal = input.interp5.zw;
            output.SecondNormal = input.interp6.zw;
            output.FoamDirection1 = input.interp10.xy;
            output.FoamDirection2 = input.interp10.zw;
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float4 _PlanarReflectionTexture_TexelSize;
        float Vector1_f108b0f6f7ad4a0fa7970936cde8c93a;
        float Vector1_77a8669616464cc68eec17e9163052aa;
        float4 Color_2bad1140d6ae465a8b096ead483f5370;
        float4 Color_b5081859698940efa07a6cc68ff92e70;
        float4 Color_1;
        float4 Texture2D_2d2e087224e24282b84a086f3316e6e8_TexelSize;
        float2 Vector2_c2fe4e7c2a7649b28d7ab078fdadda1c;
        float Vector1_7614a6098dec470e8a4e96a5c8551362;
        float4 Texture2D_21a78e051aa84ab49c73d2364e78102f_TexelSize;
        float2 Vector2_73fa27b3bcf64608a50eed7c1d0d3411;
        float Vector1_898460d8305d4dfe9af1298eb6f67082;
        float Vector1_0360d732cbbf426e841ca433b0e337aa;
        float Vector1_dcce861f82224ec1ac55aa94df3b3d12;
        float Vector1_3606b8114ded4a74a4e4834f8bf7dc12;
        float Vector1_69bcaf9cf50f40a2bef27afe006bbc8f;
        float4 Color_6e3aa9f38d68448bb94d493ef4e3c30a;
        float Vector1_0d98869735ab4e73a0e4bb36589d00c0;
        float Vector1_aace7401fb3a402e9f06de96963c9b84;
        float4 Texture2D_d65eb6e07c30447ca446c38272609586_TexelSize;
        float2 Vector2_2832e3b0590c4ee98f806b14c0f54c5b;
        float4 _Shallow_Water_Color_2;
        float2 _Panning;
        float _DistortionSpeed;
        float _DistortionIntensity;
        float2 _FoamNoiseTilling;
        float _DistortionScale;
        float _NoiseScale;
        float _Layer1_Scale;
        float _Layer2_Scale;
        float _RefractionDistrotion;
        float _Relection_Strength;
        CBUFFER_END
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_PlanarReflectionTexture);
        SAMPLER(sampler_PlanarReflectionTexture);
        TEXTURE2D(Texture2D_2d2e087224e24282b84a086f3316e6e8);
        SAMPLER(samplerTexture2D_2d2e087224e24282b84a086f3316e6e8);
        TEXTURE2D(Texture2D_21a78e051aa84ab49c73d2364e78102f);
        SAMPLER(samplerTexture2D_21a78e051aa84ab49c73d2364e78102f);
        TEXTURE2D(Texture2D_d65eb6e07c30447ca446c38272609586);
        SAMPLER(samplerTexture2D_d65eb6e07c30447ca446c38272609586);
        
        // Graph Includes
        // GraphIncludes: <None>
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        
        inline float Unity_SimpleNoise_RandomValue_float (float2 uv)
        {
            float angle = dot(uv, float2(12.9898, 78.233));
            #if defined(SHADER_API_MOBILE) && (defined(SHADER_API_GLES) || defined(SHADER_API_GLES3) || defined(SHADER_API_VULKAN))
                // 'sin()' has bad precision on Mali GPUs for inputs > 10000
                angle = fmod(angle, TWO_PI); // Avoid large inputs to sin()
            #endif
            return frac(sin(angle)*43758.5453);
        }
        
        inline float Unity_SimpleNnoise_Interpolate_float (float a, float b, float t)
        {
            return (1.0-t)*a + (t*b);
        }
        
        
        inline float Unity_SimpleNoise_ValueNoise_float (float2 uv)
        {
            float2 i = floor(uv);
            float2 f = frac(uv);
            f = f * f * (3.0 - 2.0 * f);
        
            uv = abs(frac(uv) - 0.5);
            float2 c0 = i + float2(0.0, 0.0);
            float2 c1 = i + float2(1.0, 0.0);
            float2 c2 = i + float2(0.0, 1.0);
            float2 c3 = i + float2(1.0, 1.0);
            float r0 = Unity_SimpleNoise_RandomValue_float(c0);
            float r1 = Unity_SimpleNoise_RandomValue_float(c1);
            float r2 = Unity_SimpleNoise_RandomValue_float(c2);
            float r3 = Unity_SimpleNoise_RandomValue_float(c3);
        
            float bottomOfGrid = Unity_SimpleNnoise_Interpolate_float(r0, r1, f.x);
            float topOfGrid = Unity_SimpleNnoise_Interpolate_float(r2, r3, f.x);
            float t = Unity_SimpleNnoise_Interpolate_float(bottomOfGrid, topOfGrid, f.y);
            return t;
        }
        void Unity_SimpleNoise_float(float2 UV, float Scale, out float Out)
        {
            float t = 0.0;
        
            float freq = pow(2.0, float(0));
            float amp = pow(0.5, float(3-0));
            t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale/freq, UV.y*Scale/freq))*amp;
        
            freq = pow(2.0, float(1));
            amp = pow(0.5, float(3-1));
            t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale/freq, UV.y*Scale/freq))*amp;
        
            freq = pow(2.0, float(2));
            amp = pow(0.5, float(3-2));
            t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale/freq, UV.y*Scale/freq))*amp;
        
            Out = t;
        }
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }
        
        void Unity_Multiply_float2_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A * B;
        }
        
        void Unity_Lerp_float2(float2 A, float2 B, float2 T, out float2 Out)
        {
            Out = lerp(A, B, T);
        }
        
        
        float2 Unity_GradientNoise_Dir_float(float2 p)
        {
            // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
            p = p % 289;
            // need full precision, otherwise half overflows when p > 1
            float x = float(34 * p.x + 1) * p.x % 289 + p.y;
            x = (34 * x + 1) * x % 289;
            x = frac(x / 41) * 2 - 1;
            return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
        }
        
        void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
        {
            float2 p = UV * Scale;
            float2 ip = floor(p);
            float2 fp = frac(p);
            float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
            float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
            float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
            float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
            fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
            Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Preview_float(float In, out float Out)
        {
            Out = In;
        }
        
        void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
        {
            Out = lerp(A, B, T);
        }
        
        void Unity_SceneDepth_Linear01_float(float4 UV, out float Out)
        {
            Out = Linear01Depth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }
        
        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }
        
        void Unity_Add_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A + B;
        }
        
        void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
        {
            Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
        }
        
        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }
        
        void Unity_SceneColor_float(float4 UV, out float3 Out)
        {
            Out = SHADERGRAPH_SAMPLE_SCENE_COLOR(UV.xy);
        }
        
        void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
        {
            Out = lerp(A, B, T);
        }
        
        void Unity_Blend_Multiply_float3(float3 Base, float3 Blend, out float3 Out, float Opacity)
        {
            Out = Base * Blend;
            Out = lerp(Base, Out, Opacity);
        }
        
        void Unity_ColorMask_float(float3 In, float3 MaskColor, float Range, out float Out, float Fuzziness)
        {
            float Distance = distance(MaskColor, In);
            Out = saturate(1 - (Distance - Range) / max(Fuzziness, 1e-5));
        }
        
        void Unity_Multiply_float4_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }
        
        void Unity_Clamp_float4(float4 In, float4 Min, float4 Max, out float4 Out)
        {
            Out = clamp(In, Min, Max);
        }
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
            float2 MainNormal;
            float2 SecondNormal;
            float2 FoamDirection1;
            float2 FoamDirection2;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            float _Property_271cd524054a48d0ac03da3ed0e18981_Out_0 = _NoiseScale;
            float _Property_d6b17372f8e24d1ba887e19ca0b9b532_Out_0 = _DistortionSpeed;
            float _Multiply_6b5e1abaf00147a8a2bd61cb3a63ac2d_Out_2;
            Unity_Multiply_float_float(0.9, _Property_d6b17372f8e24d1ba887e19ca0b9b532_Out_0, _Multiply_6b5e1abaf00147a8a2bd61cb3a63ac2d_Out_2);
            float _Multiply_0b2927096f2b406eade60b0ff8497f06_Out_2;
            Unity_Multiply_float_float(_Multiply_6b5e1abaf00147a8a2bd61cb3a63ac2d_Out_2, IN.TimeParameters.x, _Multiply_0b2927096f2b406eade60b0ff8497f06_Out_2);
            float2 _TilingAndOffset_3ae4fb84d8a24ae6b255b068ec01f495_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, float2 (1, 1), (_Multiply_0b2927096f2b406eade60b0ff8497f06_Out_2.xx), _TilingAndOffset_3ae4fb84d8a24ae6b255b068ec01f495_Out_3);
            float _SimpleNoise_310007c52b3547759f3d9a40829d9fdb_Out_2;
            Unity_SimpleNoise_float(_TilingAndOffset_3ae4fb84d8a24ae6b255b068ec01f495_Out_3, _Property_271cd524054a48d0ac03da3ed0e18981_Out_0, _SimpleNoise_310007c52b3547759f3d9a40829d9fdb_Out_2);
            float2 _Property_caf806c45b8648239ed928655b2dc075_Out_0 = _FoamNoiseTilling;
            float _Property_83fd66d76a934370a36fc75a684ef06a_Out_0 = _DistortionIntensity;
            float _Property_31ef0e62fff04fde85a1f9ac39636e5c_Out_0 = _NoiseScale;
            float _Property_1df622d21af24ccca4f9f326808f58fc_Out_0 = _DistortionSpeed;
            float _Multiply_8c038a6c11994a53b09ad756f38d3c5d_Out_2;
            Unity_Multiply_float_float(-0.9, _Property_1df622d21af24ccca4f9f326808f58fc_Out_0, _Multiply_8c038a6c11994a53b09ad756f38d3c5d_Out_2);
            float _Multiply_c710fb8d99aa474cb13c0d65aa2a1829_Out_2;
            Unity_Multiply_float_float(_Multiply_8c038a6c11994a53b09ad756f38d3c5d_Out_2, IN.TimeParameters.x, _Multiply_c710fb8d99aa474cb13c0d65aa2a1829_Out_2);
            float2 _TilingAndOffset_b5b7efd61dd0407b81b2ec53772b278d_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, float2 (1, 1), (_Multiply_c710fb8d99aa474cb13c0d65aa2a1829_Out_2.xx), _TilingAndOffset_b5b7efd61dd0407b81b2ec53772b278d_Out_3);
            float _SimpleNoise_4e904d56e17345ff8f80d57968580a32_Out_2;
            Unity_SimpleNoise_float(_TilingAndOffset_b5b7efd61dd0407b81b2ec53772b278d_Out_3, _Property_31ef0e62fff04fde85a1f9ac39636e5c_Out_0, _SimpleNoise_4e904d56e17345ff8f80d57968580a32_Out_2);
            float _Divide_2d74bf9a40ba416f9b680ba114404dc2_Out_2;
            Unity_Divide_float(IN.TimeParameters.x, 6, _Divide_2d74bf9a40ba416f9b680ba114404dc2_Out_2);
            float2 _Property_702ff1c785d542499e4ead1def7e1418_Out_0 = _Panning;
            float _Split_252c3e0a27db4d66a7df034157244e21_R_1 = _Property_702ff1c785d542499e4ead1def7e1418_Out_0[0];
            float _Split_252c3e0a27db4d66a7df034157244e21_G_2 = _Property_702ff1c785d542499e4ead1def7e1418_Out_0[1];
            float _Split_252c3e0a27db4d66a7df034157244e21_B_3 = 0;
            float _Split_252c3e0a27db4d66a7df034157244e21_A_4 = 0;
            float _Multiply_e016b9a16b4e4abba2502adb5862e043_Out_2;
            Unity_Multiply_float_float(_Split_252c3e0a27db4d66a7df034157244e21_G_2, _Divide_2d74bf9a40ba416f9b680ba114404dc2_Out_2, _Multiply_e016b9a16b4e4abba2502adb5862e043_Out_2);
            float _Multiply_218b27dc95a243998b30f016e0d3988e_Out_2;
            Unity_Multiply_float_float(_Split_252c3e0a27db4d66a7df034157244e21_R_1, _Divide_2d74bf9a40ba416f9b680ba114404dc2_Out_2, _Multiply_218b27dc95a243998b30f016e0d3988e_Out_2);
            float4 _Combine_6ae549d623c54cce9850c0bc9b3405eb_RGBA_4;
            float3 _Combine_6ae549d623c54cce9850c0bc9b3405eb_RGB_5;
            float2 _Combine_6ae549d623c54cce9850c0bc9b3405eb_RG_6;
            Unity_Combine_float(_Multiply_218b27dc95a243998b30f016e0d3988e_Out_2, _Multiply_e016b9a16b4e4abba2502adb5862e043_Out_2, 0, 0, _Combine_6ae549d623c54cce9850c0bc9b3405eb_RGBA_4, _Combine_6ae549d623c54cce9850c0bc9b3405eb_RGB_5, _Combine_6ae549d623c54cce9850c0bc9b3405eb_RG_6);
            float _Float_f89ffb73213141f1aa48acbe034e5ea3_Out_0 = 0.02;
            float2 _Swizzle_d519ed834a284e518d347105c3a11492_Out_1 = IN.AbsoluteWorldSpacePosition.xz;
            float2 _Multiply_39c33974737143ae9f76cce56d3d33d2_Out_2;
            Unity_Multiply_float2_float2(_Swizzle_d519ed834a284e518d347105c3a11492_Out_1, (_Float_f89ffb73213141f1aa48acbe034e5ea3_Out_0.xx), _Multiply_39c33974737143ae9f76cce56d3d33d2_Out_2);
            float2 _TilingAndOffset_9f5c71641fa94a59a413d51e3a6aec3d_Out_3;
            Unity_TilingAndOffset_float(_Multiply_39c33974737143ae9f76cce56d3d33d2_Out_2, float2 (1, 1), _Combine_6ae549d623c54cce9850c0bc9b3405eb_RG_6, _TilingAndOffset_9f5c71641fa94a59a413d51e3a6aec3d_Out_3);
            float2 _Lerp_6ba3378c16cf44e49e4a44f6e2f26c65_Out_3;
            Unity_Lerp_float2(_TilingAndOffset_9f5c71641fa94a59a413d51e3a6aec3d_Out_3, (_SimpleNoise_310007c52b3547759f3d9a40829d9fdb_Out_2.xx), (_Property_83fd66d76a934370a36fc75a684ef06a_Out_0.xx), _Lerp_6ba3378c16cf44e49e4a44f6e2f26c65_Out_3);
            float2 _TilingAndOffset_c89d2fcde70d4d818249ebe200337480_Out_3;
            Unity_TilingAndOffset_float(_Lerp_6ba3378c16cf44e49e4a44f6e2f26c65_Out_3, _Property_caf806c45b8648239ed928655b2dc075_Out_0, float2 (0.81, 0), _TilingAndOffset_c89d2fcde70d4d818249ebe200337480_Out_3);
            float2 _Lerp_3759f9668f544adb8dd7eee5886abeb0_Out_3;
            Unity_Lerp_float2(_TilingAndOffset_9f5c71641fa94a59a413d51e3a6aec3d_Out_3, (_SimpleNoise_4e904d56e17345ff8f80d57968580a32_Out_2.xx), (_Property_83fd66d76a934370a36fc75a684ef06a_Out_0.xx), _Lerp_3759f9668f544adb8dd7eee5886abeb0_Out_3);
            float2 _TilingAndOffset_e2926df184da41caab0fcf14e34b81a7_Out_3;
            Unity_TilingAndOffset_float(_Lerp_3759f9668f544adb8dd7eee5886abeb0_Out_3, _Property_caf806c45b8648239ed928655b2dc075_Out_0, float2 (0.81, 0), _TilingAndOffset_e2926df184da41caab0fcf14e34b81a7_Out_3);
            float _Property_8a79f817e59948938215b338bcdc46df_Out_0 = Vector1_898460d8305d4dfe9af1298eb6f67082;
            float _Multiply_ed606ef7153b456b854854134a8f65f9_Out_2;
            Unity_Multiply_float_float(_Property_8a79f817e59948938215b338bcdc46df_Out_0, 0.01, _Multiply_ed606ef7153b456b854854134a8f65f9_Out_2);
            float2 _Property_0264c1738ed14b318538f5f39eb56d07_Out_0 = Vector2_73fa27b3bcf64608a50eed7c1d0d3411;
            float _Divide_d29c49a16f234ef78eee8f12e556a643_Out_2;
            Unity_Divide_float(IN.TimeParameters.x, 5, _Divide_d29c49a16f234ef78eee8f12e556a643_Out_2);
            float _Multiply_5928ff83990b4a61bfdfa392f6154eda_Out_2;
            Unity_Multiply_float_float(_Divide_d29c49a16f234ef78eee8f12e556a643_Out_2, _Multiply_ed606ef7153b456b854854134a8f65f9_Out_2, _Multiply_5928ff83990b4a61bfdfa392f6154eda_Out_2);
            float2 _TilingAndOffset_08fa9dddbfc44f8b9e671e082ef10419_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Property_0264c1738ed14b318538f5f39eb56d07_Out_0, (_Multiply_5928ff83990b4a61bfdfa392f6154eda_Out_2.xx), _TilingAndOffset_08fa9dddbfc44f8b9e671e082ef10419_Out_3);
            float _Property_32d848f89d264e118a7bc7b7cbae9677_Out_0 = Vector1_7614a6098dec470e8a4e96a5c8551362;
            float _Multiply_1541a6ad358e4ea281033d8831f2ba13_Out_2;
            Unity_Multiply_float_float(_Property_32d848f89d264e118a7bc7b7cbae9677_Out_0, -0.01, _Multiply_1541a6ad358e4ea281033d8831f2ba13_Out_2);
            float _Multiply_edd1ffe542204260a884842fd7a18fc1_Out_2;
            Unity_Multiply_float_float(_Multiply_1541a6ad358e4ea281033d8831f2ba13_Out_2, _Divide_d29c49a16f234ef78eee8f12e556a643_Out_2, _Multiply_edd1ffe542204260a884842fd7a18fc1_Out_2);
            float2 _Property_123c8148386d41aa9d1698d86033f0b5_Out_0 = Vector2_c2fe4e7c2a7649b28d7ab078fdadda1c;
            float2 _TilingAndOffset_924ee153284a4d4abbd47514c96bb1ae_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Property_123c8148386d41aa9d1698d86033f0b5_Out_0, (_Multiply_edd1ffe542204260a884842fd7a18fc1_Out_2.xx), _TilingAndOffset_924ee153284a4d4abbd47514c96bb1ae_Out_3);
            float _Split_d8eed8fe26594972914c124586d98bbf_R_1 = IN.ObjectSpacePosition[0];
            float _Split_d8eed8fe26594972914c124586d98bbf_G_2 = IN.ObjectSpacePosition[1];
            float _Split_d8eed8fe26594972914c124586d98bbf_B_3 = IN.ObjectSpacePosition[2];
            float _Split_d8eed8fe26594972914c124586d98bbf_A_4 = 0;
            float _Property_762630e6999b4da0a14b2ccffa4209d8_Out_0 = Vector1_dcce861f82224ec1ac55aa94df3b3d12;
            float _Divide_df746930d1d841c09a66286a0a3543ae_Out_2;
            Unity_Divide_float(_Property_762630e6999b4da0a14b2ccffa4209d8_Out_0, 200, _Divide_df746930d1d841c09a66286a0a3543ae_Out_2);
            float _Property_d73cd49e4412457080da3ad6f38ac94b_Out_0 = Vector1_3606b8114ded4a74a4e4834f8bf7dc12;
            float _Divide_b14ec7aec4874b8ab4371962384288e5_Out_2;
            Unity_Divide_float(_Property_d73cd49e4412457080da3ad6f38ac94b_Out_0, 50, _Divide_b14ec7aec4874b8ab4371962384288e5_Out_2);
            float _Multiply_f97f597155bf4b59afa13426042ec0a0_Out_2;
            Unity_Multiply_float_float(IN.TimeParameters.x, _Divide_b14ec7aec4874b8ab4371962384288e5_Out_2, _Multiply_f97f597155bf4b59afa13426042ec0a0_Out_2);
            float2 _TilingAndOffset_ab2fed3c342049de89287a73af5f4dd1_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, (_Multiply_f97f597155bf4b59afa13426042ec0a0_Out_2.xx), float2 (0, 0), _TilingAndOffset_ab2fed3c342049de89287a73af5f4dd1_Out_3);
            float _GradientNoise_c349a7da229a42f6acfd0e9329f501a7_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_ab2fed3c342049de89287a73af5f4dd1_Out_3, 0.96, _GradientNoise_c349a7da229a42f6acfd0e9329f501a7_Out_2);
            float _Multiply_9460f57a023144a9ae646cb7ff3c8354_Out_2;
            Unity_Multiply_float_float(_Divide_df746930d1d841c09a66286a0a3543ae_Out_2, _GradientNoise_c349a7da229a42f6acfd0e9329f501a7_Out_2, _Multiply_9460f57a023144a9ae646cb7ff3c8354_Out_2);
            float _Add_5cf9a595f1104a0ba7d0c02acbf47625_Out_2;
            Unity_Add_float(_Split_d8eed8fe26594972914c124586d98bbf_G_2, _Multiply_9460f57a023144a9ae646cb7ff3c8354_Out_2, _Add_5cf9a595f1104a0ba7d0c02acbf47625_Out_2);
            float4 _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGBA_4;
            float3 _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGB_5;
            float2 _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RG_6;
            Unity_Combine_float(_Split_d8eed8fe26594972914c124586d98bbf_R_1, _Add_5cf9a595f1104a0ba7d0c02acbf47625_Out_2, _Split_d8eed8fe26594972914c124586d98bbf_B_3, 0, _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGBA_4, _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGB_5, _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RG_6);
            description.Position = _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGB_5;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            description.MainNormal = _TilingAndOffset_924ee153284a4d4abbd47514c96bb1ae_Out_3;
            description.SecondNormal = _TilingAndOffset_08fa9dddbfc44f8b9e671e082ef10419_Out_3;
            description.FoamDirection1 = _TilingAndOffset_e2926df184da41caab0fcf14e34b81a7_Out_3;
            description.FoamDirection2 = _TilingAndOffset_c89d2fcde70d4d818249ebe200337480_Out_3;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        output.MainNormal = input.MainNormal;
        output.SecondNormal = input.SecondNormal;
        output.FoamDirection1 = input.FoamDirection1;
        output.FoamDirection2 = input.FoamDirection2;
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float3 BaseColor;
            float3 NormalTS;
            float3 Emission;
            float Metallic;
            float Smoothness;
            float Occlusion;
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float4 _Property_53dfc4b4cafc4a9496bd9fde6989ee8f_Out_0 = Color_b5081859698940efa07a6cc68ff92e70;
            float4 _Property_601193b6811a41eeb79befed4e93080a_Out_0 = _Shallow_Water_Color_2;
            float4 _UV_0459ed23840544d4943e249e6bf3def0_Out_0 = IN.uv0;
            float _Split_95c75a1ea7ee4dd7906396bff762bd25_R_1 = _UV_0459ed23840544d4943e249e6bf3def0_Out_0[0];
            float _Split_95c75a1ea7ee4dd7906396bff762bd25_G_2 = _UV_0459ed23840544d4943e249e6bf3def0_Out_0[1];
            float _Split_95c75a1ea7ee4dd7906396bff762bd25_B_3 = _UV_0459ed23840544d4943e249e6bf3def0_Out_0[2];
            float _Split_95c75a1ea7ee4dd7906396bff762bd25_A_4 = _UV_0459ed23840544d4943e249e6bf3def0_Out_0[3];
            float _Preview_0af5c98f89c44402ab2012c583d6f212_Out_1;
            Unity_Preview_float(_Split_95c75a1ea7ee4dd7906396bff762bd25_G_2, _Preview_0af5c98f89c44402ab2012c583d6f212_Out_1);
            float4 _Lerp_c2c00306fc734b0c8dee546205970ae6_Out_3;
            Unity_Lerp_float4(_Property_53dfc4b4cafc4a9496bd9fde6989ee8f_Out_0, _Property_601193b6811a41eeb79befed4e93080a_Out_0, (_Preview_0af5c98f89c44402ab2012c583d6f212_Out_1.xxxx), _Lerp_c2c00306fc734b0c8dee546205970ae6_Out_3);
            float4 _Property_72f89d8f335a4977a093f3bae7ef5ea1_Out_0 = Color_2bad1140d6ae465a8b096ead483f5370;
            float4 _Property_8d638ca6b7cc402595ddc523b14de263_Out_0 = Color_1;
            float4 _Lerp_25807026701046b7a4a6abcec2069726_Out_3;
            Unity_Lerp_float4(_Property_72f89d8f335a4977a093f3bae7ef5ea1_Out_0, _Property_8d638ca6b7cc402595ddc523b14de263_Out_0, (_Preview_0af5c98f89c44402ab2012c583d6f212_Out_1.xxxx), _Lerp_25807026701046b7a4a6abcec2069726_Out_3);
            float _SceneDepth_91aa5f89e7564cb2ac5171231a24afdf_Out_1;
            Unity_SceneDepth_Linear01_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_91aa5f89e7564cb2ac5171231a24afdf_Out_1);
            float _Multiply_619704251bdd44e6a8e9f02add36789c_Out_2;
            Unity_Multiply_float_float(_SceneDepth_91aa5f89e7564cb2ac5171231a24afdf_Out_1, _ProjectionParams.z, _Multiply_619704251bdd44e6a8e9f02add36789c_Out_2);
            float4 _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0 = IN.ScreenPosition;
            float _Split_eb526920998f41cd825cbe42160042f5_R_1 = _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0[0];
            float _Split_eb526920998f41cd825cbe42160042f5_G_2 = _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0[1];
            float _Split_eb526920998f41cd825cbe42160042f5_B_3 = _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0[2];
            float _Split_eb526920998f41cd825cbe42160042f5_A_4 = _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0[3];
            float _Property_f4dad9c86f154090a77929fc0594d2eb_Out_0 = Vector1_f108b0f6f7ad4a0fa7970936cde8c93a;
            float _Add_1d0b28a6a0fe41b9aea6de0b9a290419_Out_2;
            Unity_Add_float(_Split_eb526920998f41cd825cbe42160042f5_A_4, _Property_f4dad9c86f154090a77929fc0594d2eb_Out_0, _Add_1d0b28a6a0fe41b9aea6de0b9a290419_Out_2);
            float _Subtract_c310e84b25994cf7969fb6aec3c12631_Out_2;
            Unity_Subtract_float(_Multiply_619704251bdd44e6a8e9f02add36789c_Out_2, _Add_1d0b28a6a0fe41b9aea6de0b9a290419_Out_2, _Subtract_c310e84b25994cf7969fb6aec3c12631_Out_2);
            float _Property_e2cb78357bf54371b95b04624c624355_Out_0 = Vector1_77a8669616464cc68eec17e9163052aa;
            float _Multiply_77d88fee04a2411ebf64a9f3cf93ee09_Out_2;
            Unity_Multiply_float_float(_Subtract_c310e84b25994cf7969fb6aec3c12631_Out_2, _Property_e2cb78357bf54371b95b04624c624355_Out_0, _Multiply_77d88fee04a2411ebf64a9f3cf93ee09_Out_2);
            float _Clamp_5c303e7a7ab74c80819cff967500a688_Out_3;
            Unity_Clamp_float(_Multiply_77d88fee04a2411ebf64a9f3cf93ee09_Out_2, 0, 1, _Clamp_5c303e7a7ab74c80819cff967500a688_Out_3);
            float4 _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3;
            Unity_Lerp_float4(_Lerp_c2c00306fc734b0c8dee546205970ae6_Out_3, _Lerp_25807026701046b7a4a6abcec2069726_Out_3, (_Clamp_5c303e7a7ab74c80819cff967500a688_Out_3.xxxx), _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3);
            UnityTexture2D _Property_691307347e93408bb228020d56a4f64e_Out_0 = UnityBuildTexture2DStructNoScale(Texture2D_2d2e087224e24282b84a086f3316e6e8);
            float4 _SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0 = SAMPLE_TEXTURE2D(_Property_691307347e93408bb228020d56a4f64e_Out_0.tex, _Property_691307347e93408bb228020d56a4f64e_Out_0.samplerstate, _Property_691307347e93408bb228020d56a4f64e_Out_0.GetTransformedUV(IN.MainNormal));
            _SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0);
            float _SampleTexture2D_3802527e187e464aa45999485a38f24f_R_4 = _SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0.r;
            float _SampleTexture2D_3802527e187e464aa45999485a38f24f_G_5 = _SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0.g;
            float _SampleTexture2D_3802527e187e464aa45999485a38f24f_B_6 = _SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0.b;
            float _SampleTexture2D_3802527e187e464aa45999485a38f24f_A_7 = _SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0.a;
            UnityTexture2D _Property_162be1870c564d31abda704370ecd112_Out_0 = UnityBuildTexture2DStructNoScale(Texture2D_21a78e051aa84ab49c73d2364e78102f);
            float4 _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0 = SAMPLE_TEXTURE2D(_Property_162be1870c564d31abda704370ecd112_Out_0.tex, _Property_162be1870c564d31abda704370ecd112_Out_0.samplerstate, _Property_162be1870c564d31abda704370ecd112_Out_0.GetTransformedUV(IN.SecondNormal));
            _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0);
            float _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_R_4 = _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0.r;
            float _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_G_5 = _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0.g;
            float _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_B_6 = _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0.b;
            float _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_A_7 = _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0.a;
            float4 _Add_357900c2d36f40c0b7995aceda820c48_Out_2;
            Unity_Add_float4(_SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0, _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0, _Add_357900c2d36f40c0b7995aceda820c48_Out_2);
            float _Property_bcb4a350b8234af79860039f232f70bb_Out_0 = Vector1_0360d732cbbf426e841ca433b0e337aa;
            float3 _NormalStrength_353fbbdfa63c4bf1a26d328b90d65d75_Out_2;
            Unity_NormalStrength_float((_Add_357900c2d36f40c0b7995aceda820c48_Out_2.xyz), _Property_bcb4a350b8234af79860039f232f70bb_Out_0, _NormalStrength_353fbbdfa63c4bf1a26d328b90d65d75_Out_2);
            float _Property_435f8911f9614444bccaa1b491910830_Out_0 = _RefractionDistrotion;
            float3 _NormalStrength_c661b7411e0343adbe9cd03e17ec5587_Out_2;
            Unity_NormalStrength_float(_NormalStrength_353fbbdfa63c4bf1a26d328b90d65d75_Out_2, _Property_435f8911f9614444bccaa1b491910830_Out_0, _NormalStrength_c661b7411e0343adbe9cd03e17ec5587_Out_2);
            float4 _ScreenPosition_8195cd06776241d5b37929c91c6dad48_Out_0 = float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0);
            float3 _Add_b257228ea21d4b4d977a6133326b7e06_Out_2;
            Unity_Add_float3(_NormalStrength_c661b7411e0343adbe9cd03e17ec5587_Out_2, (_ScreenPosition_8195cd06776241d5b37929c91c6dad48_Out_0.xyz), _Add_b257228ea21d4b4d977a6133326b7e06_Out_2);
            float3 _SceneColor_2c332a05662541f2bba2d1b5eeb47bd2_Out_1;
            Unity_SceneColor_float((float4(_Add_b257228ea21d4b4d977a6133326b7e06_Out_2, 1.0)), _SceneColor_2c332a05662541f2bba2d1b5eeb47bd2_Out_1);
            UnityTexture2D _Property_c55f1526f461489aa2011515ec7da3a3_Out_0 = UnityBuildTexture2DStructNoScale(_PlanarReflectionTexture);
            float3 _Add_9cc9802b3ef24c21b8771b375a3bff42_Out_2;
            Unity_Add_float3(_NormalStrength_353fbbdfa63c4bf1a26d328b90d65d75_Out_2, (_Clamp_5c303e7a7ab74c80819cff967500a688_Out_3.xxx), _Add_9cc9802b3ef24c21b8771b375a3bff42_Out_2);
            float3 _NormalStrength_6161489259bb4747ba0928987b51a0ea_Out_2;
            Unity_NormalStrength_float(_Add_9cc9802b3ef24c21b8771b375a3bff42_Out_2, _Property_435f8911f9614444bccaa1b491910830_Out_0, _NormalStrength_6161489259bb4747ba0928987b51a0ea_Out_2);
            float3 _Add_51f05a9faaf74e72812fae8a48ed882c_Out_2;
            Unity_Add_float3((_ScreenPosition_8195cd06776241d5b37929c91c6dad48_Out_0.xyz), _NormalStrength_6161489259bb4747ba0928987b51a0ea_Out_2, _Add_51f05a9faaf74e72812fae8a48ed882c_Out_2);
            float4 _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_RGBA_0 = SAMPLE_TEXTURE2D(_Property_c55f1526f461489aa2011515ec7da3a3_Out_0.tex, _Property_c55f1526f461489aa2011515ec7da3a3_Out_0.samplerstate, _Property_c55f1526f461489aa2011515ec7da3a3_Out_0.GetTransformedUV((_Add_51f05a9faaf74e72812fae8a48ed882c_Out_2.xy)));
            float _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_R_4 = _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_RGBA_0.r;
            float _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_G_5 = _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_RGBA_0.g;
            float _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_B_6 = _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_RGBA_0.b;
            float _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_A_7 = _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_RGBA_0.a;
            float3 _Lerp_6bca2423774749ccb6b3d02c089ca6aa_Out_3;
            Unity_Lerp_float3(_SceneColor_2c332a05662541f2bba2d1b5eeb47bd2_Out_1, (_SampleTexture2D_60a5b90e4760409a9760488b39b95feb_RGBA_0.xyz), (_Clamp_5c303e7a7ab74c80819cff967500a688_Out_3.xxx), _Lerp_6bca2423774749ccb6b3d02c089ca6aa_Out_3);
            float _Property_4267d14b41a64c8faa1146ffbcfe3618_Out_0 = _Relection_Strength;
            float3 _Blend_1d413404067041f1a38d59c008106e23_Out_2;
            Unity_Blend_Multiply_float3((_Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3.xyz), _Lerp_6bca2423774749ccb6b3d02c089ca6aa_Out_3, _Blend_1d413404067041f1a38d59c008106e23_Out_2, _Property_4267d14b41a64c8faa1146ffbcfe3618_Out_0);
            UnityTexture2D _Property_dff6df0bd4d4495f97a7a18e11ec195a_Out_0 = UnityBuildTexture2DStructNoScale(Texture2D_2d2e087224e24282b84a086f3316e6e8);
            float4 _SampleTexture2D_fd9ae2c1f81b405e9021849934e7146d_RGBA_0 = SAMPLE_TEXTURE2D(_Property_dff6df0bd4d4495f97a7a18e11ec195a_Out_0.tex, _Property_dff6df0bd4d4495f97a7a18e11ec195a_Out_0.samplerstate, _Property_dff6df0bd4d4495f97a7a18e11ec195a_Out_0.GetTransformedUV(IN.MainNormal));
            float _SampleTexture2D_fd9ae2c1f81b405e9021849934e7146d_R_4 = _SampleTexture2D_fd9ae2c1f81b405e9021849934e7146d_RGBA_0.r;
            float _SampleTexture2D_fd9ae2c1f81b405e9021849934e7146d_G_5 = _SampleTexture2D_fd9ae2c1f81b405e9021849934e7146d_RGBA_0.g;
            float _SampleTexture2D_fd9ae2c1f81b405e9021849934e7146d_B_6 = _SampleTexture2D_fd9ae2c1f81b405e9021849934e7146d_RGBA_0.b;
            float _SampleTexture2D_fd9ae2c1f81b405e9021849934e7146d_A_7 = _SampleTexture2D_fd9ae2c1f81b405e9021849934e7146d_RGBA_0.a;
            UnityTexture2D _Property_f0238f5adf1d400c886a5a72ea8e3800_Out_0 = UnityBuildTexture2DStructNoScale(Texture2D_2d2e087224e24282b84a086f3316e6e8);
            float4 _SampleTexture2D_b5339f18d32e4578951e0bd01553c041_RGBA_0 = SAMPLE_TEXTURE2D(_Property_f0238f5adf1d400c886a5a72ea8e3800_Out_0.tex, _Property_f0238f5adf1d400c886a5a72ea8e3800_Out_0.samplerstate, _Property_f0238f5adf1d400c886a5a72ea8e3800_Out_0.GetTransformedUV(IN.SecondNormal));
            float _SampleTexture2D_b5339f18d32e4578951e0bd01553c041_R_4 = _SampleTexture2D_b5339f18d32e4578951e0bd01553c041_RGBA_0.r;
            float _SampleTexture2D_b5339f18d32e4578951e0bd01553c041_G_5 = _SampleTexture2D_b5339f18d32e4578951e0bd01553c041_RGBA_0.g;
            float _SampleTexture2D_b5339f18d32e4578951e0bd01553c041_B_6 = _SampleTexture2D_b5339f18d32e4578951e0bd01553c041_RGBA_0.b;
            float _SampleTexture2D_b5339f18d32e4578951e0bd01553c041_A_7 = _SampleTexture2D_b5339f18d32e4578951e0bd01553c041_RGBA_0.a;
            float4 _Add_f4d1aaeeebe741bfac01df2cb63237d2_Out_2;
            Unity_Add_float4(_SampleTexture2D_fd9ae2c1f81b405e9021849934e7146d_RGBA_0, _SampleTexture2D_b5339f18d32e4578951e0bd01553c041_RGBA_0, _Add_f4d1aaeeebe741bfac01df2cb63237d2_Out_2);
            float _Property_94bcaaa57baf401a892936e8d1121760_Out_0 = _Layer1_Scale;
            float _ColorMask_3b67330abbfa4d5da09be858fde593ec_Out_3;
            Unity_ColorMask_float((_Add_f4d1aaeeebe741bfac01df2cb63237d2_Out_2.xyz), IsGammaSpace() ? float3(1, 1, 1) : SRGBToLinear(float3(1, 1, 1)), _Property_94bcaaa57baf401a892936e8d1121760_Out_0, _ColorMask_3b67330abbfa4d5da09be858fde593ec_Out_3, 0.4);
            UnityTexture2D _Property_edbfda5e1a564ea2aad094a54bb3b007_Out_0 = UnityBuildTexture2DStructNoScale(Texture2D_d65eb6e07c30447ca446c38272609586);
            float4 _SampleTexture2D_7464425046b24f39b9304827ccb6101e_RGBA_0 = SAMPLE_TEXTURE2D(_Property_edbfda5e1a564ea2aad094a54bb3b007_Out_0.tex, _Property_edbfda5e1a564ea2aad094a54bb3b007_Out_0.samplerstate, _Property_edbfda5e1a564ea2aad094a54bb3b007_Out_0.GetTransformedUV(IN.FoamDirection1));
            float _SampleTexture2D_7464425046b24f39b9304827ccb6101e_R_4 = _SampleTexture2D_7464425046b24f39b9304827ccb6101e_RGBA_0.r;
            float _SampleTexture2D_7464425046b24f39b9304827ccb6101e_G_5 = _SampleTexture2D_7464425046b24f39b9304827ccb6101e_RGBA_0.g;
            float _SampleTexture2D_7464425046b24f39b9304827ccb6101e_B_6 = _SampleTexture2D_7464425046b24f39b9304827ccb6101e_RGBA_0.b;
            float _SampleTexture2D_7464425046b24f39b9304827ccb6101e_A_7 = _SampleTexture2D_7464425046b24f39b9304827ccb6101e_RGBA_0.a;
            float4 _Property_05ee1312567a419ea766bcaa855dc2ed_Out_0 = Color_6e3aa9f38d68448bb94d493ef4e3c30a;
            float4 _Multiply_75f2ec69c46847e5aaea2cd6420daa9e_Out_2;
            Unity_Multiply_float4_float4((_SampleTexture2D_7464425046b24f39b9304827ccb6101e_G_5.xxxx), _Property_05ee1312567a419ea766bcaa855dc2ed_Out_0, _Multiply_75f2ec69c46847e5aaea2cd6420daa9e_Out_2);
            float4 _Multiply_e5480cb837904b4ab771dec3029ac8d6_Out_2;
            Unity_Multiply_float4_float4((_ColorMask_3b67330abbfa4d5da09be858fde593ec_Out_3.xxxx), _Multiply_75f2ec69c46847e5aaea2cd6420daa9e_Out_2, _Multiply_e5480cb837904b4ab771dec3029ac8d6_Out_2);
            float _Property_aff115291912400081bcc3de12f2f8ec_Out_0 = _Layer2_Scale;
            float _ColorMask_c2b65a71e09b4b4a97fc255b1947e69e_Out_3;
            Unity_ColorMask_float((_Add_f4d1aaeeebe741bfac01df2cb63237d2_Out_2.xyz), IsGammaSpace() ? float3(1, 1, 1) : SRGBToLinear(float3(1, 1, 1)), _Property_aff115291912400081bcc3de12f2f8ec_Out_0, _ColorMask_c2b65a71e09b4b4a97fc255b1947e69e_Out_3, 0.4);
            float4 _SampleTexture2D_4dcd9985d6b54ac3a3070127f41fef44_RGBA_0 = SAMPLE_TEXTURE2D(_Property_edbfda5e1a564ea2aad094a54bb3b007_Out_0.tex, _Property_edbfda5e1a564ea2aad094a54bb3b007_Out_0.samplerstate, _Property_edbfda5e1a564ea2aad094a54bb3b007_Out_0.GetTransformedUV(IN.FoamDirection2));
            float _SampleTexture2D_4dcd9985d6b54ac3a3070127f41fef44_R_4 = _SampleTexture2D_4dcd9985d6b54ac3a3070127f41fef44_RGBA_0.r;
            float _SampleTexture2D_4dcd9985d6b54ac3a3070127f41fef44_G_5 = _SampleTexture2D_4dcd9985d6b54ac3a3070127f41fef44_RGBA_0.g;
            float _SampleTexture2D_4dcd9985d6b54ac3a3070127f41fef44_B_6 = _SampleTexture2D_4dcd9985d6b54ac3a3070127f41fef44_RGBA_0.b;
            float _SampleTexture2D_4dcd9985d6b54ac3a3070127f41fef44_A_7 = _SampleTexture2D_4dcd9985d6b54ac3a3070127f41fef44_RGBA_0.a;
            float4 _Multiply_d1696f7e6e5a4cdcae3d545c0dab56c5_Out_2;
            Unity_Multiply_float4_float4(_Property_05ee1312567a419ea766bcaa855dc2ed_Out_0, (_SampleTexture2D_4dcd9985d6b54ac3a3070127f41fef44_B_6.xxxx), _Multiply_d1696f7e6e5a4cdcae3d545c0dab56c5_Out_2);
            float4 _Multiply_7ddead3a69614c469917ed7b9aafa900_Out_2;
            Unity_Multiply_float4_float4((_ColorMask_c2b65a71e09b4b4a97fc255b1947e69e_Out_3.xxxx), _Multiply_d1696f7e6e5a4cdcae3d545c0dab56c5_Out_2, _Multiply_7ddead3a69614c469917ed7b9aafa900_Out_2);
            float4 _Add_d1b55de8d8eb46d5be51b419333fbee1_Out_2;
            Unity_Add_float4(_Multiply_e5480cb837904b4ab771dec3029ac8d6_Out_2, _Multiply_7ddead3a69614c469917ed7b9aafa900_Out_2, _Add_d1b55de8d8eb46d5be51b419333fbee1_Out_2);
            float4 _Property_91c7296a1fd34a6ba4ba2db430b227cf_Out_0 = Color_6e3aa9f38d68448bb94d493ef4e3c30a;
            float _Property_25ca0be5c8024b6984b39cc03c10699e_Out_0 = Vector1_aace7401fb3a402e9f06de96963c9b84;
            float _Subtract_af5fef32a00b4cd4863e59c7a5aa9f5c_Out_2;
            Unity_Subtract_float(_Multiply_619704251bdd44e6a8e9f02add36789c_Out_2, _Split_eb526920998f41cd825cbe42160042f5_A_4, _Subtract_af5fef32a00b4cd4863e59c7a5aa9f5c_Out_2);
            float _Subtract_5cb3b9da51094bfc9691cff775ed046c_Out_2;
            Unity_Subtract_float(_Property_25ca0be5c8024b6984b39cc03c10699e_Out_0, _Subtract_af5fef32a00b4cd4863e59c7a5aa9f5c_Out_2, _Subtract_5cb3b9da51094bfc9691cff775ed046c_Out_2);
            float _Property_ddab7adb8fc8414e903ddbb8f8b183e2_Out_0 = Vector1_0d98869735ab4e73a0e4bb36589d00c0;
            float _Multiply_efbf135285134c28b8a80ff0e4ba3f17_Out_2;
            Unity_Multiply_float_float(_Subtract_5cb3b9da51094bfc9691cff775ed046c_Out_2, _Property_ddab7adb8fc8414e903ddbb8f8b183e2_Out_0, _Multiply_efbf135285134c28b8a80ff0e4ba3f17_Out_2);
            float4 _Multiply_92e7da0ce3c448e0a75776463e054f66_Out_2;
            Unity_Multiply_float4_float4(_Property_91c7296a1fd34a6ba4ba2db430b227cf_Out_0, (_Multiply_efbf135285134c28b8a80ff0e4ba3f17_Out_2.xxxx), _Multiply_92e7da0ce3c448e0a75776463e054f66_Out_2);
            UnityTexture2D _Property_2613ec34f9504d22aafecb7ad6480e1e_Out_0 = UnityBuildTexture2DStructNoScale(Texture2D_d65eb6e07c30447ca446c38272609586);
            float2 _Property_49ee0e056d6942968b9200a4a85c3251_Out_0 = Vector2_2832e3b0590c4ee98f806b14c0f54c5b;
            float2 _TilingAndOffset_b50bda6ad9b140f9b0ca863214f6b957_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Property_49ee0e056d6942968b9200a4a85c3251_Out_0, float2 (0.18, 0), _TilingAndOffset_b50bda6ad9b140f9b0ca863214f6b957_Out_3);
            float4 _SampleTexture2D_00f1f15016c649f0ae4e0c96597e573f_RGBA_0 = SAMPLE_TEXTURE2D(_Property_2613ec34f9504d22aafecb7ad6480e1e_Out_0.tex, _Property_2613ec34f9504d22aafecb7ad6480e1e_Out_0.samplerstate, _Property_2613ec34f9504d22aafecb7ad6480e1e_Out_0.GetTransformedUV(_TilingAndOffset_b50bda6ad9b140f9b0ca863214f6b957_Out_3));
            float _SampleTexture2D_00f1f15016c649f0ae4e0c96597e573f_R_4 = _SampleTexture2D_00f1f15016c649f0ae4e0c96597e573f_RGBA_0.r;
            float _SampleTexture2D_00f1f15016c649f0ae4e0c96597e573f_G_5 = _SampleTexture2D_00f1f15016c649f0ae4e0c96597e573f_RGBA_0.g;
            float _SampleTexture2D_00f1f15016c649f0ae4e0c96597e573f_B_6 = _SampleTexture2D_00f1f15016c649f0ae4e0c96597e573f_RGBA_0.b;
            float _SampleTexture2D_00f1f15016c649f0ae4e0c96597e573f_A_7 = _SampleTexture2D_00f1f15016c649f0ae4e0c96597e573f_RGBA_0.a;
            float4 _Multiply_4f081b87dfcb4a41bb7615b058040e89_Out_2;
            Unity_Multiply_float4_float4(_Multiply_92e7da0ce3c448e0a75776463e054f66_Out_2, (_SampleTexture2D_00f1f15016c649f0ae4e0c96597e573f_G_5.xxxx), _Multiply_4f081b87dfcb4a41bb7615b058040e89_Out_2);
            float4 _Clamp_3a0f28c23b344448ac636ad89dbdb3e7_Out_3;
            Unity_Clamp_float4(_Multiply_4f081b87dfcb4a41bb7615b058040e89_Out_2, float4(0, 0, 0, 0), float4(1, 1, 1, 1), _Clamp_3a0f28c23b344448ac636ad89dbdb3e7_Out_3);
            float4 _Add_fb079be2c07b4115bae3a3c384291108_Out_2;
            Unity_Add_float4(_Add_d1b55de8d8eb46d5be51b419333fbee1_Out_2, _Clamp_3a0f28c23b344448ac636ad89dbdb3e7_Out_3, _Add_fb079be2c07b4115bae3a3c384291108_Out_2);
            float _Property_c85200fdac2540b9b3e122c51e3ffcbb_Out_0 = Vector1_69bcaf9cf50f40a2bef27afe006bbc8f;
            float _Split_32fd3b93931741f5ba645cdab3f37d0f_R_1 = _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3[0];
            float _Split_32fd3b93931741f5ba645cdab3f37d0f_G_2 = _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3[1];
            float _Split_32fd3b93931741f5ba645cdab3f37d0f_B_3 = _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3[2];
            float _Split_32fd3b93931741f5ba645cdab3f37d0f_A_4 = _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3[3];
            surface.BaseColor = _Blend_1d413404067041f1a38d59c008106e23_Out_2;
            surface.NormalTS = _NormalStrength_353fbbdfa63c4bf1a26d328b90d65d75_Out_2;
            surface.Emission = (_Add_fb079be2c07b4115bae3a3c384291108_Out_2.xyz);
            surface.Metallic = 0;
            surface.Smoothness = _Property_c85200fdac2540b9b3e122c51e3ffcbb_Out_0;
            surface.Occlusion = 1;
            surface.Alpha = _Split_32fd3b93931741f5ba645cdab3f37d0f_A_4;
            surface.AlphaClipThreshold = 0;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
            output.AbsoluteWorldSpacePosition =                 GetAbsolutePositionWS(TransformObjectToWorld(input.positionOS));
            output.uv0 =                                        input.uv0;
            output.TimeParameters =                             _TimeParameters.xyz;
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            output.MainNormal = input.MainNormal;
        output.SecondNormal = input.SecondNormal;
        output.FoamDirection1 = input.FoamDirection1;
        output.FoamDirection2 = input.FoamDirection2;
        
        
        
            output.TangentSpaceNormal = float3(0.0f, 0.0f, 1.0f);
        
        
            output.WorldSpacePosition = input.positionWS;
            output.ScreenPosition = ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
            output.uv0 = input.texCoord0;
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBRForwardPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            Name "GBuffer"
            Tags
            {
                "LightMode" = "UniversalGBuffer"
            }
        
        // Render State
        Cull Back
        Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
        ZTest LEqual
        ZWrite Off
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 4.5
        #pragma exclude_renderers gles gles3 glcore
        #pragma multi_compile_instancing
        #pragma multi_compile_fog
        #pragma instancing_options renderinglayer
        #pragma multi_compile _ DOTS_INSTANCING_ON
        #pragma vertex vert
        #pragma fragment frag
        
        // DotsInstancingOptions: <None>
        // HybridV1InjectedBuiltinProperties: <None>
        
        // Keywords
        #pragma multi_compile _ LIGHTMAP_ON
        #pragma multi_compile _ DYNAMICLIGHTMAP_ON
        #pragma multi_compile _ DIRLIGHTMAP_COMBINED
        #pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN
        #pragma multi_compile _ _REFLECTION_PROBE_BLENDING
        #pragma multi_compile _ _REFLECTION_PROBE_BOX_PROJECTION
        #pragma multi_compile _ _SHADOWS_SOFT
        #pragma multi_compile _ LIGHTMAP_SHADOW_MIXING
        #pragma multi_compile _ _MIXED_LIGHTING_SUBTRACTIVE
        #pragma multi_compile _ _DBUFFER_MRT1 _DBUFFER_MRT2 _DBUFFER_MRT3
        #pragma multi_compile _ _GBUFFER_NORMALS_OCT
        #pragma multi_compile _ _LIGHT_LAYERS
        #pragma multi_compile _ _RENDER_PASS_ENABLED
        #pragma multi_compile _ DEBUG_DISPLAY
        // GraphKeywords: <None>
        
        // Defines
        
        #define _NORMALMAP 1
        #define _NORMAL_DROPOFF_TS 1
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define ATTRIBUTES_NEED_TEXCOORD1
        #define ATTRIBUTES_NEED_TEXCOORD2
        #define VARYINGS_NEED_POSITION_WS
        #define VARYINGS_NEED_NORMAL_WS
        #define VARYINGS_NEED_TANGENT_WS
        #define VARYINGS_NEED_TEXCOORD0
        #define VARYINGS_NEED_VIEWDIRECTION_WS
        #define VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
        #define VARYINGS_NEED_SHADOW_COORD
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_GBUFFER
        #define _FOG_FRAGMENT 1
        #define _SURFACE_TYPE_TRANSPARENT 1
        #define _ALPHATEST_ON 1
        #define REQUIRE_DEPTH_TEXTURE
        #define REQUIRE_OPAQUE_TEXTURE
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DBuffer.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
             float4 uv1 : TEXCOORD1;
             float4 uv2 : TEXCOORD2;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float3 positionWS;
             float3 normalWS;
             float4 tangentWS;
             float4 texCoord0;
             float3 viewDirectionWS;
            #if defined(LIGHTMAP_ON)
             float2 staticLightmapUV;
            #endif
            #if defined(DYNAMICLIGHTMAP_ON)
             float2 dynamicLightmapUV;
            #endif
            #if !defined(LIGHTMAP_ON)
             float3 sh;
            #endif
             float4 fogFactorAndVertexLight;
            #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
             float4 shadowCoord;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
             float2 MainNormal;
             float2 SecondNormal;
             float2 FoamDirection1;
             float2 FoamDirection2;
        };
        struct SurfaceDescriptionInputs
        {
             float3 TangentSpaceNormal;
             float3 WorldSpacePosition;
             float4 ScreenPosition;
             float4 uv0;
             float2 MainNormal;
             float2 SecondNormal;
             float2 FoamDirection1;
             float2 FoamDirection2;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
             float3 AbsoluteWorldSpacePosition;
             float4 uv0;
             float3 TimeParameters;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float3 interp0 : INTERP0;
             float3 interp1 : INTERP1;
             float4 interp2 : INTERP2;
             float4 interp3 : INTERP3;
             float3 interp4 : INTERP4;
             float4 interp5 : INTERP5;
             float4 interp6 : INTERP6;
             float3 interp7 : INTERP7;
             float4 interp8 : INTERP8;
             float4 interp9 : INTERP9;
             float4 interp10 : INTERP10;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.positionWS;
            output.interp1.xyz =  input.normalWS;
            output.interp2.xyzw =  input.tangentWS;
            output.interp3.xyzw =  input.texCoord0;
            output.interp4.xyz =  input.viewDirectionWS;
            #if defined(LIGHTMAP_ON)
            output.interp5.xy =  input.staticLightmapUV;
            #endif
            #if defined(DYNAMICLIGHTMAP_ON)
            output.interp6.xy =  input.dynamicLightmapUV;
            #endif
            #if !defined(LIGHTMAP_ON)
            output.interp7.xyz =  input.sh;
            #endif
            output.interp8.xyzw =  input.fogFactorAndVertexLight;
            #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
            output.interp9.xyzw =  input.shadowCoord;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            output.interp5.zw =  input.MainNormal;
            output.interp6.zw =  input.SecondNormal;
            output.interp10.xy =  input.FoamDirection1;
            output.interp10.zw =  input.FoamDirection2;
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.positionWS = input.interp0.xyz;
            output.normalWS = input.interp1.xyz;
            output.tangentWS = input.interp2.xyzw;
            output.texCoord0 = input.interp3.xyzw;
            output.viewDirectionWS = input.interp4.xyz;
            #if defined(LIGHTMAP_ON)
            output.staticLightmapUV = input.interp5.xy;
            #endif
            #if defined(DYNAMICLIGHTMAP_ON)
            output.dynamicLightmapUV = input.interp6.xy;
            #endif
            #if !defined(LIGHTMAP_ON)
            output.sh = input.interp7.xyz;
            #endif
            output.fogFactorAndVertexLight = input.interp8.xyzw;
            #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
            output.shadowCoord = input.interp9.xyzw;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            output.MainNormal = input.interp5.zw;
            output.SecondNormal = input.interp6.zw;
            output.FoamDirection1 = input.interp10.xy;
            output.FoamDirection2 = input.interp10.zw;
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float4 _PlanarReflectionTexture_TexelSize;
        float Vector1_f108b0f6f7ad4a0fa7970936cde8c93a;
        float Vector1_77a8669616464cc68eec17e9163052aa;
        float4 Color_2bad1140d6ae465a8b096ead483f5370;
        float4 Color_b5081859698940efa07a6cc68ff92e70;
        float4 Color_1;
        float4 Texture2D_2d2e087224e24282b84a086f3316e6e8_TexelSize;
        float2 Vector2_c2fe4e7c2a7649b28d7ab078fdadda1c;
        float Vector1_7614a6098dec470e8a4e96a5c8551362;
        float4 Texture2D_21a78e051aa84ab49c73d2364e78102f_TexelSize;
        float2 Vector2_73fa27b3bcf64608a50eed7c1d0d3411;
        float Vector1_898460d8305d4dfe9af1298eb6f67082;
        float Vector1_0360d732cbbf426e841ca433b0e337aa;
        float Vector1_dcce861f82224ec1ac55aa94df3b3d12;
        float Vector1_3606b8114ded4a74a4e4834f8bf7dc12;
        float Vector1_69bcaf9cf50f40a2bef27afe006bbc8f;
        float4 Color_6e3aa9f38d68448bb94d493ef4e3c30a;
        float Vector1_0d98869735ab4e73a0e4bb36589d00c0;
        float Vector1_aace7401fb3a402e9f06de96963c9b84;
        float4 Texture2D_d65eb6e07c30447ca446c38272609586_TexelSize;
        float2 Vector2_2832e3b0590c4ee98f806b14c0f54c5b;
        float4 _Shallow_Water_Color_2;
        float2 _Panning;
        float _DistortionSpeed;
        float _DistortionIntensity;
        float2 _FoamNoiseTilling;
        float _DistortionScale;
        float _NoiseScale;
        float _Layer1_Scale;
        float _Layer2_Scale;
        float _RefractionDistrotion;
        float _Relection_Strength;
        CBUFFER_END
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_PlanarReflectionTexture);
        SAMPLER(sampler_PlanarReflectionTexture);
        TEXTURE2D(Texture2D_2d2e087224e24282b84a086f3316e6e8);
        SAMPLER(samplerTexture2D_2d2e087224e24282b84a086f3316e6e8);
        TEXTURE2D(Texture2D_21a78e051aa84ab49c73d2364e78102f);
        SAMPLER(samplerTexture2D_21a78e051aa84ab49c73d2364e78102f);
        TEXTURE2D(Texture2D_d65eb6e07c30447ca446c38272609586);
        SAMPLER(samplerTexture2D_d65eb6e07c30447ca446c38272609586);
        
        // Graph Includes
        // GraphIncludes: <None>
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        
        inline float Unity_SimpleNoise_RandomValue_float (float2 uv)
        {
            float angle = dot(uv, float2(12.9898, 78.233));
            #if defined(SHADER_API_MOBILE) && (defined(SHADER_API_GLES) || defined(SHADER_API_GLES3) || defined(SHADER_API_VULKAN))
                // 'sin()' has bad precision on Mali GPUs for inputs > 10000
                angle = fmod(angle, TWO_PI); // Avoid large inputs to sin()
            #endif
            return frac(sin(angle)*43758.5453);
        }
        
        inline float Unity_SimpleNnoise_Interpolate_float (float a, float b, float t)
        {
            return (1.0-t)*a + (t*b);
        }
        
        
        inline float Unity_SimpleNoise_ValueNoise_float (float2 uv)
        {
            float2 i = floor(uv);
            float2 f = frac(uv);
            f = f * f * (3.0 - 2.0 * f);
        
            uv = abs(frac(uv) - 0.5);
            float2 c0 = i + float2(0.0, 0.0);
            float2 c1 = i + float2(1.0, 0.0);
            float2 c2 = i + float2(0.0, 1.0);
            float2 c3 = i + float2(1.0, 1.0);
            float r0 = Unity_SimpleNoise_RandomValue_float(c0);
            float r1 = Unity_SimpleNoise_RandomValue_float(c1);
            float r2 = Unity_SimpleNoise_RandomValue_float(c2);
            float r3 = Unity_SimpleNoise_RandomValue_float(c3);
        
            float bottomOfGrid = Unity_SimpleNnoise_Interpolate_float(r0, r1, f.x);
            float topOfGrid = Unity_SimpleNnoise_Interpolate_float(r2, r3, f.x);
            float t = Unity_SimpleNnoise_Interpolate_float(bottomOfGrid, topOfGrid, f.y);
            return t;
        }
        void Unity_SimpleNoise_float(float2 UV, float Scale, out float Out)
        {
            float t = 0.0;
        
            float freq = pow(2.0, float(0));
            float amp = pow(0.5, float(3-0));
            t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale/freq, UV.y*Scale/freq))*amp;
        
            freq = pow(2.0, float(1));
            amp = pow(0.5, float(3-1));
            t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale/freq, UV.y*Scale/freq))*amp;
        
            freq = pow(2.0, float(2));
            amp = pow(0.5, float(3-2));
            t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale/freq, UV.y*Scale/freq))*amp;
        
            Out = t;
        }
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }
        
        void Unity_Multiply_float2_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A * B;
        }
        
        void Unity_Lerp_float2(float2 A, float2 B, float2 T, out float2 Out)
        {
            Out = lerp(A, B, T);
        }
        
        
        float2 Unity_GradientNoise_Dir_float(float2 p)
        {
            // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
            p = p % 289;
            // need full precision, otherwise half overflows when p > 1
            float x = float(34 * p.x + 1) * p.x % 289 + p.y;
            x = (34 * x + 1) * x % 289;
            x = frac(x / 41) * 2 - 1;
            return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
        }
        
        void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
        {
            float2 p = UV * Scale;
            float2 ip = floor(p);
            float2 fp = frac(p);
            float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
            float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
            float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
            float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
            fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
            Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Preview_float(float In, out float Out)
        {
            Out = In;
        }
        
        void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
        {
            Out = lerp(A, B, T);
        }
        
        void Unity_SceneDepth_Linear01_float(float4 UV, out float Out)
        {
            Out = Linear01Depth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }
        
        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }
        
        void Unity_Add_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A + B;
        }
        
        void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
        {
            Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
        }
        
        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }
        
        void Unity_SceneColor_float(float4 UV, out float3 Out)
        {
            Out = SHADERGRAPH_SAMPLE_SCENE_COLOR(UV.xy);
        }
        
        void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
        {
            Out = lerp(A, B, T);
        }
        
        void Unity_Blend_Multiply_float3(float3 Base, float3 Blend, out float3 Out, float Opacity)
        {
            Out = Base * Blend;
            Out = lerp(Base, Out, Opacity);
        }
        
        void Unity_ColorMask_float(float3 In, float3 MaskColor, float Range, out float Out, float Fuzziness)
        {
            float Distance = distance(MaskColor, In);
            Out = saturate(1 - (Distance - Range) / max(Fuzziness, 1e-5));
        }
        
        void Unity_Multiply_float4_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }
        
        void Unity_Clamp_float4(float4 In, float4 Min, float4 Max, out float4 Out)
        {
            Out = clamp(In, Min, Max);
        }
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
            float2 MainNormal;
            float2 SecondNormal;
            float2 FoamDirection1;
            float2 FoamDirection2;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            float _Property_271cd524054a48d0ac03da3ed0e18981_Out_0 = _NoiseScale;
            float _Property_d6b17372f8e24d1ba887e19ca0b9b532_Out_0 = _DistortionSpeed;
            float _Multiply_6b5e1abaf00147a8a2bd61cb3a63ac2d_Out_2;
            Unity_Multiply_float_float(0.9, _Property_d6b17372f8e24d1ba887e19ca0b9b532_Out_0, _Multiply_6b5e1abaf00147a8a2bd61cb3a63ac2d_Out_2);
            float _Multiply_0b2927096f2b406eade60b0ff8497f06_Out_2;
            Unity_Multiply_float_float(_Multiply_6b5e1abaf00147a8a2bd61cb3a63ac2d_Out_2, IN.TimeParameters.x, _Multiply_0b2927096f2b406eade60b0ff8497f06_Out_2);
            float2 _TilingAndOffset_3ae4fb84d8a24ae6b255b068ec01f495_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, float2 (1, 1), (_Multiply_0b2927096f2b406eade60b0ff8497f06_Out_2.xx), _TilingAndOffset_3ae4fb84d8a24ae6b255b068ec01f495_Out_3);
            float _SimpleNoise_310007c52b3547759f3d9a40829d9fdb_Out_2;
            Unity_SimpleNoise_float(_TilingAndOffset_3ae4fb84d8a24ae6b255b068ec01f495_Out_3, _Property_271cd524054a48d0ac03da3ed0e18981_Out_0, _SimpleNoise_310007c52b3547759f3d9a40829d9fdb_Out_2);
            float2 _Property_caf806c45b8648239ed928655b2dc075_Out_0 = _FoamNoiseTilling;
            float _Property_83fd66d76a934370a36fc75a684ef06a_Out_0 = _DistortionIntensity;
            float _Property_31ef0e62fff04fde85a1f9ac39636e5c_Out_0 = _NoiseScale;
            float _Property_1df622d21af24ccca4f9f326808f58fc_Out_0 = _DistortionSpeed;
            float _Multiply_8c038a6c11994a53b09ad756f38d3c5d_Out_2;
            Unity_Multiply_float_float(-0.9, _Property_1df622d21af24ccca4f9f326808f58fc_Out_0, _Multiply_8c038a6c11994a53b09ad756f38d3c5d_Out_2);
            float _Multiply_c710fb8d99aa474cb13c0d65aa2a1829_Out_2;
            Unity_Multiply_float_float(_Multiply_8c038a6c11994a53b09ad756f38d3c5d_Out_2, IN.TimeParameters.x, _Multiply_c710fb8d99aa474cb13c0d65aa2a1829_Out_2);
            float2 _TilingAndOffset_b5b7efd61dd0407b81b2ec53772b278d_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, float2 (1, 1), (_Multiply_c710fb8d99aa474cb13c0d65aa2a1829_Out_2.xx), _TilingAndOffset_b5b7efd61dd0407b81b2ec53772b278d_Out_3);
            float _SimpleNoise_4e904d56e17345ff8f80d57968580a32_Out_2;
            Unity_SimpleNoise_float(_TilingAndOffset_b5b7efd61dd0407b81b2ec53772b278d_Out_3, _Property_31ef0e62fff04fde85a1f9ac39636e5c_Out_0, _SimpleNoise_4e904d56e17345ff8f80d57968580a32_Out_2);
            float _Divide_2d74bf9a40ba416f9b680ba114404dc2_Out_2;
            Unity_Divide_float(IN.TimeParameters.x, 6, _Divide_2d74bf9a40ba416f9b680ba114404dc2_Out_2);
            float2 _Property_702ff1c785d542499e4ead1def7e1418_Out_0 = _Panning;
            float _Split_252c3e0a27db4d66a7df034157244e21_R_1 = _Property_702ff1c785d542499e4ead1def7e1418_Out_0[0];
            float _Split_252c3e0a27db4d66a7df034157244e21_G_2 = _Property_702ff1c785d542499e4ead1def7e1418_Out_0[1];
            float _Split_252c3e0a27db4d66a7df034157244e21_B_3 = 0;
            float _Split_252c3e0a27db4d66a7df034157244e21_A_4 = 0;
            float _Multiply_e016b9a16b4e4abba2502adb5862e043_Out_2;
            Unity_Multiply_float_float(_Split_252c3e0a27db4d66a7df034157244e21_G_2, _Divide_2d74bf9a40ba416f9b680ba114404dc2_Out_2, _Multiply_e016b9a16b4e4abba2502adb5862e043_Out_2);
            float _Multiply_218b27dc95a243998b30f016e0d3988e_Out_2;
            Unity_Multiply_float_float(_Split_252c3e0a27db4d66a7df034157244e21_R_1, _Divide_2d74bf9a40ba416f9b680ba114404dc2_Out_2, _Multiply_218b27dc95a243998b30f016e0d3988e_Out_2);
            float4 _Combine_6ae549d623c54cce9850c0bc9b3405eb_RGBA_4;
            float3 _Combine_6ae549d623c54cce9850c0bc9b3405eb_RGB_5;
            float2 _Combine_6ae549d623c54cce9850c0bc9b3405eb_RG_6;
            Unity_Combine_float(_Multiply_218b27dc95a243998b30f016e0d3988e_Out_2, _Multiply_e016b9a16b4e4abba2502adb5862e043_Out_2, 0, 0, _Combine_6ae549d623c54cce9850c0bc9b3405eb_RGBA_4, _Combine_6ae549d623c54cce9850c0bc9b3405eb_RGB_5, _Combine_6ae549d623c54cce9850c0bc9b3405eb_RG_6);
            float _Float_f89ffb73213141f1aa48acbe034e5ea3_Out_0 = 0.02;
            float2 _Swizzle_d519ed834a284e518d347105c3a11492_Out_1 = IN.AbsoluteWorldSpacePosition.xz;
            float2 _Multiply_39c33974737143ae9f76cce56d3d33d2_Out_2;
            Unity_Multiply_float2_float2(_Swizzle_d519ed834a284e518d347105c3a11492_Out_1, (_Float_f89ffb73213141f1aa48acbe034e5ea3_Out_0.xx), _Multiply_39c33974737143ae9f76cce56d3d33d2_Out_2);
            float2 _TilingAndOffset_9f5c71641fa94a59a413d51e3a6aec3d_Out_3;
            Unity_TilingAndOffset_float(_Multiply_39c33974737143ae9f76cce56d3d33d2_Out_2, float2 (1, 1), _Combine_6ae549d623c54cce9850c0bc9b3405eb_RG_6, _TilingAndOffset_9f5c71641fa94a59a413d51e3a6aec3d_Out_3);
            float2 _Lerp_6ba3378c16cf44e49e4a44f6e2f26c65_Out_3;
            Unity_Lerp_float2(_TilingAndOffset_9f5c71641fa94a59a413d51e3a6aec3d_Out_3, (_SimpleNoise_310007c52b3547759f3d9a40829d9fdb_Out_2.xx), (_Property_83fd66d76a934370a36fc75a684ef06a_Out_0.xx), _Lerp_6ba3378c16cf44e49e4a44f6e2f26c65_Out_3);
            float2 _TilingAndOffset_c89d2fcde70d4d818249ebe200337480_Out_3;
            Unity_TilingAndOffset_float(_Lerp_6ba3378c16cf44e49e4a44f6e2f26c65_Out_3, _Property_caf806c45b8648239ed928655b2dc075_Out_0, float2 (0.81, 0), _TilingAndOffset_c89d2fcde70d4d818249ebe200337480_Out_3);
            float2 _Lerp_3759f9668f544adb8dd7eee5886abeb0_Out_3;
            Unity_Lerp_float2(_TilingAndOffset_9f5c71641fa94a59a413d51e3a6aec3d_Out_3, (_SimpleNoise_4e904d56e17345ff8f80d57968580a32_Out_2.xx), (_Property_83fd66d76a934370a36fc75a684ef06a_Out_0.xx), _Lerp_3759f9668f544adb8dd7eee5886abeb0_Out_3);
            float2 _TilingAndOffset_e2926df184da41caab0fcf14e34b81a7_Out_3;
            Unity_TilingAndOffset_float(_Lerp_3759f9668f544adb8dd7eee5886abeb0_Out_3, _Property_caf806c45b8648239ed928655b2dc075_Out_0, float2 (0.81, 0), _TilingAndOffset_e2926df184da41caab0fcf14e34b81a7_Out_3);
            float _Property_8a79f817e59948938215b338bcdc46df_Out_0 = Vector1_898460d8305d4dfe9af1298eb6f67082;
            float _Multiply_ed606ef7153b456b854854134a8f65f9_Out_2;
            Unity_Multiply_float_float(_Property_8a79f817e59948938215b338bcdc46df_Out_0, 0.01, _Multiply_ed606ef7153b456b854854134a8f65f9_Out_2);
            float2 _Property_0264c1738ed14b318538f5f39eb56d07_Out_0 = Vector2_73fa27b3bcf64608a50eed7c1d0d3411;
            float _Divide_d29c49a16f234ef78eee8f12e556a643_Out_2;
            Unity_Divide_float(IN.TimeParameters.x, 5, _Divide_d29c49a16f234ef78eee8f12e556a643_Out_2);
            float _Multiply_5928ff83990b4a61bfdfa392f6154eda_Out_2;
            Unity_Multiply_float_float(_Divide_d29c49a16f234ef78eee8f12e556a643_Out_2, _Multiply_ed606ef7153b456b854854134a8f65f9_Out_2, _Multiply_5928ff83990b4a61bfdfa392f6154eda_Out_2);
            float2 _TilingAndOffset_08fa9dddbfc44f8b9e671e082ef10419_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Property_0264c1738ed14b318538f5f39eb56d07_Out_0, (_Multiply_5928ff83990b4a61bfdfa392f6154eda_Out_2.xx), _TilingAndOffset_08fa9dddbfc44f8b9e671e082ef10419_Out_3);
            float _Property_32d848f89d264e118a7bc7b7cbae9677_Out_0 = Vector1_7614a6098dec470e8a4e96a5c8551362;
            float _Multiply_1541a6ad358e4ea281033d8831f2ba13_Out_2;
            Unity_Multiply_float_float(_Property_32d848f89d264e118a7bc7b7cbae9677_Out_0, -0.01, _Multiply_1541a6ad358e4ea281033d8831f2ba13_Out_2);
            float _Multiply_edd1ffe542204260a884842fd7a18fc1_Out_2;
            Unity_Multiply_float_float(_Multiply_1541a6ad358e4ea281033d8831f2ba13_Out_2, _Divide_d29c49a16f234ef78eee8f12e556a643_Out_2, _Multiply_edd1ffe542204260a884842fd7a18fc1_Out_2);
            float2 _Property_123c8148386d41aa9d1698d86033f0b5_Out_0 = Vector2_c2fe4e7c2a7649b28d7ab078fdadda1c;
            float2 _TilingAndOffset_924ee153284a4d4abbd47514c96bb1ae_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Property_123c8148386d41aa9d1698d86033f0b5_Out_0, (_Multiply_edd1ffe542204260a884842fd7a18fc1_Out_2.xx), _TilingAndOffset_924ee153284a4d4abbd47514c96bb1ae_Out_3);
            float _Split_d8eed8fe26594972914c124586d98bbf_R_1 = IN.ObjectSpacePosition[0];
            float _Split_d8eed8fe26594972914c124586d98bbf_G_2 = IN.ObjectSpacePosition[1];
            float _Split_d8eed8fe26594972914c124586d98bbf_B_3 = IN.ObjectSpacePosition[2];
            float _Split_d8eed8fe26594972914c124586d98bbf_A_4 = 0;
            float _Property_762630e6999b4da0a14b2ccffa4209d8_Out_0 = Vector1_dcce861f82224ec1ac55aa94df3b3d12;
            float _Divide_df746930d1d841c09a66286a0a3543ae_Out_2;
            Unity_Divide_float(_Property_762630e6999b4da0a14b2ccffa4209d8_Out_0, 200, _Divide_df746930d1d841c09a66286a0a3543ae_Out_2);
            float _Property_d73cd49e4412457080da3ad6f38ac94b_Out_0 = Vector1_3606b8114ded4a74a4e4834f8bf7dc12;
            float _Divide_b14ec7aec4874b8ab4371962384288e5_Out_2;
            Unity_Divide_float(_Property_d73cd49e4412457080da3ad6f38ac94b_Out_0, 50, _Divide_b14ec7aec4874b8ab4371962384288e5_Out_2);
            float _Multiply_f97f597155bf4b59afa13426042ec0a0_Out_2;
            Unity_Multiply_float_float(IN.TimeParameters.x, _Divide_b14ec7aec4874b8ab4371962384288e5_Out_2, _Multiply_f97f597155bf4b59afa13426042ec0a0_Out_2);
            float2 _TilingAndOffset_ab2fed3c342049de89287a73af5f4dd1_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, (_Multiply_f97f597155bf4b59afa13426042ec0a0_Out_2.xx), float2 (0, 0), _TilingAndOffset_ab2fed3c342049de89287a73af5f4dd1_Out_3);
            float _GradientNoise_c349a7da229a42f6acfd0e9329f501a7_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_ab2fed3c342049de89287a73af5f4dd1_Out_3, 0.96, _GradientNoise_c349a7da229a42f6acfd0e9329f501a7_Out_2);
            float _Multiply_9460f57a023144a9ae646cb7ff3c8354_Out_2;
            Unity_Multiply_float_float(_Divide_df746930d1d841c09a66286a0a3543ae_Out_2, _GradientNoise_c349a7da229a42f6acfd0e9329f501a7_Out_2, _Multiply_9460f57a023144a9ae646cb7ff3c8354_Out_2);
            float _Add_5cf9a595f1104a0ba7d0c02acbf47625_Out_2;
            Unity_Add_float(_Split_d8eed8fe26594972914c124586d98bbf_G_2, _Multiply_9460f57a023144a9ae646cb7ff3c8354_Out_2, _Add_5cf9a595f1104a0ba7d0c02acbf47625_Out_2);
            float4 _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGBA_4;
            float3 _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGB_5;
            float2 _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RG_6;
            Unity_Combine_float(_Split_d8eed8fe26594972914c124586d98bbf_R_1, _Add_5cf9a595f1104a0ba7d0c02acbf47625_Out_2, _Split_d8eed8fe26594972914c124586d98bbf_B_3, 0, _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGBA_4, _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGB_5, _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RG_6);
            description.Position = _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGB_5;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            description.MainNormal = _TilingAndOffset_924ee153284a4d4abbd47514c96bb1ae_Out_3;
            description.SecondNormal = _TilingAndOffset_08fa9dddbfc44f8b9e671e082ef10419_Out_3;
            description.FoamDirection1 = _TilingAndOffset_e2926df184da41caab0fcf14e34b81a7_Out_3;
            description.FoamDirection2 = _TilingAndOffset_c89d2fcde70d4d818249ebe200337480_Out_3;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        output.MainNormal = input.MainNormal;
        output.SecondNormal = input.SecondNormal;
        output.FoamDirection1 = input.FoamDirection1;
        output.FoamDirection2 = input.FoamDirection2;
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float3 BaseColor;
            float3 NormalTS;
            float3 Emission;
            float Metallic;
            float Smoothness;
            float Occlusion;
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float4 _Property_53dfc4b4cafc4a9496bd9fde6989ee8f_Out_0 = Color_b5081859698940efa07a6cc68ff92e70;
            float4 _Property_601193b6811a41eeb79befed4e93080a_Out_0 = _Shallow_Water_Color_2;
            float4 _UV_0459ed23840544d4943e249e6bf3def0_Out_0 = IN.uv0;
            float _Split_95c75a1ea7ee4dd7906396bff762bd25_R_1 = _UV_0459ed23840544d4943e249e6bf3def0_Out_0[0];
            float _Split_95c75a1ea7ee4dd7906396bff762bd25_G_2 = _UV_0459ed23840544d4943e249e6bf3def0_Out_0[1];
            float _Split_95c75a1ea7ee4dd7906396bff762bd25_B_3 = _UV_0459ed23840544d4943e249e6bf3def0_Out_0[2];
            float _Split_95c75a1ea7ee4dd7906396bff762bd25_A_4 = _UV_0459ed23840544d4943e249e6bf3def0_Out_0[3];
            float _Preview_0af5c98f89c44402ab2012c583d6f212_Out_1;
            Unity_Preview_float(_Split_95c75a1ea7ee4dd7906396bff762bd25_G_2, _Preview_0af5c98f89c44402ab2012c583d6f212_Out_1);
            float4 _Lerp_c2c00306fc734b0c8dee546205970ae6_Out_3;
            Unity_Lerp_float4(_Property_53dfc4b4cafc4a9496bd9fde6989ee8f_Out_0, _Property_601193b6811a41eeb79befed4e93080a_Out_0, (_Preview_0af5c98f89c44402ab2012c583d6f212_Out_1.xxxx), _Lerp_c2c00306fc734b0c8dee546205970ae6_Out_3);
            float4 _Property_72f89d8f335a4977a093f3bae7ef5ea1_Out_0 = Color_2bad1140d6ae465a8b096ead483f5370;
            float4 _Property_8d638ca6b7cc402595ddc523b14de263_Out_0 = Color_1;
            float4 _Lerp_25807026701046b7a4a6abcec2069726_Out_3;
            Unity_Lerp_float4(_Property_72f89d8f335a4977a093f3bae7ef5ea1_Out_0, _Property_8d638ca6b7cc402595ddc523b14de263_Out_0, (_Preview_0af5c98f89c44402ab2012c583d6f212_Out_1.xxxx), _Lerp_25807026701046b7a4a6abcec2069726_Out_3);
            float _SceneDepth_91aa5f89e7564cb2ac5171231a24afdf_Out_1;
            Unity_SceneDepth_Linear01_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_91aa5f89e7564cb2ac5171231a24afdf_Out_1);
            float _Multiply_619704251bdd44e6a8e9f02add36789c_Out_2;
            Unity_Multiply_float_float(_SceneDepth_91aa5f89e7564cb2ac5171231a24afdf_Out_1, _ProjectionParams.z, _Multiply_619704251bdd44e6a8e9f02add36789c_Out_2);
            float4 _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0 = IN.ScreenPosition;
            float _Split_eb526920998f41cd825cbe42160042f5_R_1 = _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0[0];
            float _Split_eb526920998f41cd825cbe42160042f5_G_2 = _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0[1];
            float _Split_eb526920998f41cd825cbe42160042f5_B_3 = _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0[2];
            float _Split_eb526920998f41cd825cbe42160042f5_A_4 = _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0[3];
            float _Property_f4dad9c86f154090a77929fc0594d2eb_Out_0 = Vector1_f108b0f6f7ad4a0fa7970936cde8c93a;
            float _Add_1d0b28a6a0fe41b9aea6de0b9a290419_Out_2;
            Unity_Add_float(_Split_eb526920998f41cd825cbe42160042f5_A_4, _Property_f4dad9c86f154090a77929fc0594d2eb_Out_0, _Add_1d0b28a6a0fe41b9aea6de0b9a290419_Out_2);
            float _Subtract_c310e84b25994cf7969fb6aec3c12631_Out_2;
            Unity_Subtract_float(_Multiply_619704251bdd44e6a8e9f02add36789c_Out_2, _Add_1d0b28a6a0fe41b9aea6de0b9a290419_Out_2, _Subtract_c310e84b25994cf7969fb6aec3c12631_Out_2);
            float _Property_e2cb78357bf54371b95b04624c624355_Out_0 = Vector1_77a8669616464cc68eec17e9163052aa;
            float _Multiply_77d88fee04a2411ebf64a9f3cf93ee09_Out_2;
            Unity_Multiply_float_float(_Subtract_c310e84b25994cf7969fb6aec3c12631_Out_2, _Property_e2cb78357bf54371b95b04624c624355_Out_0, _Multiply_77d88fee04a2411ebf64a9f3cf93ee09_Out_2);
            float _Clamp_5c303e7a7ab74c80819cff967500a688_Out_3;
            Unity_Clamp_float(_Multiply_77d88fee04a2411ebf64a9f3cf93ee09_Out_2, 0, 1, _Clamp_5c303e7a7ab74c80819cff967500a688_Out_3);
            float4 _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3;
            Unity_Lerp_float4(_Lerp_c2c00306fc734b0c8dee546205970ae6_Out_3, _Lerp_25807026701046b7a4a6abcec2069726_Out_3, (_Clamp_5c303e7a7ab74c80819cff967500a688_Out_3.xxxx), _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3);
            UnityTexture2D _Property_691307347e93408bb228020d56a4f64e_Out_0 = UnityBuildTexture2DStructNoScale(Texture2D_2d2e087224e24282b84a086f3316e6e8);
            float4 _SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0 = SAMPLE_TEXTURE2D(_Property_691307347e93408bb228020d56a4f64e_Out_0.tex, _Property_691307347e93408bb228020d56a4f64e_Out_0.samplerstate, _Property_691307347e93408bb228020d56a4f64e_Out_0.GetTransformedUV(IN.MainNormal));
            _SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0);
            float _SampleTexture2D_3802527e187e464aa45999485a38f24f_R_4 = _SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0.r;
            float _SampleTexture2D_3802527e187e464aa45999485a38f24f_G_5 = _SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0.g;
            float _SampleTexture2D_3802527e187e464aa45999485a38f24f_B_6 = _SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0.b;
            float _SampleTexture2D_3802527e187e464aa45999485a38f24f_A_7 = _SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0.a;
            UnityTexture2D _Property_162be1870c564d31abda704370ecd112_Out_0 = UnityBuildTexture2DStructNoScale(Texture2D_21a78e051aa84ab49c73d2364e78102f);
            float4 _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0 = SAMPLE_TEXTURE2D(_Property_162be1870c564d31abda704370ecd112_Out_0.tex, _Property_162be1870c564d31abda704370ecd112_Out_0.samplerstate, _Property_162be1870c564d31abda704370ecd112_Out_0.GetTransformedUV(IN.SecondNormal));
            _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0);
            float _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_R_4 = _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0.r;
            float _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_G_5 = _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0.g;
            float _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_B_6 = _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0.b;
            float _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_A_7 = _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0.a;
            float4 _Add_357900c2d36f40c0b7995aceda820c48_Out_2;
            Unity_Add_float4(_SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0, _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0, _Add_357900c2d36f40c0b7995aceda820c48_Out_2);
            float _Property_bcb4a350b8234af79860039f232f70bb_Out_0 = Vector1_0360d732cbbf426e841ca433b0e337aa;
            float3 _NormalStrength_353fbbdfa63c4bf1a26d328b90d65d75_Out_2;
            Unity_NormalStrength_float((_Add_357900c2d36f40c0b7995aceda820c48_Out_2.xyz), _Property_bcb4a350b8234af79860039f232f70bb_Out_0, _NormalStrength_353fbbdfa63c4bf1a26d328b90d65d75_Out_2);
            float _Property_435f8911f9614444bccaa1b491910830_Out_0 = _RefractionDistrotion;
            float3 _NormalStrength_c661b7411e0343adbe9cd03e17ec5587_Out_2;
            Unity_NormalStrength_float(_NormalStrength_353fbbdfa63c4bf1a26d328b90d65d75_Out_2, _Property_435f8911f9614444bccaa1b491910830_Out_0, _NormalStrength_c661b7411e0343adbe9cd03e17ec5587_Out_2);
            float4 _ScreenPosition_8195cd06776241d5b37929c91c6dad48_Out_0 = float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0);
            float3 _Add_b257228ea21d4b4d977a6133326b7e06_Out_2;
            Unity_Add_float3(_NormalStrength_c661b7411e0343adbe9cd03e17ec5587_Out_2, (_ScreenPosition_8195cd06776241d5b37929c91c6dad48_Out_0.xyz), _Add_b257228ea21d4b4d977a6133326b7e06_Out_2);
            float3 _SceneColor_2c332a05662541f2bba2d1b5eeb47bd2_Out_1;
            Unity_SceneColor_float((float4(_Add_b257228ea21d4b4d977a6133326b7e06_Out_2, 1.0)), _SceneColor_2c332a05662541f2bba2d1b5eeb47bd2_Out_1);
            UnityTexture2D _Property_c55f1526f461489aa2011515ec7da3a3_Out_0 = UnityBuildTexture2DStructNoScale(_PlanarReflectionTexture);
            float3 _Add_9cc9802b3ef24c21b8771b375a3bff42_Out_2;
            Unity_Add_float3(_NormalStrength_353fbbdfa63c4bf1a26d328b90d65d75_Out_2, (_Clamp_5c303e7a7ab74c80819cff967500a688_Out_3.xxx), _Add_9cc9802b3ef24c21b8771b375a3bff42_Out_2);
            float3 _NormalStrength_6161489259bb4747ba0928987b51a0ea_Out_2;
            Unity_NormalStrength_float(_Add_9cc9802b3ef24c21b8771b375a3bff42_Out_2, _Property_435f8911f9614444bccaa1b491910830_Out_0, _NormalStrength_6161489259bb4747ba0928987b51a0ea_Out_2);
            float3 _Add_51f05a9faaf74e72812fae8a48ed882c_Out_2;
            Unity_Add_float3((_ScreenPosition_8195cd06776241d5b37929c91c6dad48_Out_0.xyz), _NormalStrength_6161489259bb4747ba0928987b51a0ea_Out_2, _Add_51f05a9faaf74e72812fae8a48ed882c_Out_2);
            float4 _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_RGBA_0 = SAMPLE_TEXTURE2D(_Property_c55f1526f461489aa2011515ec7da3a3_Out_0.tex, _Property_c55f1526f461489aa2011515ec7da3a3_Out_0.samplerstate, _Property_c55f1526f461489aa2011515ec7da3a3_Out_0.GetTransformedUV((_Add_51f05a9faaf74e72812fae8a48ed882c_Out_2.xy)));
            float _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_R_4 = _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_RGBA_0.r;
            float _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_G_5 = _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_RGBA_0.g;
            float _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_B_6 = _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_RGBA_0.b;
            float _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_A_7 = _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_RGBA_0.a;
            float3 _Lerp_6bca2423774749ccb6b3d02c089ca6aa_Out_3;
            Unity_Lerp_float3(_SceneColor_2c332a05662541f2bba2d1b5eeb47bd2_Out_1, (_SampleTexture2D_60a5b90e4760409a9760488b39b95feb_RGBA_0.xyz), (_Clamp_5c303e7a7ab74c80819cff967500a688_Out_3.xxx), _Lerp_6bca2423774749ccb6b3d02c089ca6aa_Out_3);
            float _Property_4267d14b41a64c8faa1146ffbcfe3618_Out_0 = _Relection_Strength;
            float3 _Blend_1d413404067041f1a38d59c008106e23_Out_2;
            Unity_Blend_Multiply_float3((_Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3.xyz), _Lerp_6bca2423774749ccb6b3d02c089ca6aa_Out_3, _Blend_1d413404067041f1a38d59c008106e23_Out_2, _Property_4267d14b41a64c8faa1146ffbcfe3618_Out_0);
            UnityTexture2D _Property_dff6df0bd4d4495f97a7a18e11ec195a_Out_0 = UnityBuildTexture2DStructNoScale(Texture2D_2d2e087224e24282b84a086f3316e6e8);
            float4 _SampleTexture2D_fd9ae2c1f81b405e9021849934e7146d_RGBA_0 = SAMPLE_TEXTURE2D(_Property_dff6df0bd4d4495f97a7a18e11ec195a_Out_0.tex, _Property_dff6df0bd4d4495f97a7a18e11ec195a_Out_0.samplerstate, _Property_dff6df0bd4d4495f97a7a18e11ec195a_Out_0.GetTransformedUV(IN.MainNormal));
            float _SampleTexture2D_fd9ae2c1f81b405e9021849934e7146d_R_4 = _SampleTexture2D_fd9ae2c1f81b405e9021849934e7146d_RGBA_0.r;
            float _SampleTexture2D_fd9ae2c1f81b405e9021849934e7146d_G_5 = _SampleTexture2D_fd9ae2c1f81b405e9021849934e7146d_RGBA_0.g;
            float _SampleTexture2D_fd9ae2c1f81b405e9021849934e7146d_B_6 = _SampleTexture2D_fd9ae2c1f81b405e9021849934e7146d_RGBA_0.b;
            float _SampleTexture2D_fd9ae2c1f81b405e9021849934e7146d_A_7 = _SampleTexture2D_fd9ae2c1f81b405e9021849934e7146d_RGBA_0.a;
            UnityTexture2D _Property_f0238f5adf1d400c886a5a72ea8e3800_Out_0 = UnityBuildTexture2DStructNoScale(Texture2D_2d2e087224e24282b84a086f3316e6e8);
            float4 _SampleTexture2D_b5339f18d32e4578951e0bd01553c041_RGBA_0 = SAMPLE_TEXTURE2D(_Property_f0238f5adf1d400c886a5a72ea8e3800_Out_0.tex, _Property_f0238f5adf1d400c886a5a72ea8e3800_Out_0.samplerstate, _Property_f0238f5adf1d400c886a5a72ea8e3800_Out_0.GetTransformedUV(IN.SecondNormal));
            float _SampleTexture2D_b5339f18d32e4578951e0bd01553c041_R_4 = _SampleTexture2D_b5339f18d32e4578951e0bd01553c041_RGBA_0.r;
            float _SampleTexture2D_b5339f18d32e4578951e0bd01553c041_G_5 = _SampleTexture2D_b5339f18d32e4578951e0bd01553c041_RGBA_0.g;
            float _SampleTexture2D_b5339f18d32e4578951e0bd01553c041_B_6 = _SampleTexture2D_b5339f18d32e4578951e0bd01553c041_RGBA_0.b;
            float _SampleTexture2D_b5339f18d32e4578951e0bd01553c041_A_7 = _SampleTexture2D_b5339f18d32e4578951e0bd01553c041_RGBA_0.a;
            float4 _Add_f4d1aaeeebe741bfac01df2cb63237d2_Out_2;
            Unity_Add_float4(_SampleTexture2D_fd9ae2c1f81b405e9021849934e7146d_RGBA_0, _SampleTexture2D_b5339f18d32e4578951e0bd01553c041_RGBA_0, _Add_f4d1aaeeebe741bfac01df2cb63237d2_Out_2);
            float _Property_94bcaaa57baf401a892936e8d1121760_Out_0 = _Layer1_Scale;
            float _ColorMask_3b67330abbfa4d5da09be858fde593ec_Out_3;
            Unity_ColorMask_float((_Add_f4d1aaeeebe741bfac01df2cb63237d2_Out_2.xyz), IsGammaSpace() ? float3(1, 1, 1) : SRGBToLinear(float3(1, 1, 1)), _Property_94bcaaa57baf401a892936e8d1121760_Out_0, _ColorMask_3b67330abbfa4d5da09be858fde593ec_Out_3, 0.4);
            UnityTexture2D _Property_edbfda5e1a564ea2aad094a54bb3b007_Out_0 = UnityBuildTexture2DStructNoScale(Texture2D_d65eb6e07c30447ca446c38272609586);
            float4 _SampleTexture2D_7464425046b24f39b9304827ccb6101e_RGBA_0 = SAMPLE_TEXTURE2D(_Property_edbfda5e1a564ea2aad094a54bb3b007_Out_0.tex, _Property_edbfda5e1a564ea2aad094a54bb3b007_Out_0.samplerstate, _Property_edbfda5e1a564ea2aad094a54bb3b007_Out_0.GetTransformedUV(IN.FoamDirection1));
            float _SampleTexture2D_7464425046b24f39b9304827ccb6101e_R_4 = _SampleTexture2D_7464425046b24f39b9304827ccb6101e_RGBA_0.r;
            float _SampleTexture2D_7464425046b24f39b9304827ccb6101e_G_5 = _SampleTexture2D_7464425046b24f39b9304827ccb6101e_RGBA_0.g;
            float _SampleTexture2D_7464425046b24f39b9304827ccb6101e_B_6 = _SampleTexture2D_7464425046b24f39b9304827ccb6101e_RGBA_0.b;
            float _SampleTexture2D_7464425046b24f39b9304827ccb6101e_A_7 = _SampleTexture2D_7464425046b24f39b9304827ccb6101e_RGBA_0.a;
            float4 _Property_05ee1312567a419ea766bcaa855dc2ed_Out_0 = Color_6e3aa9f38d68448bb94d493ef4e3c30a;
            float4 _Multiply_75f2ec69c46847e5aaea2cd6420daa9e_Out_2;
            Unity_Multiply_float4_float4((_SampleTexture2D_7464425046b24f39b9304827ccb6101e_G_5.xxxx), _Property_05ee1312567a419ea766bcaa855dc2ed_Out_0, _Multiply_75f2ec69c46847e5aaea2cd6420daa9e_Out_2);
            float4 _Multiply_e5480cb837904b4ab771dec3029ac8d6_Out_2;
            Unity_Multiply_float4_float4((_ColorMask_3b67330abbfa4d5da09be858fde593ec_Out_3.xxxx), _Multiply_75f2ec69c46847e5aaea2cd6420daa9e_Out_2, _Multiply_e5480cb837904b4ab771dec3029ac8d6_Out_2);
            float _Property_aff115291912400081bcc3de12f2f8ec_Out_0 = _Layer2_Scale;
            float _ColorMask_c2b65a71e09b4b4a97fc255b1947e69e_Out_3;
            Unity_ColorMask_float((_Add_f4d1aaeeebe741bfac01df2cb63237d2_Out_2.xyz), IsGammaSpace() ? float3(1, 1, 1) : SRGBToLinear(float3(1, 1, 1)), _Property_aff115291912400081bcc3de12f2f8ec_Out_0, _ColorMask_c2b65a71e09b4b4a97fc255b1947e69e_Out_3, 0.4);
            float4 _SampleTexture2D_4dcd9985d6b54ac3a3070127f41fef44_RGBA_0 = SAMPLE_TEXTURE2D(_Property_edbfda5e1a564ea2aad094a54bb3b007_Out_0.tex, _Property_edbfda5e1a564ea2aad094a54bb3b007_Out_0.samplerstate, _Property_edbfda5e1a564ea2aad094a54bb3b007_Out_0.GetTransformedUV(IN.FoamDirection2));
            float _SampleTexture2D_4dcd9985d6b54ac3a3070127f41fef44_R_4 = _SampleTexture2D_4dcd9985d6b54ac3a3070127f41fef44_RGBA_0.r;
            float _SampleTexture2D_4dcd9985d6b54ac3a3070127f41fef44_G_5 = _SampleTexture2D_4dcd9985d6b54ac3a3070127f41fef44_RGBA_0.g;
            float _SampleTexture2D_4dcd9985d6b54ac3a3070127f41fef44_B_6 = _SampleTexture2D_4dcd9985d6b54ac3a3070127f41fef44_RGBA_0.b;
            float _SampleTexture2D_4dcd9985d6b54ac3a3070127f41fef44_A_7 = _SampleTexture2D_4dcd9985d6b54ac3a3070127f41fef44_RGBA_0.a;
            float4 _Multiply_d1696f7e6e5a4cdcae3d545c0dab56c5_Out_2;
            Unity_Multiply_float4_float4(_Property_05ee1312567a419ea766bcaa855dc2ed_Out_0, (_SampleTexture2D_4dcd9985d6b54ac3a3070127f41fef44_B_6.xxxx), _Multiply_d1696f7e6e5a4cdcae3d545c0dab56c5_Out_2);
            float4 _Multiply_7ddead3a69614c469917ed7b9aafa900_Out_2;
            Unity_Multiply_float4_float4((_ColorMask_c2b65a71e09b4b4a97fc255b1947e69e_Out_3.xxxx), _Multiply_d1696f7e6e5a4cdcae3d545c0dab56c5_Out_2, _Multiply_7ddead3a69614c469917ed7b9aafa900_Out_2);
            float4 _Add_d1b55de8d8eb46d5be51b419333fbee1_Out_2;
            Unity_Add_float4(_Multiply_e5480cb837904b4ab771dec3029ac8d6_Out_2, _Multiply_7ddead3a69614c469917ed7b9aafa900_Out_2, _Add_d1b55de8d8eb46d5be51b419333fbee1_Out_2);
            float4 _Property_91c7296a1fd34a6ba4ba2db430b227cf_Out_0 = Color_6e3aa9f38d68448bb94d493ef4e3c30a;
            float _Property_25ca0be5c8024b6984b39cc03c10699e_Out_0 = Vector1_aace7401fb3a402e9f06de96963c9b84;
            float _Subtract_af5fef32a00b4cd4863e59c7a5aa9f5c_Out_2;
            Unity_Subtract_float(_Multiply_619704251bdd44e6a8e9f02add36789c_Out_2, _Split_eb526920998f41cd825cbe42160042f5_A_4, _Subtract_af5fef32a00b4cd4863e59c7a5aa9f5c_Out_2);
            float _Subtract_5cb3b9da51094bfc9691cff775ed046c_Out_2;
            Unity_Subtract_float(_Property_25ca0be5c8024b6984b39cc03c10699e_Out_0, _Subtract_af5fef32a00b4cd4863e59c7a5aa9f5c_Out_2, _Subtract_5cb3b9da51094bfc9691cff775ed046c_Out_2);
            float _Property_ddab7adb8fc8414e903ddbb8f8b183e2_Out_0 = Vector1_0d98869735ab4e73a0e4bb36589d00c0;
            float _Multiply_efbf135285134c28b8a80ff0e4ba3f17_Out_2;
            Unity_Multiply_float_float(_Subtract_5cb3b9da51094bfc9691cff775ed046c_Out_2, _Property_ddab7adb8fc8414e903ddbb8f8b183e2_Out_0, _Multiply_efbf135285134c28b8a80ff0e4ba3f17_Out_2);
            float4 _Multiply_92e7da0ce3c448e0a75776463e054f66_Out_2;
            Unity_Multiply_float4_float4(_Property_91c7296a1fd34a6ba4ba2db430b227cf_Out_0, (_Multiply_efbf135285134c28b8a80ff0e4ba3f17_Out_2.xxxx), _Multiply_92e7da0ce3c448e0a75776463e054f66_Out_2);
            UnityTexture2D _Property_2613ec34f9504d22aafecb7ad6480e1e_Out_0 = UnityBuildTexture2DStructNoScale(Texture2D_d65eb6e07c30447ca446c38272609586);
            float2 _Property_49ee0e056d6942968b9200a4a85c3251_Out_0 = Vector2_2832e3b0590c4ee98f806b14c0f54c5b;
            float2 _TilingAndOffset_b50bda6ad9b140f9b0ca863214f6b957_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Property_49ee0e056d6942968b9200a4a85c3251_Out_0, float2 (0.18, 0), _TilingAndOffset_b50bda6ad9b140f9b0ca863214f6b957_Out_3);
            float4 _SampleTexture2D_00f1f15016c649f0ae4e0c96597e573f_RGBA_0 = SAMPLE_TEXTURE2D(_Property_2613ec34f9504d22aafecb7ad6480e1e_Out_0.tex, _Property_2613ec34f9504d22aafecb7ad6480e1e_Out_0.samplerstate, _Property_2613ec34f9504d22aafecb7ad6480e1e_Out_0.GetTransformedUV(_TilingAndOffset_b50bda6ad9b140f9b0ca863214f6b957_Out_3));
            float _SampleTexture2D_00f1f15016c649f0ae4e0c96597e573f_R_4 = _SampleTexture2D_00f1f15016c649f0ae4e0c96597e573f_RGBA_0.r;
            float _SampleTexture2D_00f1f15016c649f0ae4e0c96597e573f_G_5 = _SampleTexture2D_00f1f15016c649f0ae4e0c96597e573f_RGBA_0.g;
            float _SampleTexture2D_00f1f15016c649f0ae4e0c96597e573f_B_6 = _SampleTexture2D_00f1f15016c649f0ae4e0c96597e573f_RGBA_0.b;
            float _SampleTexture2D_00f1f15016c649f0ae4e0c96597e573f_A_7 = _SampleTexture2D_00f1f15016c649f0ae4e0c96597e573f_RGBA_0.a;
            float4 _Multiply_4f081b87dfcb4a41bb7615b058040e89_Out_2;
            Unity_Multiply_float4_float4(_Multiply_92e7da0ce3c448e0a75776463e054f66_Out_2, (_SampleTexture2D_00f1f15016c649f0ae4e0c96597e573f_G_5.xxxx), _Multiply_4f081b87dfcb4a41bb7615b058040e89_Out_2);
            float4 _Clamp_3a0f28c23b344448ac636ad89dbdb3e7_Out_3;
            Unity_Clamp_float4(_Multiply_4f081b87dfcb4a41bb7615b058040e89_Out_2, float4(0, 0, 0, 0), float4(1, 1, 1, 1), _Clamp_3a0f28c23b344448ac636ad89dbdb3e7_Out_3);
            float4 _Add_fb079be2c07b4115bae3a3c384291108_Out_2;
            Unity_Add_float4(_Add_d1b55de8d8eb46d5be51b419333fbee1_Out_2, _Clamp_3a0f28c23b344448ac636ad89dbdb3e7_Out_3, _Add_fb079be2c07b4115bae3a3c384291108_Out_2);
            float _Property_c85200fdac2540b9b3e122c51e3ffcbb_Out_0 = Vector1_69bcaf9cf50f40a2bef27afe006bbc8f;
            float _Split_32fd3b93931741f5ba645cdab3f37d0f_R_1 = _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3[0];
            float _Split_32fd3b93931741f5ba645cdab3f37d0f_G_2 = _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3[1];
            float _Split_32fd3b93931741f5ba645cdab3f37d0f_B_3 = _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3[2];
            float _Split_32fd3b93931741f5ba645cdab3f37d0f_A_4 = _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3[3];
            surface.BaseColor = _Blend_1d413404067041f1a38d59c008106e23_Out_2;
            surface.NormalTS = _NormalStrength_353fbbdfa63c4bf1a26d328b90d65d75_Out_2;
            surface.Emission = (_Add_fb079be2c07b4115bae3a3c384291108_Out_2.xyz);
            surface.Metallic = 0;
            surface.Smoothness = _Property_c85200fdac2540b9b3e122c51e3ffcbb_Out_0;
            surface.Occlusion = 1;
            surface.Alpha = _Split_32fd3b93931741f5ba645cdab3f37d0f_A_4;
            surface.AlphaClipThreshold = 0;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
            output.AbsoluteWorldSpacePosition =                 GetAbsolutePositionWS(TransformObjectToWorld(input.positionOS));
            output.uv0 =                                        input.uv0;
            output.TimeParameters =                             _TimeParameters.xyz;
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            output.MainNormal = input.MainNormal;
        output.SecondNormal = input.SecondNormal;
        output.FoamDirection1 = input.FoamDirection1;
        output.FoamDirection2 = input.FoamDirection2;
        
        
        
            output.TangentSpaceNormal = float3(0.0f, 0.0f, 1.0f);
        
        
            output.WorldSpacePosition = input.positionWS;
            output.ScreenPosition = ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
            output.uv0 = input.texCoord0;
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/UnityGBuffer.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBRGBufferPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            Name "DepthNormals"
            Tags
            {
                "LightMode" = "DepthNormals"
            }
        
        // Render State
        Cull Back
        ZTest LEqual
        ZWrite On
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 4.5
        #pragma exclude_renderers gles gles3 glcore
        #pragma multi_compile_instancing
        #pragma multi_compile _ DOTS_INSTANCING_ON
        #pragma vertex vert
        #pragma fragment frag
        
        // DotsInstancingOptions: <None>
        // HybridV1InjectedBuiltinProperties: <None>
        
        // Keywords
        // PassKeywords: <None>
        // GraphKeywords: <None>
        
        // Defines
        
        #define _NORMALMAP 1
        #define _NORMAL_DROPOFF_TS 1
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define ATTRIBUTES_NEED_TEXCOORD1
        #define VARYINGS_NEED_POSITION_WS
        #define VARYINGS_NEED_NORMAL_WS
        #define VARYINGS_NEED_TANGENT_WS
        #define VARYINGS_NEED_TEXCOORD0
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_DEPTHNORMALS
        #define _ALPHATEST_ON 1
        #define REQUIRE_DEPTH_TEXTURE
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
             float4 uv1 : TEXCOORD1;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float3 positionWS;
             float3 normalWS;
             float4 tangentWS;
             float4 texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
             float2 MainNormal;
             float2 SecondNormal;
        };
        struct SurfaceDescriptionInputs
        {
             float3 TangentSpaceNormal;
             float3 WorldSpacePosition;
             float4 ScreenPosition;
             float4 uv0;
             float2 MainNormal;
             float2 SecondNormal;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
             float4 uv0;
             float3 TimeParameters;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float3 interp0 : INTERP0;
             float3 interp1 : INTERP1;
             float4 interp2 : INTERP2;
             float4 interp3 : INTERP3;
             float4 interp4 : INTERP4;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.positionWS;
            output.interp1.xyz =  input.normalWS;
            output.interp2.xyzw =  input.tangentWS;
            output.interp3.xyzw =  input.texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            output.interp4.xy =  input.MainNormal;
            output.interp4.zw =  input.SecondNormal;
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.positionWS = input.interp0.xyz;
            output.normalWS = input.interp1.xyz;
            output.tangentWS = input.interp2.xyzw;
            output.texCoord0 = input.interp3.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            output.MainNormal = input.interp4.xy;
            output.SecondNormal = input.interp4.zw;
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float4 _PlanarReflectionTexture_TexelSize;
        float Vector1_f108b0f6f7ad4a0fa7970936cde8c93a;
        float Vector1_77a8669616464cc68eec17e9163052aa;
        float4 Color_2bad1140d6ae465a8b096ead483f5370;
        float4 Color_b5081859698940efa07a6cc68ff92e70;
        float4 Color_1;
        float4 Texture2D_2d2e087224e24282b84a086f3316e6e8_TexelSize;
        float2 Vector2_c2fe4e7c2a7649b28d7ab078fdadda1c;
        float Vector1_7614a6098dec470e8a4e96a5c8551362;
        float4 Texture2D_21a78e051aa84ab49c73d2364e78102f_TexelSize;
        float2 Vector2_73fa27b3bcf64608a50eed7c1d0d3411;
        float Vector1_898460d8305d4dfe9af1298eb6f67082;
        float Vector1_0360d732cbbf426e841ca433b0e337aa;
        float Vector1_dcce861f82224ec1ac55aa94df3b3d12;
        float Vector1_3606b8114ded4a74a4e4834f8bf7dc12;
        float Vector1_69bcaf9cf50f40a2bef27afe006bbc8f;
        float4 Color_6e3aa9f38d68448bb94d493ef4e3c30a;
        float Vector1_0d98869735ab4e73a0e4bb36589d00c0;
        float Vector1_aace7401fb3a402e9f06de96963c9b84;
        float4 Texture2D_d65eb6e07c30447ca446c38272609586_TexelSize;
        float2 Vector2_2832e3b0590c4ee98f806b14c0f54c5b;
        float4 _Shallow_Water_Color_2;
        float2 _Panning;
        float _DistortionSpeed;
        float _DistortionIntensity;
        float2 _FoamNoiseTilling;
        float _DistortionScale;
        float _NoiseScale;
        float _Layer1_Scale;
        float _Layer2_Scale;
        float _RefractionDistrotion;
        float _Relection_Strength;
        CBUFFER_END
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_PlanarReflectionTexture);
        SAMPLER(sampler_PlanarReflectionTexture);
        TEXTURE2D(Texture2D_2d2e087224e24282b84a086f3316e6e8);
        SAMPLER(samplerTexture2D_2d2e087224e24282b84a086f3316e6e8);
        TEXTURE2D(Texture2D_21a78e051aa84ab49c73d2364e78102f);
        SAMPLER(samplerTexture2D_21a78e051aa84ab49c73d2364e78102f);
        TEXTURE2D(Texture2D_d65eb6e07c30447ca446c38272609586);
        SAMPLER(samplerTexture2D_d65eb6e07c30447ca446c38272609586);
        
        // Graph Includes
        // GraphIncludes: <None>
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        
        float2 Unity_GradientNoise_Dir_float(float2 p)
        {
            // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
            p = p % 289;
            // need full precision, otherwise half overflows when p > 1
            float x = float(34 * p.x + 1) * p.x % 289 + p.y;
            x = (34 * x + 1) * x % 289;
            x = frac(x / 41) * 2 - 1;
            return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
        }
        
        void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
        {
            float2 p = UV * Scale;
            float2 ip = floor(p);
            float2 fp = frac(p);
            float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
            float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
            float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
            float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
            fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
            Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }
        
        void Unity_Add_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A + B;
        }
        
        void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
        {
            Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
        }
        
        void Unity_Preview_float(float In, out float Out)
        {
            Out = In;
        }
        
        void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
        {
            Out = lerp(A, B, T);
        }
        
        void Unity_SceneDepth_Linear01_float(float4 UV, out float Out)
        {
            Out = Linear01Depth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }
        
        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
            float2 MainNormal;
            float2 SecondNormal;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            float _Property_8a79f817e59948938215b338bcdc46df_Out_0 = Vector1_898460d8305d4dfe9af1298eb6f67082;
            float _Multiply_ed606ef7153b456b854854134a8f65f9_Out_2;
            Unity_Multiply_float_float(_Property_8a79f817e59948938215b338bcdc46df_Out_0, 0.01, _Multiply_ed606ef7153b456b854854134a8f65f9_Out_2);
            float2 _Property_0264c1738ed14b318538f5f39eb56d07_Out_0 = Vector2_73fa27b3bcf64608a50eed7c1d0d3411;
            float _Divide_d29c49a16f234ef78eee8f12e556a643_Out_2;
            Unity_Divide_float(IN.TimeParameters.x, 5, _Divide_d29c49a16f234ef78eee8f12e556a643_Out_2);
            float _Multiply_5928ff83990b4a61bfdfa392f6154eda_Out_2;
            Unity_Multiply_float_float(_Divide_d29c49a16f234ef78eee8f12e556a643_Out_2, _Multiply_ed606ef7153b456b854854134a8f65f9_Out_2, _Multiply_5928ff83990b4a61bfdfa392f6154eda_Out_2);
            float2 _TilingAndOffset_08fa9dddbfc44f8b9e671e082ef10419_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Property_0264c1738ed14b318538f5f39eb56d07_Out_0, (_Multiply_5928ff83990b4a61bfdfa392f6154eda_Out_2.xx), _TilingAndOffset_08fa9dddbfc44f8b9e671e082ef10419_Out_3);
            float _Property_32d848f89d264e118a7bc7b7cbae9677_Out_0 = Vector1_7614a6098dec470e8a4e96a5c8551362;
            float _Multiply_1541a6ad358e4ea281033d8831f2ba13_Out_2;
            Unity_Multiply_float_float(_Property_32d848f89d264e118a7bc7b7cbae9677_Out_0, -0.01, _Multiply_1541a6ad358e4ea281033d8831f2ba13_Out_2);
            float _Multiply_edd1ffe542204260a884842fd7a18fc1_Out_2;
            Unity_Multiply_float_float(_Multiply_1541a6ad358e4ea281033d8831f2ba13_Out_2, _Divide_d29c49a16f234ef78eee8f12e556a643_Out_2, _Multiply_edd1ffe542204260a884842fd7a18fc1_Out_2);
            float2 _Property_123c8148386d41aa9d1698d86033f0b5_Out_0 = Vector2_c2fe4e7c2a7649b28d7ab078fdadda1c;
            float2 _TilingAndOffset_924ee153284a4d4abbd47514c96bb1ae_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Property_123c8148386d41aa9d1698d86033f0b5_Out_0, (_Multiply_edd1ffe542204260a884842fd7a18fc1_Out_2.xx), _TilingAndOffset_924ee153284a4d4abbd47514c96bb1ae_Out_3);
            float _Split_d8eed8fe26594972914c124586d98bbf_R_1 = IN.ObjectSpacePosition[0];
            float _Split_d8eed8fe26594972914c124586d98bbf_G_2 = IN.ObjectSpacePosition[1];
            float _Split_d8eed8fe26594972914c124586d98bbf_B_3 = IN.ObjectSpacePosition[2];
            float _Split_d8eed8fe26594972914c124586d98bbf_A_4 = 0;
            float _Property_762630e6999b4da0a14b2ccffa4209d8_Out_0 = Vector1_dcce861f82224ec1ac55aa94df3b3d12;
            float _Divide_df746930d1d841c09a66286a0a3543ae_Out_2;
            Unity_Divide_float(_Property_762630e6999b4da0a14b2ccffa4209d8_Out_0, 200, _Divide_df746930d1d841c09a66286a0a3543ae_Out_2);
            float _Property_d73cd49e4412457080da3ad6f38ac94b_Out_0 = Vector1_3606b8114ded4a74a4e4834f8bf7dc12;
            float _Divide_b14ec7aec4874b8ab4371962384288e5_Out_2;
            Unity_Divide_float(_Property_d73cd49e4412457080da3ad6f38ac94b_Out_0, 50, _Divide_b14ec7aec4874b8ab4371962384288e5_Out_2);
            float _Multiply_f97f597155bf4b59afa13426042ec0a0_Out_2;
            Unity_Multiply_float_float(IN.TimeParameters.x, _Divide_b14ec7aec4874b8ab4371962384288e5_Out_2, _Multiply_f97f597155bf4b59afa13426042ec0a0_Out_2);
            float2 _TilingAndOffset_ab2fed3c342049de89287a73af5f4dd1_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, (_Multiply_f97f597155bf4b59afa13426042ec0a0_Out_2.xx), float2 (0, 0), _TilingAndOffset_ab2fed3c342049de89287a73af5f4dd1_Out_3);
            float _GradientNoise_c349a7da229a42f6acfd0e9329f501a7_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_ab2fed3c342049de89287a73af5f4dd1_Out_3, 0.96, _GradientNoise_c349a7da229a42f6acfd0e9329f501a7_Out_2);
            float _Multiply_9460f57a023144a9ae646cb7ff3c8354_Out_2;
            Unity_Multiply_float_float(_Divide_df746930d1d841c09a66286a0a3543ae_Out_2, _GradientNoise_c349a7da229a42f6acfd0e9329f501a7_Out_2, _Multiply_9460f57a023144a9ae646cb7ff3c8354_Out_2);
            float _Add_5cf9a595f1104a0ba7d0c02acbf47625_Out_2;
            Unity_Add_float(_Split_d8eed8fe26594972914c124586d98bbf_G_2, _Multiply_9460f57a023144a9ae646cb7ff3c8354_Out_2, _Add_5cf9a595f1104a0ba7d0c02acbf47625_Out_2);
            float4 _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGBA_4;
            float3 _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGB_5;
            float2 _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RG_6;
            Unity_Combine_float(_Split_d8eed8fe26594972914c124586d98bbf_R_1, _Add_5cf9a595f1104a0ba7d0c02acbf47625_Out_2, _Split_d8eed8fe26594972914c124586d98bbf_B_3, 0, _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGBA_4, _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGB_5, _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RG_6);
            description.Position = _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGB_5;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            description.MainNormal = _TilingAndOffset_924ee153284a4d4abbd47514c96bb1ae_Out_3;
            description.SecondNormal = _TilingAndOffset_08fa9dddbfc44f8b9e671e082ef10419_Out_3;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        output.MainNormal = input.MainNormal;
        output.SecondNormal = input.SecondNormal;
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float3 NormalTS;
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            UnityTexture2D _Property_691307347e93408bb228020d56a4f64e_Out_0 = UnityBuildTexture2DStructNoScale(Texture2D_2d2e087224e24282b84a086f3316e6e8);
            float4 _SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0 = SAMPLE_TEXTURE2D(_Property_691307347e93408bb228020d56a4f64e_Out_0.tex, _Property_691307347e93408bb228020d56a4f64e_Out_0.samplerstate, _Property_691307347e93408bb228020d56a4f64e_Out_0.GetTransformedUV(IN.MainNormal));
            _SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0);
            float _SampleTexture2D_3802527e187e464aa45999485a38f24f_R_4 = _SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0.r;
            float _SampleTexture2D_3802527e187e464aa45999485a38f24f_G_5 = _SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0.g;
            float _SampleTexture2D_3802527e187e464aa45999485a38f24f_B_6 = _SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0.b;
            float _SampleTexture2D_3802527e187e464aa45999485a38f24f_A_7 = _SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0.a;
            UnityTexture2D _Property_162be1870c564d31abda704370ecd112_Out_0 = UnityBuildTexture2DStructNoScale(Texture2D_21a78e051aa84ab49c73d2364e78102f);
            float4 _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0 = SAMPLE_TEXTURE2D(_Property_162be1870c564d31abda704370ecd112_Out_0.tex, _Property_162be1870c564d31abda704370ecd112_Out_0.samplerstate, _Property_162be1870c564d31abda704370ecd112_Out_0.GetTransformedUV(IN.SecondNormal));
            _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0);
            float _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_R_4 = _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0.r;
            float _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_G_5 = _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0.g;
            float _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_B_6 = _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0.b;
            float _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_A_7 = _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0.a;
            float4 _Add_357900c2d36f40c0b7995aceda820c48_Out_2;
            Unity_Add_float4(_SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0, _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0, _Add_357900c2d36f40c0b7995aceda820c48_Out_2);
            float _Property_bcb4a350b8234af79860039f232f70bb_Out_0 = Vector1_0360d732cbbf426e841ca433b0e337aa;
            float3 _NormalStrength_353fbbdfa63c4bf1a26d328b90d65d75_Out_2;
            Unity_NormalStrength_float((_Add_357900c2d36f40c0b7995aceda820c48_Out_2.xyz), _Property_bcb4a350b8234af79860039f232f70bb_Out_0, _NormalStrength_353fbbdfa63c4bf1a26d328b90d65d75_Out_2);
            float4 _Property_53dfc4b4cafc4a9496bd9fde6989ee8f_Out_0 = Color_b5081859698940efa07a6cc68ff92e70;
            float4 _Property_601193b6811a41eeb79befed4e93080a_Out_0 = _Shallow_Water_Color_2;
            float4 _UV_0459ed23840544d4943e249e6bf3def0_Out_0 = IN.uv0;
            float _Split_95c75a1ea7ee4dd7906396bff762bd25_R_1 = _UV_0459ed23840544d4943e249e6bf3def0_Out_0[0];
            float _Split_95c75a1ea7ee4dd7906396bff762bd25_G_2 = _UV_0459ed23840544d4943e249e6bf3def0_Out_0[1];
            float _Split_95c75a1ea7ee4dd7906396bff762bd25_B_3 = _UV_0459ed23840544d4943e249e6bf3def0_Out_0[2];
            float _Split_95c75a1ea7ee4dd7906396bff762bd25_A_4 = _UV_0459ed23840544d4943e249e6bf3def0_Out_0[3];
            float _Preview_0af5c98f89c44402ab2012c583d6f212_Out_1;
            Unity_Preview_float(_Split_95c75a1ea7ee4dd7906396bff762bd25_G_2, _Preview_0af5c98f89c44402ab2012c583d6f212_Out_1);
            float4 _Lerp_c2c00306fc734b0c8dee546205970ae6_Out_3;
            Unity_Lerp_float4(_Property_53dfc4b4cafc4a9496bd9fde6989ee8f_Out_0, _Property_601193b6811a41eeb79befed4e93080a_Out_0, (_Preview_0af5c98f89c44402ab2012c583d6f212_Out_1.xxxx), _Lerp_c2c00306fc734b0c8dee546205970ae6_Out_3);
            float4 _Property_72f89d8f335a4977a093f3bae7ef5ea1_Out_0 = Color_2bad1140d6ae465a8b096ead483f5370;
            float4 _Property_8d638ca6b7cc402595ddc523b14de263_Out_0 = Color_1;
            float4 _Lerp_25807026701046b7a4a6abcec2069726_Out_3;
            Unity_Lerp_float4(_Property_72f89d8f335a4977a093f3bae7ef5ea1_Out_0, _Property_8d638ca6b7cc402595ddc523b14de263_Out_0, (_Preview_0af5c98f89c44402ab2012c583d6f212_Out_1.xxxx), _Lerp_25807026701046b7a4a6abcec2069726_Out_3);
            float _SceneDepth_91aa5f89e7564cb2ac5171231a24afdf_Out_1;
            Unity_SceneDepth_Linear01_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_91aa5f89e7564cb2ac5171231a24afdf_Out_1);
            float _Multiply_619704251bdd44e6a8e9f02add36789c_Out_2;
            Unity_Multiply_float_float(_SceneDepth_91aa5f89e7564cb2ac5171231a24afdf_Out_1, _ProjectionParams.z, _Multiply_619704251bdd44e6a8e9f02add36789c_Out_2);
            float4 _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0 = IN.ScreenPosition;
            float _Split_eb526920998f41cd825cbe42160042f5_R_1 = _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0[0];
            float _Split_eb526920998f41cd825cbe42160042f5_G_2 = _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0[1];
            float _Split_eb526920998f41cd825cbe42160042f5_B_3 = _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0[2];
            float _Split_eb526920998f41cd825cbe42160042f5_A_4 = _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0[3];
            float _Property_f4dad9c86f154090a77929fc0594d2eb_Out_0 = Vector1_f108b0f6f7ad4a0fa7970936cde8c93a;
            float _Add_1d0b28a6a0fe41b9aea6de0b9a290419_Out_2;
            Unity_Add_float(_Split_eb526920998f41cd825cbe42160042f5_A_4, _Property_f4dad9c86f154090a77929fc0594d2eb_Out_0, _Add_1d0b28a6a0fe41b9aea6de0b9a290419_Out_2);
            float _Subtract_c310e84b25994cf7969fb6aec3c12631_Out_2;
            Unity_Subtract_float(_Multiply_619704251bdd44e6a8e9f02add36789c_Out_2, _Add_1d0b28a6a0fe41b9aea6de0b9a290419_Out_2, _Subtract_c310e84b25994cf7969fb6aec3c12631_Out_2);
            float _Property_e2cb78357bf54371b95b04624c624355_Out_0 = Vector1_77a8669616464cc68eec17e9163052aa;
            float _Multiply_77d88fee04a2411ebf64a9f3cf93ee09_Out_2;
            Unity_Multiply_float_float(_Subtract_c310e84b25994cf7969fb6aec3c12631_Out_2, _Property_e2cb78357bf54371b95b04624c624355_Out_0, _Multiply_77d88fee04a2411ebf64a9f3cf93ee09_Out_2);
            float _Clamp_5c303e7a7ab74c80819cff967500a688_Out_3;
            Unity_Clamp_float(_Multiply_77d88fee04a2411ebf64a9f3cf93ee09_Out_2, 0, 1, _Clamp_5c303e7a7ab74c80819cff967500a688_Out_3);
            float4 _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3;
            Unity_Lerp_float4(_Lerp_c2c00306fc734b0c8dee546205970ae6_Out_3, _Lerp_25807026701046b7a4a6abcec2069726_Out_3, (_Clamp_5c303e7a7ab74c80819cff967500a688_Out_3.xxxx), _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3);
            float _Split_32fd3b93931741f5ba645cdab3f37d0f_R_1 = _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3[0];
            float _Split_32fd3b93931741f5ba645cdab3f37d0f_G_2 = _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3[1];
            float _Split_32fd3b93931741f5ba645cdab3f37d0f_B_3 = _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3[2];
            float _Split_32fd3b93931741f5ba645cdab3f37d0f_A_4 = _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3[3];
            surface.NormalTS = _NormalStrength_353fbbdfa63c4bf1a26d328b90d65d75_Out_2;
            surface.Alpha = _Split_32fd3b93931741f5ba645cdab3f37d0f_A_4;
            surface.AlphaClipThreshold = 0;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
            output.uv0 =                                        input.uv0;
            output.TimeParameters =                             _TimeParameters.xyz;
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            output.MainNormal = input.MainNormal;
        output.SecondNormal = input.SecondNormal;
        
        
        
            output.TangentSpaceNormal = float3(0.0f, 0.0f, 1.0f);
        
        
            output.WorldSpacePosition = input.positionWS;
            output.ScreenPosition = ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
            output.uv0 = input.texCoord0;
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/DepthNormalsOnlyPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            Name "Meta"
            Tags
            {
                "LightMode" = "Meta"
            }
        
        // Render State
        Cull Off
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 4.5
        #pragma exclude_renderers gles gles3 glcore
        #pragma vertex vert
        #pragma fragment frag
        
        // DotsInstancingOptions: <None>
        // HybridV1InjectedBuiltinProperties: <None>
        
        // Keywords
        #pragma shader_feature _ EDITOR_VISUALIZATION
        // GraphKeywords: <None>
        
        // Defines
        
        #define _NORMALMAP 1
        #define _NORMAL_DROPOFF_TS 1
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define ATTRIBUTES_NEED_TEXCOORD1
        #define ATTRIBUTES_NEED_TEXCOORD2
        #define VARYINGS_NEED_POSITION_WS
        #define VARYINGS_NEED_TEXCOORD0
        #define VARYINGS_NEED_TEXCOORD1
        #define VARYINGS_NEED_TEXCOORD2
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_META
        #define _FOG_FRAGMENT 1
        #define _ALPHATEST_ON 1
        #define REQUIRE_DEPTH_TEXTURE
        #define REQUIRE_OPAQUE_TEXTURE
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/MetaInput.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
             float4 uv1 : TEXCOORD1;
             float4 uv2 : TEXCOORD2;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float3 positionWS;
             float4 texCoord0;
             float4 texCoord1;
             float4 texCoord2;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
             float2 MainNormal;
             float2 SecondNormal;
             float2 FoamDirection1;
             float2 FoamDirection2;
        };
        struct SurfaceDescriptionInputs
        {
             float3 WorldSpacePosition;
             float4 ScreenPosition;
             float4 uv0;
             float2 MainNormal;
             float2 SecondNormal;
             float2 FoamDirection1;
             float2 FoamDirection2;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
             float3 AbsoluteWorldSpacePosition;
             float4 uv0;
             float3 TimeParameters;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float3 interp0 : INTERP0;
             float4 interp1 : INTERP1;
             float4 interp2 : INTERP2;
             float4 interp3 : INTERP3;
             float4 interp4 : INTERP4;
             float4 interp5 : INTERP5;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.positionWS;
            output.interp1.xyzw =  input.texCoord0;
            output.interp2.xyzw =  input.texCoord1;
            output.interp3.xyzw =  input.texCoord2;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            output.interp4.xy =  input.MainNormal;
            output.interp4.zw =  input.SecondNormal;
            output.interp5.xy =  input.FoamDirection1;
            output.interp5.zw =  input.FoamDirection2;
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.positionWS = input.interp0.xyz;
            output.texCoord0 = input.interp1.xyzw;
            output.texCoord1 = input.interp2.xyzw;
            output.texCoord2 = input.interp3.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            output.MainNormal = input.interp4.xy;
            output.SecondNormal = input.interp4.zw;
            output.FoamDirection1 = input.interp5.xy;
            output.FoamDirection2 = input.interp5.zw;
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float4 _PlanarReflectionTexture_TexelSize;
        float Vector1_f108b0f6f7ad4a0fa7970936cde8c93a;
        float Vector1_77a8669616464cc68eec17e9163052aa;
        float4 Color_2bad1140d6ae465a8b096ead483f5370;
        float4 Color_b5081859698940efa07a6cc68ff92e70;
        float4 Color_1;
        float4 Texture2D_2d2e087224e24282b84a086f3316e6e8_TexelSize;
        float2 Vector2_c2fe4e7c2a7649b28d7ab078fdadda1c;
        float Vector1_7614a6098dec470e8a4e96a5c8551362;
        float4 Texture2D_21a78e051aa84ab49c73d2364e78102f_TexelSize;
        float2 Vector2_73fa27b3bcf64608a50eed7c1d0d3411;
        float Vector1_898460d8305d4dfe9af1298eb6f67082;
        float Vector1_0360d732cbbf426e841ca433b0e337aa;
        float Vector1_dcce861f82224ec1ac55aa94df3b3d12;
        float Vector1_3606b8114ded4a74a4e4834f8bf7dc12;
        float Vector1_69bcaf9cf50f40a2bef27afe006bbc8f;
        float4 Color_6e3aa9f38d68448bb94d493ef4e3c30a;
        float Vector1_0d98869735ab4e73a0e4bb36589d00c0;
        float Vector1_aace7401fb3a402e9f06de96963c9b84;
        float4 Texture2D_d65eb6e07c30447ca446c38272609586_TexelSize;
        float2 Vector2_2832e3b0590c4ee98f806b14c0f54c5b;
        float4 _Shallow_Water_Color_2;
        float2 _Panning;
        float _DistortionSpeed;
        float _DistortionIntensity;
        float2 _FoamNoiseTilling;
        float _DistortionScale;
        float _NoiseScale;
        float _Layer1_Scale;
        float _Layer2_Scale;
        float _RefractionDistrotion;
        float _Relection_Strength;
        CBUFFER_END
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_PlanarReflectionTexture);
        SAMPLER(sampler_PlanarReflectionTexture);
        TEXTURE2D(Texture2D_2d2e087224e24282b84a086f3316e6e8);
        SAMPLER(samplerTexture2D_2d2e087224e24282b84a086f3316e6e8);
        TEXTURE2D(Texture2D_21a78e051aa84ab49c73d2364e78102f);
        SAMPLER(samplerTexture2D_21a78e051aa84ab49c73d2364e78102f);
        TEXTURE2D(Texture2D_d65eb6e07c30447ca446c38272609586);
        SAMPLER(samplerTexture2D_d65eb6e07c30447ca446c38272609586);
        
        // Graph Includes
        // GraphIncludes: <None>
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        
        inline float Unity_SimpleNoise_RandomValue_float (float2 uv)
        {
            float angle = dot(uv, float2(12.9898, 78.233));
            #if defined(SHADER_API_MOBILE) && (defined(SHADER_API_GLES) || defined(SHADER_API_GLES3) || defined(SHADER_API_VULKAN))
                // 'sin()' has bad precision on Mali GPUs for inputs > 10000
                angle = fmod(angle, TWO_PI); // Avoid large inputs to sin()
            #endif
            return frac(sin(angle)*43758.5453);
        }
        
        inline float Unity_SimpleNnoise_Interpolate_float (float a, float b, float t)
        {
            return (1.0-t)*a + (t*b);
        }
        
        
        inline float Unity_SimpleNoise_ValueNoise_float (float2 uv)
        {
            float2 i = floor(uv);
            float2 f = frac(uv);
            f = f * f * (3.0 - 2.0 * f);
        
            uv = abs(frac(uv) - 0.5);
            float2 c0 = i + float2(0.0, 0.0);
            float2 c1 = i + float2(1.0, 0.0);
            float2 c2 = i + float2(0.0, 1.0);
            float2 c3 = i + float2(1.0, 1.0);
            float r0 = Unity_SimpleNoise_RandomValue_float(c0);
            float r1 = Unity_SimpleNoise_RandomValue_float(c1);
            float r2 = Unity_SimpleNoise_RandomValue_float(c2);
            float r3 = Unity_SimpleNoise_RandomValue_float(c3);
        
            float bottomOfGrid = Unity_SimpleNnoise_Interpolate_float(r0, r1, f.x);
            float topOfGrid = Unity_SimpleNnoise_Interpolate_float(r2, r3, f.x);
            float t = Unity_SimpleNnoise_Interpolate_float(bottomOfGrid, topOfGrid, f.y);
            return t;
        }
        void Unity_SimpleNoise_float(float2 UV, float Scale, out float Out)
        {
            float t = 0.0;
        
            float freq = pow(2.0, float(0));
            float amp = pow(0.5, float(3-0));
            t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale/freq, UV.y*Scale/freq))*amp;
        
            freq = pow(2.0, float(1));
            amp = pow(0.5, float(3-1));
            t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale/freq, UV.y*Scale/freq))*amp;
        
            freq = pow(2.0, float(2));
            amp = pow(0.5, float(3-2));
            t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale/freq, UV.y*Scale/freq))*amp;
        
            Out = t;
        }
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }
        
        void Unity_Multiply_float2_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A * B;
        }
        
        void Unity_Lerp_float2(float2 A, float2 B, float2 T, out float2 Out)
        {
            Out = lerp(A, B, T);
        }
        
        
        float2 Unity_GradientNoise_Dir_float(float2 p)
        {
            // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
            p = p % 289;
            // need full precision, otherwise half overflows when p > 1
            float x = float(34 * p.x + 1) * p.x % 289 + p.y;
            x = (34 * x + 1) * x % 289;
            x = frac(x / 41) * 2 - 1;
            return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
        }
        
        void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
        {
            float2 p = UV * Scale;
            float2 ip = floor(p);
            float2 fp = frac(p);
            float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
            float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
            float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
            float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
            fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
            Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Preview_float(float In, out float Out)
        {
            Out = In;
        }
        
        void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
        {
            Out = lerp(A, B, T);
        }
        
        void Unity_SceneDepth_Linear01_float(float4 UV, out float Out)
        {
            Out = Linear01Depth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }
        
        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }
        
        void Unity_Add_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A + B;
        }
        
        void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
        {
            Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
        }
        
        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }
        
        void Unity_SceneColor_float(float4 UV, out float3 Out)
        {
            Out = SHADERGRAPH_SAMPLE_SCENE_COLOR(UV.xy);
        }
        
        void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
        {
            Out = lerp(A, B, T);
        }
        
        void Unity_Blend_Multiply_float3(float3 Base, float3 Blend, out float3 Out, float Opacity)
        {
            Out = Base * Blend;
            Out = lerp(Base, Out, Opacity);
        }
        
        void Unity_ColorMask_float(float3 In, float3 MaskColor, float Range, out float Out, float Fuzziness)
        {
            float Distance = distance(MaskColor, In);
            Out = saturate(1 - (Distance - Range) / max(Fuzziness, 1e-5));
        }
        
        void Unity_Multiply_float4_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }
        
        void Unity_Clamp_float4(float4 In, float4 Min, float4 Max, out float4 Out)
        {
            Out = clamp(In, Min, Max);
        }
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
            float2 MainNormal;
            float2 SecondNormal;
            float2 FoamDirection1;
            float2 FoamDirection2;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            float _Property_271cd524054a48d0ac03da3ed0e18981_Out_0 = _NoiseScale;
            float _Property_d6b17372f8e24d1ba887e19ca0b9b532_Out_0 = _DistortionSpeed;
            float _Multiply_6b5e1abaf00147a8a2bd61cb3a63ac2d_Out_2;
            Unity_Multiply_float_float(0.9, _Property_d6b17372f8e24d1ba887e19ca0b9b532_Out_0, _Multiply_6b5e1abaf00147a8a2bd61cb3a63ac2d_Out_2);
            float _Multiply_0b2927096f2b406eade60b0ff8497f06_Out_2;
            Unity_Multiply_float_float(_Multiply_6b5e1abaf00147a8a2bd61cb3a63ac2d_Out_2, IN.TimeParameters.x, _Multiply_0b2927096f2b406eade60b0ff8497f06_Out_2);
            float2 _TilingAndOffset_3ae4fb84d8a24ae6b255b068ec01f495_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, float2 (1, 1), (_Multiply_0b2927096f2b406eade60b0ff8497f06_Out_2.xx), _TilingAndOffset_3ae4fb84d8a24ae6b255b068ec01f495_Out_3);
            float _SimpleNoise_310007c52b3547759f3d9a40829d9fdb_Out_2;
            Unity_SimpleNoise_float(_TilingAndOffset_3ae4fb84d8a24ae6b255b068ec01f495_Out_3, _Property_271cd524054a48d0ac03da3ed0e18981_Out_0, _SimpleNoise_310007c52b3547759f3d9a40829d9fdb_Out_2);
            float2 _Property_caf806c45b8648239ed928655b2dc075_Out_0 = _FoamNoiseTilling;
            float _Property_83fd66d76a934370a36fc75a684ef06a_Out_0 = _DistortionIntensity;
            float _Property_31ef0e62fff04fde85a1f9ac39636e5c_Out_0 = _NoiseScale;
            float _Property_1df622d21af24ccca4f9f326808f58fc_Out_0 = _DistortionSpeed;
            float _Multiply_8c038a6c11994a53b09ad756f38d3c5d_Out_2;
            Unity_Multiply_float_float(-0.9, _Property_1df622d21af24ccca4f9f326808f58fc_Out_0, _Multiply_8c038a6c11994a53b09ad756f38d3c5d_Out_2);
            float _Multiply_c710fb8d99aa474cb13c0d65aa2a1829_Out_2;
            Unity_Multiply_float_float(_Multiply_8c038a6c11994a53b09ad756f38d3c5d_Out_2, IN.TimeParameters.x, _Multiply_c710fb8d99aa474cb13c0d65aa2a1829_Out_2);
            float2 _TilingAndOffset_b5b7efd61dd0407b81b2ec53772b278d_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, float2 (1, 1), (_Multiply_c710fb8d99aa474cb13c0d65aa2a1829_Out_2.xx), _TilingAndOffset_b5b7efd61dd0407b81b2ec53772b278d_Out_3);
            float _SimpleNoise_4e904d56e17345ff8f80d57968580a32_Out_2;
            Unity_SimpleNoise_float(_TilingAndOffset_b5b7efd61dd0407b81b2ec53772b278d_Out_3, _Property_31ef0e62fff04fde85a1f9ac39636e5c_Out_0, _SimpleNoise_4e904d56e17345ff8f80d57968580a32_Out_2);
            float _Divide_2d74bf9a40ba416f9b680ba114404dc2_Out_2;
            Unity_Divide_float(IN.TimeParameters.x, 6, _Divide_2d74bf9a40ba416f9b680ba114404dc2_Out_2);
            float2 _Property_702ff1c785d542499e4ead1def7e1418_Out_0 = _Panning;
            float _Split_252c3e0a27db4d66a7df034157244e21_R_1 = _Property_702ff1c785d542499e4ead1def7e1418_Out_0[0];
            float _Split_252c3e0a27db4d66a7df034157244e21_G_2 = _Property_702ff1c785d542499e4ead1def7e1418_Out_0[1];
            float _Split_252c3e0a27db4d66a7df034157244e21_B_3 = 0;
            float _Split_252c3e0a27db4d66a7df034157244e21_A_4 = 0;
            float _Multiply_e016b9a16b4e4abba2502adb5862e043_Out_2;
            Unity_Multiply_float_float(_Split_252c3e0a27db4d66a7df034157244e21_G_2, _Divide_2d74bf9a40ba416f9b680ba114404dc2_Out_2, _Multiply_e016b9a16b4e4abba2502adb5862e043_Out_2);
            float _Multiply_218b27dc95a243998b30f016e0d3988e_Out_2;
            Unity_Multiply_float_float(_Split_252c3e0a27db4d66a7df034157244e21_R_1, _Divide_2d74bf9a40ba416f9b680ba114404dc2_Out_2, _Multiply_218b27dc95a243998b30f016e0d3988e_Out_2);
            float4 _Combine_6ae549d623c54cce9850c0bc9b3405eb_RGBA_4;
            float3 _Combine_6ae549d623c54cce9850c0bc9b3405eb_RGB_5;
            float2 _Combine_6ae549d623c54cce9850c0bc9b3405eb_RG_6;
            Unity_Combine_float(_Multiply_218b27dc95a243998b30f016e0d3988e_Out_2, _Multiply_e016b9a16b4e4abba2502adb5862e043_Out_2, 0, 0, _Combine_6ae549d623c54cce9850c0bc9b3405eb_RGBA_4, _Combine_6ae549d623c54cce9850c0bc9b3405eb_RGB_5, _Combine_6ae549d623c54cce9850c0bc9b3405eb_RG_6);
            float _Float_f89ffb73213141f1aa48acbe034e5ea3_Out_0 = 0.02;
            float2 _Swizzle_d519ed834a284e518d347105c3a11492_Out_1 = IN.AbsoluteWorldSpacePosition.xz;
            float2 _Multiply_39c33974737143ae9f76cce56d3d33d2_Out_2;
            Unity_Multiply_float2_float2(_Swizzle_d519ed834a284e518d347105c3a11492_Out_1, (_Float_f89ffb73213141f1aa48acbe034e5ea3_Out_0.xx), _Multiply_39c33974737143ae9f76cce56d3d33d2_Out_2);
            float2 _TilingAndOffset_9f5c71641fa94a59a413d51e3a6aec3d_Out_3;
            Unity_TilingAndOffset_float(_Multiply_39c33974737143ae9f76cce56d3d33d2_Out_2, float2 (1, 1), _Combine_6ae549d623c54cce9850c0bc9b3405eb_RG_6, _TilingAndOffset_9f5c71641fa94a59a413d51e3a6aec3d_Out_3);
            float2 _Lerp_6ba3378c16cf44e49e4a44f6e2f26c65_Out_3;
            Unity_Lerp_float2(_TilingAndOffset_9f5c71641fa94a59a413d51e3a6aec3d_Out_3, (_SimpleNoise_310007c52b3547759f3d9a40829d9fdb_Out_2.xx), (_Property_83fd66d76a934370a36fc75a684ef06a_Out_0.xx), _Lerp_6ba3378c16cf44e49e4a44f6e2f26c65_Out_3);
            float2 _TilingAndOffset_c89d2fcde70d4d818249ebe200337480_Out_3;
            Unity_TilingAndOffset_float(_Lerp_6ba3378c16cf44e49e4a44f6e2f26c65_Out_3, _Property_caf806c45b8648239ed928655b2dc075_Out_0, float2 (0.81, 0), _TilingAndOffset_c89d2fcde70d4d818249ebe200337480_Out_3);
            float2 _Lerp_3759f9668f544adb8dd7eee5886abeb0_Out_3;
            Unity_Lerp_float2(_TilingAndOffset_9f5c71641fa94a59a413d51e3a6aec3d_Out_3, (_SimpleNoise_4e904d56e17345ff8f80d57968580a32_Out_2.xx), (_Property_83fd66d76a934370a36fc75a684ef06a_Out_0.xx), _Lerp_3759f9668f544adb8dd7eee5886abeb0_Out_3);
            float2 _TilingAndOffset_e2926df184da41caab0fcf14e34b81a7_Out_3;
            Unity_TilingAndOffset_float(_Lerp_3759f9668f544adb8dd7eee5886abeb0_Out_3, _Property_caf806c45b8648239ed928655b2dc075_Out_0, float2 (0.81, 0), _TilingAndOffset_e2926df184da41caab0fcf14e34b81a7_Out_3);
            float _Property_8a79f817e59948938215b338bcdc46df_Out_0 = Vector1_898460d8305d4dfe9af1298eb6f67082;
            float _Multiply_ed606ef7153b456b854854134a8f65f9_Out_2;
            Unity_Multiply_float_float(_Property_8a79f817e59948938215b338bcdc46df_Out_0, 0.01, _Multiply_ed606ef7153b456b854854134a8f65f9_Out_2);
            float2 _Property_0264c1738ed14b318538f5f39eb56d07_Out_0 = Vector2_73fa27b3bcf64608a50eed7c1d0d3411;
            float _Divide_d29c49a16f234ef78eee8f12e556a643_Out_2;
            Unity_Divide_float(IN.TimeParameters.x, 5, _Divide_d29c49a16f234ef78eee8f12e556a643_Out_2);
            float _Multiply_5928ff83990b4a61bfdfa392f6154eda_Out_2;
            Unity_Multiply_float_float(_Divide_d29c49a16f234ef78eee8f12e556a643_Out_2, _Multiply_ed606ef7153b456b854854134a8f65f9_Out_2, _Multiply_5928ff83990b4a61bfdfa392f6154eda_Out_2);
            float2 _TilingAndOffset_08fa9dddbfc44f8b9e671e082ef10419_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Property_0264c1738ed14b318538f5f39eb56d07_Out_0, (_Multiply_5928ff83990b4a61bfdfa392f6154eda_Out_2.xx), _TilingAndOffset_08fa9dddbfc44f8b9e671e082ef10419_Out_3);
            float _Property_32d848f89d264e118a7bc7b7cbae9677_Out_0 = Vector1_7614a6098dec470e8a4e96a5c8551362;
            float _Multiply_1541a6ad358e4ea281033d8831f2ba13_Out_2;
            Unity_Multiply_float_float(_Property_32d848f89d264e118a7bc7b7cbae9677_Out_0, -0.01, _Multiply_1541a6ad358e4ea281033d8831f2ba13_Out_2);
            float _Multiply_edd1ffe542204260a884842fd7a18fc1_Out_2;
            Unity_Multiply_float_float(_Multiply_1541a6ad358e4ea281033d8831f2ba13_Out_2, _Divide_d29c49a16f234ef78eee8f12e556a643_Out_2, _Multiply_edd1ffe542204260a884842fd7a18fc1_Out_2);
            float2 _Property_123c8148386d41aa9d1698d86033f0b5_Out_0 = Vector2_c2fe4e7c2a7649b28d7ab078fdadda1c;
            float2 _TilingAndOffset_924ee153284a4d4abbd47514c96bb1ae_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Property_123c8148386d41aa9d1698d86033f0b5_Out_0, (_Multiply_edd1ffe542204260a884842fd7a18fc1_Out_2.xx), _TilingAndOffset_924ee153284a4d4abbd47514c96bb1ae_Out_3);
            float _Split_d8eed8fe26594972914c124586d98bbf_R_1 = IN.ObjectSpacePosition[0];
            float _Split_d8eed8fe26594972914c124586d98bbf_G_2 = IN.ObjectSpacePosition[1];
            float _Split_d8eed8fe26594972914c124586d98bbf_B_3 = IN.ObjectSpacePosition[2];
            float _Split_d8eed8fe26594972914c124586d98bbf_A_4 = 0;
            float _Property_762630e6999b4da0a14b2ccffa4209d8_Out_0 = Vector1_dcce861f82224ec1ac55aa94df3b3d12;
            float _Divide_df746930d1d841c09a66286a0a3543ae_Out_2;
            Unity_Divide_float(_Property_762630e6999b4da0a14b2ccffa4209d8_Out_0, 200, _Divide_df746930d1d841c09a66286a0a3543ae_Out_2);
            float _Property_d73cd49e4412457080da3ad6f38ac94b_Out_0 = Vector1_3606b8114ded4a74a4e4834f8bf7dc12;
            float _Divide_b14ec7aec4874b8ab4371962384288e5_Out_2;
            Unity_Divide_float(_Property_d73cd49e4412457080da3ad6f38ac94b_Out_0, 50, _Divide_b14ec7aec4874b8ab4371962384288e5_Out_2);
            float _Multiply_f97f597155bf4b59afa13426042ec0a0_Out_2;
            Unity_Multiply_float_float(IN.TimeParameters.x, _Divide_b14ec7aec4874b8ab4371962384288e5_Out_2, _Multiply_f97f597155bf4b59afa13426042ec0a0_Out_2);
            float2 _TilingAndOffset_ab2fed3c342049de89287a73af5f4dd1_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, (_Multiply_f97f597155bf4b59afa13426042ec0a0_Out_2.xx), float2 (0, 0), _TilingAndOffset_ab2fed3c342049de89287a73af5f4dd1_Out_3);
            float _GradientNoise_c349a7da229a42f6acfd0e9329f501a7_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_ab2fed3c342049de89287a73af5f4dd1_Out_3, 0.96, _GradientNoise_c349a7da229a42f6acfd0e9329f501a7_Out_2);
            float _Multiply_9460f57a023144a9ae646cb7ff3c8354_Out_2;
            Unity_Multiply_float_float(_Divide_df746930d1d841c09a66286a0a3543ae_Out_2, _GradientNoise_c349a7da229a42f6acfd0e9329f501a7_Out_2, _Multiply_9460f57a023144a9ae646cb7ff3c8354_Out_2);
            float _Add_5cf9a595f1104a0ba7d0c02acbf47625_Out_2;
            Unity_Add_float(_Split_d8eed8fe26594972914c124586d98bbf_G_2, _Multiply_9460f57a023144a9ae646cb7ff3c8354_Out_2, _Add_5cf9a595f1104a0ba7d0c02acbf47625_Out_2);
            float4 _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGBA_4;
            float3 _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGB_5;
            float2 _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RG_6;
            Unity_Combine_float(_Split_d8eed8fe26594972914c124586d98bbf_R_1, _Add_5cf9a595f1104a0ba7d0c02acbf47625_Out_2, _Split_d8eed8fe26594972914c124586d98bbf_B_3, 0, _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGBA_4, _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGB_5, _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RG_6);
            description.Position = _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGB_5;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            description.MainNormal = _TilingAndOffset_924ee153284a4d4abbd47514c96bb1ae_Out_3;
            description.SecondNormal = _TilingAndOffset_08fa9dddbfc44f8b9e671e082ef10419_Out_3;
            description.FoamDirection1 = _TilingAndOffset_e2926df184da41caab0fcf14e34b81a7_Out_3;
            description.FoamDirection2 = _TilingAndOffset_c89d2fcde70d4d818249ebe200337480_Out_3;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        output.MainNormal = input.MainNormal;
        output.SecondNormal = input.SecondNormal;
        output.FoamDirection1 = input.FoamDirection1;
        output.FoamDirection2 = input.FoamDirection2;
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float3 BaseColor;
            float3 Emission;
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float4 _Property_53dfc4b4cafc4a9496bd9fde6989ee8f_Out_0 = Color_b5081859698940efa07a6cc68ff92e70;
            float4 _Property_601193b6811a41eeb79befed4e93080a_Out_0 = _Shallow_Water_Color_2;
            float4 _UV_0459ed23840544d4943e249e6bf3def0_Out_0 = IN.uv0;
            float _Split_95c75a1ea7ee4dd7906396bff762bd25_R_1 = _UV_0459ed23840544d4943e249e6bf3def0_Out_0[0];
            float _Split_95c75a1ea7ee4dd7906396bff762bd25_G_2 = _UV_0459ed23840544d4943e249e6bf3def0_Out_0[1];
            float _Split_95c75a1ea7ee4dd7906396bff762bd25_B_3 = _UV_0459ed23840544d4943e249e6bf3def0_Out_0[2];
            float _Split_95c75a1ea7ee4dd7906396bff762bd25_A_4 = _UV_0459ed23840544d4943e249e6bf3def0_Out_0[3];
            float _Preview_0af5c98f89c44402ab2012c583d6f212_Out_1;
            Unity_Preview_float(_Split_95c75a1ea7ee4dd7906396bff762bd25_G_2, _Preview_0af5c98f89c44402ab2012c583d6f212_Out_1);
            float4 _Lerp_c2c00306fc734b0c8dee546205970ae6_Out_3;
            Unity_Lerp_float4(_Property_53dfc4b4cafc4a9496bd9fde6989ee8f_Out_0, _Property_601193b6811a41eeb79befed4e93080a_Out_0, (_Preview_0af5c98f89c44402ab2012c583d6f212_Out_1.xxxx), _Lerp_c2c00306fc734b0c8dee546205970ae6_Out_3);
            float4 _Property_72f89d8f335a4977a093f3bae7ef5ea1_Out_0 = Color_2bad1140d6ae465a8b096ead483f5370;
            float4 _Property_8d638ca6b7cc402595ddc523b14de263_Out_0 = Color_1;
            float4 _Lerp_25807026701046b7a4a6abcec2069726_Out_3;
            Unity_Lerp_float4(_Property_72f89d8f335a4977a093f3bae7ef5ea1_Out_0, _Property_8d638ca6b7cc402595ddc523b14de263_Out_0, (_Preview_0af5c98f89c44402ab2012c583d6f212_Out_1.xxxx), _Lerp_25807026701046b7a4a6abcec2069726_Out_3);
            float _SceneDepth_91aa5f89e7564cb2ac5171231a24afdf_Out_1;
            Unity_SceneDepth_Linear01_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_91aa5f89e7564cb2ac5171231a24afdf_Out_1);
            float _Multiply_619704251bdd44e6a8e9f02add36789c_Out_2;
            Unity_Multiply_float_float(_SceneDepth_91aa5f89e7564cb2ac5171231a24afdf_Out_1, _ProjectionParams.z, _Multiply_619704251bdd44e6a8e9f02add36789c_Out_2);
            float4 _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0 = IN.ScreenPosition;
            float _Split_eb526920998f41cd825cbe42160042f5_R_1 = _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0[0];
            float _Split_eb526920998f41cd825cbe42160042f5_G_2 = _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0[1];
            float _Split_eb526920998f41cd825cbe42160042f5_B_3 = _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0[2];
            float _Split_eb526920998f41cd825cbe42160042f5_A_4 = _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0[3];
            float _Property_f4dad9c86f154090a77929fc0594d2eb_Out_0 = Vector1_f108b0f6f7ad4a0fa7970936cde8c93a;
            float _Add_1d0b28a6a0fe41b9aea6de0b9a290419_Out_2;
            Unity_Add_float(_Split_eb526920998f41cd825cbe42160042f5_A_4, _Property_f4dad9c86f154090a77929fc0594d2eb_Out_0, _Add_1d0b28a6a0fe41b9aea6de0b9a290419_Out_2);
            float _Subtract_c310e84b25994cf7969fb6aec3c12631_Out_2;
            Unity_Subtract_float(_Multiply_619704251bdd44e6a8e9f02add36789c_Out_2, _Add_1d0b28a6a0fe41b9aea6de0b9a290419_Out_2, _Subtract_c310e84b25994cf7969fb6aec3c12631_Out_2);
            float _Property_e2cb78357bf54371b95b04624c624355_Out_0 = Vector1_77a8669616464cc68eec17e9163052aa;
            float _Multiply_77d88fee04a2411ebf64a9f3cf93ee09_Out_2;
            Unity_Multiply_float_float(_Subtract_c310e84b25994cf7969fb6aec3c12631_Out_2, _Property_e2cb78357bf54371b95b04624c624355_Out_0, _Multiply_77d88fee04a2411ebf64a9f3cf93ee09_Out_2);
            float _Clamp_5c303e7a7ab74c80819cff967500a688_Out_3;
            Unity_Clamp_float(_Multiply_77d88fee04a2411ebf64a9f3cf93ee09_Out_2, 0, 1, _Clamp_5c303e7a7ab74c80819cff967500a688_Out_3);
            float4 _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3;
            Unity_Lerp_float4(_Lerp_c2c00306fc734b0c8dee546205970ae6_Out_3, _Lerp_25807026701046b7a4a6abcec2069726_Out_3, (_Clamp_5c303e7a7ab74c80819cff967500a688_Out_3.xxxx), _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3);
            UnityTexture2D _Property_691307347e93408bb228020d56a4f64e_Out_0 = UnityBuildTexture2DStructNoScale(Texture2D_2d2e087224e24282b84a086f3316e6e8);
            float4 _SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0 = SAMPLE_TEXTURE2D(_Property_691307347e93408bb228020d56a4f64e_Out_0.tex, _Property_691307347e93408bb228020d56a4f64e_Out_0.samplerstate, _Property_691307347e93408bb228020d56a4f64e_Out_0.GetTransformedUV(IN.MainNormal));
            _SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0);
            float _SampleTexture2D_3802527e187e464aa45999485a38f24f_R_4 = _SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0.r;
            float _SampleTexture2D_3802527e187e464aa45999485a38f24f_G_5 = _SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0.g;
            float _SampleTexture2D_3802527e187e464aa45999485a38f24f_B_6 = _SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0.b;
            float _SampleTexture2D_3802527e187e464aa45999485a38f24f_A_7 = _SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0.a;
            UnityTexture2D _Property_162be1870c564d31abda704370ecd112_Out_0 = UnityBuildTexture2DStructNoScale(Texture2D_21a78e051aa84ab49c73d2364e78102f);
            float4 _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0 = SAMPLE_TEXTURE2D(_Property_162be1870c564d31abda704370ecd112_Out_0.tex, _Property_162be1870c564d31abda704370ecd112_Out_0.samplerstate, _Property_162be1870c564d31abda704370ecd112_Out_0.GetTransformedUV(IN.SecondNormal));
            _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0);
            float _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_R_4 = _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0.r;
            float _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_G_5 = _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0.g;
            float _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_B_6 = _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0.b;
            float _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_A_7 = _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0.a;
            float4 _Add_357900c2d36f40c0b7995aceda820c48_Out_2;
            Unity_Add_float4(_SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0, _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0, _Add_357900c2d36f40c0b7995aceda820c48_Out_2);
            float _Property_bcb4a350b8234af79860039f232f70bb_Out_0 = Vector1_0360d732cbbf426e841ca433b0e337aa;
            float3 _NormalStrength_353fbbdfa63c4bf1a26d328b90d65d75_Out_2;
            Unity_NormalStrength_float((_Add_357900c2d36f40c0b7995aceda820c48_Out_2.xyz), _Property_bcb4a350b8234af79860039f232f70bb_Out_0, _NormalStrength_353fbbdfa63c4bf1a26d328b90d65d75_Out_2);
            float _Property_435f8911f9614444bccaa1b491910830_Out_0 = _RefractionDistrotion;
            float3 _NormalStrength_c661b7411e0343adbe9cd03e17ec5587_Out_2;
            Unity_NormalStrength_float(_NormalStrength_353fbbdfa63c4bf1a26d328b90d65d75_Out_2, _Property_435f8911f9614444bccaa1b491910830_Out_0, _NormalStrength_c661b7411e0343adbe9cd03e17ec5587_Out_2);
            float4 _ScreenPosition_8195cd06776241d5b37929c91c6dad48_Out_0 = float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0);
            float3 _Add_b257228ea21d4b4d977a6133326b7e06_Out_2;
            Unity_Add_float3(_NormalStrength_c661b7411e0343adbe9cd03e17ec5587_Out_2, (_ScreenPosition_8195cd06776241d5b37929c91c6dad48_Out_0.xyz), _Add_b257228ea21d4b4d977a6133326b7e06_Out_2);
            float3 _SceneColor_2c332a05662541f2bba2d1b5eeb47bd2_Out_1;
            Unity_SceneColor_float((float4(_Add_b257228ea21d4b4d977a6133326b7e06_Out_2, 1.0)), _SceneColor_2c332a05662541f2bba2d1b5eeb47bd2_Out_1);
            UnityTexture2D _Property_c55f1526f461489aa2011515ec7da3a3_Out_0 = UnityBuildTexture2DStructNoScale(_PlanarReflectionTexture);
            float3 _Add_9cc9802b3ef24c21b8771b375a3bff42_Out_2;
            Unity_Add_float3(_NormalStrength_353fbbdfa63c4bf1a26d328b90d65d75_Out_2, (_Clamp_5c303e7a7ab74c80819cff967500a688_Out_3.xxx), _Add_9cc9802b3ef24c21b8771b375a3bff42_Out_2);
            float3 _NormalStrength_6161489259bb4747ba0928987b51a0ea_Out_2;
            Unity_NormalStrength_float(_Add_9cc9802b3ef24c21b8771b375a3bff42_Out_2, _Property_435f8911f9614444bccaa1b491910830_Out_0, _NormalStrength_6161489259bb4747ba0928987b51a0ea_Out_2);
            float3 _Add_51f05a9faaf74e72812fae8a48ed882c_Out_2;
            Unity_Add_float3((_ScreenPosition_8195cd06776241d5b37929c91c6dad48_Out_0.xyz), _NormalStrength_6161489259bb4747ba0928987b51a0ea_Out_2, _Add_51f05a9faaf74e72812fae8a48ed882c_Out_2);
            float4 _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_RGBA_0 = SAMPLE_TEXTURE2D(_Property_c55f1526f461489aa2011515ec7da3a3_Out_0.tex, _Property_c55f1526f461489aa2011515ec7da3a3_Out_0.samplerstate, _Property_c55f1526f461489aa2011515ec7da3a3_Out_0.GetTransformedUV((_Add_51f05a9faaf74e72812fae8a48ed882c_Out_2.xy)));
            float _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_R_4 = _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_RGBA_0.r;
            float _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_G_5 = _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_RGBA_0.g;
            float _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_B_6 = _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_RGBA_0.b;
            float _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_A_7 = _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_RGBA_0.a;
            float3 _Lerp_6bca2423774749ccb6b3d02c089ca6aa_Out_3;
            Unity_Lerp_float3(_SceneColor_2c332a05662541f2bba2d1b5eeb47bd2_Out_1, (_SampleTexture2D_60a5b90e4760409a9760488b39b95feb_RGBA_0.xyz), (_Clamp_5c303e7a7ab74c80819cff967500a688_Out_3.xxx), _Lerp_6bca2423774749ccb6b3d02c089ca6aa_Out_3);
            float _Property_4267d14b41a64c8faa1146ffbcfe3618_Out_0 = _Relection_Strength;
            float3 _Blend_1d413404067041f1a38d59c008106e23_Out_2;
            Unity_Blend_Multiply_float3((_Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3.xyz), _Lerp_6bca2423774749ccb6b3d02c089ca6aa_Out_3, _Blend_1d413404067041f1a38d59c008106e23_Out_2, _Property_4267d14b41a64c8faa1146ffbcfe3618_Out_0);
            UnityTexture2D _Property_dff6df0bd4d4495f97a7a18e11ec195a_Out_0 = UnityBuildTexture2DStructNoScale(Texture2D_2d2e087224e24282b84a086f3316e6e8);
            float4 _SampleTexture2D_fd9ae2c1f81b405e9021849934e7146d_RGBA_0 = SAMPLE_TEXTURE2D(_Property_dff6df0bd4d4495f97a7a18e11ec195a_Out_0.tex, _Property_dff6df0bd4d4495f97a7a18e11ec195a_Out_0.samplerstate, _Property_dff6df0bd4d4495f97a7a18e11ec195a_Out_0.GetTransformedUV(IN.MainNormal));
            float _SampleTexture2D_fd9ae2c1f81b405e9021849934e7146d_R_4 = _SampleTexture2D_fd9ae2c1f81b405e9021849934e7146d_RGBA_0.r;
            float _SampleTexture2D_fd9ae2c1f81b405e9021849934e7146d_G_5 = _SampleTexture2D_fd9ae2c1f81b405e9021849934e7146d_RGBA_0.g;
            float _SampleTexture2D_fd9ae2c1f81b405e9021849934e7146d_B_6 = _SampleTexture2D_fd9ae2c1f81b405e9021849934e7146d_RGBA_0.b;
            float _SampleTexture2D_fd9ae2c1f81b405e9021849934e7146d_A_7 = _SampleTexture2D_fd9ae2c1f81b405e9021849934e7146d_RGBA_0.a;
            UnityTexture2D _Property_f0238f5adf1d400c886a5a72ea8e3800_Out_0 = UnityBuildTexture2DStructNoScale(Texture2D_2d2e087224e24282b84a086f3316e6e8);
            float4 _SampleTexture2D_b5339f18d32e4578951e0bd01553c041_RGBA_0 = SAMPLE_TEXTURE2D(_Property_f0238f5adf1d400c886a5a72ea8e3800_Out_0.tex, _Property_f0238f5adf1d400c886a5a72ea8e3800_Out_0.samplerstate, _Property_f0238f5adf1d400c886a5a72ea8e3800_Out_0.GetTransformedUV(IN.SecondNormal));
            float _SampleTexture2D_b5339f18d32e4578951e0bd01553c041_R_4 = _SampleTexture2D_b5339f18d32e4578951e0bd01553c041_RGBA_0.r;
            float _SampleTexture2D_b5339f18d32e4578951e0bd01553c041_G_5 = _SampleTexture2D_b5339f18d32e4578951e0bd01553c041_RGBA_0.g;
            float _SampleTexture2D_b5339f18d32e4578951e0bd01553c041_B_6 = _SampleTexture2D_b5339f18d32e4578951e0bd01553c041_RGBA_0.b;
            float _SampleTexture2D_b5339f18d32e4578951e0bd01553c041_A_7 = _SampleTexture2D_b5339f18d32e4578951e0bd01553c041_RGBA_0.a;
            float4 _Add_f4d1aaeeebe741bfac01df2cb63237d2_Out_2;
            Unity_Add_float4(_SampleTexture2D_fd9ae2c1f81b405e9021849934e7146d_RGBA_0, _SampleTexture2D_b5339f18d32e4578951e0bd01553c041_RGBA_0, _Add_f4d1aaeeebe741bfac01df2cb63237d2_Out_2);
            float _Property_94bcaaa57baf401a892936e8d1121760_Out_0 = _Layer1_Scale;
            float _ColorMask_3b67330abbfa4d5da09be858fde593ec_Out_3;
            Unity_ColorMask_float((_Add_f4d1aaeeebe741bfac01df2cb63237d2_Out_2.xyz), IsGammaSpace() ? float3(1, 1, 1) : SRGBToLinear(float3(1, 1, 1)), _Property_94bcaaa57baf401a892936e8d1121760_Out_0, _ColorMask_3b67330abbfa4d5da09be858fde593ec_Out_3, 0.4);
            UnityTexture2D _Property_edbfda5e1a564ea2aad094a54bb3b007_Out_0 = UnityBuildTexture2DStructNoScale(Texture2D_d65eb6e07c30447ca446c38272609586);
            float4 _SampleTexture2D_7464425046b24f39b9304827ccb6101e_RGBA_0 = SAMPLE_TEXTURE2D(_Property_edbfda5e1a564ea2aad094a54bb3b007_Out_0.tex, _Property_edbfda5e1a564ea2aad094a54bb3b007_Out_0.samplerstate, _Property_edbfda5e1a564ea2aad094a54bb3b007_Out_0.GetTransformedUV(IN.FoamDirection1));
            float _SampleTexture2D_7464425046b24f39b9304827ccb6101e_R_4 = _SampleTexture2D_7464425046b24f39b9304827ccb6101e_RGBA_0.r;
            float _SampleTexture2D_7464425046b24f39b9304827ccb6101e_G_5 = _SampleTexture2D_7464425046b24f39b9304827ccb6101e_RGBA_0.g;
            float _SampleTexture2D_7464425046b24f39b9304827ccb6101e_B_6 = _SampleTexture2D_7464425046b24f39b9304827ccb6101e_RGBA_0.b;
            float _SampleTexture2D_7464425046b24f39b9304827ccb6101e_A_7 = _SampleTexture2D_7464425046b24f39b9304827ccb6101e_RGBA_0.a;
            float4 _Property_05ee1312567a419ea766bcaa855dc2ed_Out_0 = Color_6e3aa9f38d68448bb94d493ef4e3c30a;
            float4 _Multiply_75f2ec69c46847e5aaea2cd6420daa9e_Out_2;
            Unity_Multiply_float4_float4((_SampleTexture2D_7464425046b24f39b9304827ccb6101e_G_5.xxxx), _Property_05ee1312567a419ea766bcaa855dc2ed_Out_0, _Multiply_75f2ec69c46847e5aaea2cd6420daa9e_Out_2);
            float4 _Multiply_e5480cb837904b4ab771dec3029ac8d6_Out_2;
            Unity_Multiply_float4_float4((_ColorMask_3b67330abbfa4d5da09be858fde593ec_Out_3.xxxx), _Multiply_75f2ec69c46847e5aaea2cd6420daa9e_Out_2, _Multiply_e5480cb837904b4ab771dec3029ac8d6_Out_2);
            float _Property_aff115291912400081bcc3de12f2f8ec_Out_0 = _Layer2_Scale;
            float _ColorMask_c2b65a71e09b4b4a97fc255b1947e69e_Out_3;
            Unity_ColorMask_float((_Add_f4d1aaeeebe741bfac01df2cb63237d2_Out_2.xyz), IsGammaSpace() ? float3(1, 1, 1) : SRGBToLinear(float3(1, 1, 1)), _Property_aff115291912400081bcc3de12f2f8ec_Out_0, _ColorMask_c2b65a71e09b4b4a97fc255b1947e69e_Out_3, 0.4);
            float4 _SampleTexture2D_4dcd9985d6b54ac3a3070127f41fef44_RGBA_0 = SAMPLE_TEXTURE2D(_Property_edbfda5e1a564ea2aad094a54bb3b007_Out_0.tex, _Property_edbfda5e1a564ea2aad094a54bb3b007_Out_0.samplerstate, _Property_edbfda5e1a564ea2aad094a54bb3b007_Out_0.GetTransformedUV(IN.FoamDirection2));
            float _SampleTexture2D_4dcd9985d6b54ac3a3070127f41fef44_R_4 = _SampleTexture2D_4dcd9985d6b54ac3a3070127f41fef44_RGBA_0.r;
            float _SampleTexture2D_4dcd9985d6b54ac3a3070127f41fef44_G_5 = _SampleTexture2D_4dcd9985d6b54ac3a3070127f41fef44_RGBA_0.g;
            float _SampleTexture2D_4dcd9985d6b54ac3a3070127f41fef44_B_6 = _SampleTexture2D_4dcd9985d6b54ac3a3070127f41fef44_RGBA_0.b;
            float _SampleTexture2D_4dcd9985d6b54ac3a3070127f41fef44_A_7 = _SampleTexture2D_4dcd9985d6b54ac3a3070127f41fef44_RGBA_0.a;
            float4 _Multiply_d1696f7e6e5a4cdcae3d545c0dab56c5_Out_2;
            Unity_Multiply_float4_float4(_Property_05ee1312567a419ea766bcaa855dc2ed_Out_0, (_SampleTexture2D_4dcd9985d6b54ac3a3070127f41fef44_B_6.xxxx), _Multiply_d1696f7e6e5a4cdcae3d545c0dab56c5_Out_2);
            float4 _Multiply_7ddead3a69614c469917ed7b9aafa900_Out_2;
            Unity_Multiply_float4_float4((_ColorMask_c2b65a71e09b4b4a97fc255b1947e69e_Out_3.xxxx), _Multiply_d1696f7e6e5a4cdcae3d545c0dab56c5_Out_2, _Multiply_7ddead3a69614c469917ed7b9aafa900_Out_2);
            float4 _Add_d1b55de8d8eb46d5be51b419333fbee1_Out_2;
            Unity_Add_float4(_Multiply_e5480cb837904b4ab771dec3029ac8d6_Out_2, _Multiply_7ddead3a69614c469917ed7b9aafa900_Out_2, _Add_d1b55de8d8eb46d5be51b419333fbee1_Out_2);
            float4 _Property_91c7296a1fd34a6ba4ba2db430b227cf_Out_0 = Color_6e3aa9f38d68448bb94d493ef4e3c30a;
            float _Property_25ca0be5c8024b6984b39cc03c10699e_Out_0 = Vector1_aace7401fb3a402e9f06de96963c9b84;
            float _Subtract_af5fef32a00b4cd4863e59c7a5aa9f5c_Out_2;
            Unity_Subtract_float(_Multiply_619704251bdd44e6a8e9f02add36789c_Out_2, _Split_eb526920998f41cd825cbe42160042f5_A_4, _Subtract_af5fef32a00b4cd4863e59c7a5aa9f5c_Out_2);
            float _Subtract_5cb3b9da51094bfc9691cff775ed046c_Out_2;
            Unity_Subtract_float(_Property_25ca0be5c8024b6984b39cc03c10699e_Out_0, _Subtract_af5fef32a00b4cd4863e59c7a5aa9f5c_Out_2, _Subtract_5cb3b9da51094bfc9691cff775ed046c_Out_2);
            float _Property_ddab7adb8fc8414e903ddbb8f8b183e2_Out_0 = Vector1_0d98869735ab4e73a0e4bb36589d00c0;
            float _Multiply_efbf135285134c28b8a80ff0e4ba3f17_Out_2;
            Unity_Multiply_float_float(_Subtract_5cb3b9da51094bfc9691cff775ed046c_Out_2, _Property_ddab7adb8fc8414e903ddbb8f8b183e2_Out_0, _Multiply_efbf135285134c28b8a80ff0e4ba3f17_Out_2);
            float4 _Multiply_92e7da0ce3c448e0a75776463e054f66_Out_2;
            Unity_Multiply_float4_float4(_Property_91c7296a1fd34a6ba4ba2db430b227cf_Out_0, (_Multiply_efbf135285134c28b8a80ff0e4ba3f17_Out_2.xxxx), _Multiply_92e7da0ce3c448e0a75776463e054f66_Out_2);
            UnityTexture2D _Property_2613ec34f9504d22aafecb7ad6480e1e_Out_0 = UnityBuildTexture2DStructNoScale(Texture2D_d65eb6e07c30447ca446c38272609586);
            float2 _Property_49ee0e056d6942968b9200a4a85c3251_Out_0 = Vector2_2832e3b0590c4ee98f806b14c0f54c5b;
            float2 _TilingAndOffset_b50bda6ad9b140f9b0ca863214f6b957_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Property_49ee0e056d6942968b9200a4a85c3251_Out_0, float2 (0.18, 0), _TilingAndOffset_b50bda6ad9b140f9b0ca863214f6b957_Out_3);
            float4 _SampleTexture2D_00f1f15016c649f0ae4e0c96597e573f_RGBA_0 = SAMPLE_TEXTURE2D(_Property_2613ec34f9504d22aafecb7ad6480e1e_Out_0.tex, _Property_2613ec34f9504d22aafecb7ad6480e1e_Out_0.samplerstate, _Property_2613ec34f9504d22aafecb7ad6480e1e_Out_0.GetTransformedUV(_TilingAndOffset_b50bda6ad9b140f9b0ca863214f6b957_Out_3));
            float _SampleTexture2D_00f1f15016c649f0ae4e0c96597e573f_R_4 = _SampleTexture2D_00f1f15016c649f0ae4e0c96597e573f_RGBA_0.r;
            float _SampleTexture2D_00f1f15016c649f0ae4e0c96597e573f_G_5 = _SampleTexture2D_00f1f15016c649f0ae4e0c96597e573f_RGBA_0.g;
            float _SampleTexture2D_00f1f15016c649f0ae4e0c96597e573f_B_6 = _SampleTexture2D_00f1f15016c649f0ae4e0c96597e573f_RGBA_0.b;
            float _SampleTexture2D_00f1f15016c649f0ae4e0c96597e573f_A_7 = _SampleTexture2D_00f1f15016c649f0ae4e0c96597e573f_RGBA_0.a;
            float4 _Multiply_4f081b87dfcb4a41bb7615b058040e89_Out_2;
            Unity_Multiply_float4_float4(_Multiply_92e7da0ce3c448e0a75776463e054f66_Out_2, (_SampleTexture2D_00f1f15016c649f0ae4e0c96597e573f_G_5.xxxx), _Multiply_4f081b87dfcb4a41bb7615b058040e89_Out_2);
            float4 _Clamp_3a0f28c23b344448ac636ad89dbdb3e7_Out_3;
            Unity_Clamp_float4(_Multiply_4f081b87dfcb4a41bb7615b058040e89_Out_2, float4(0, 0, 0, 0), float4(1, 1, 1, 1), _Clamp_3a0f28c23b344448ac636ad89dbdb3e7_Out_3);
            float4 _Add_fb079be2c07b4115bae3a3c384291108_Out_2;
            Unity_Add_float4(_Add_d1b55de8d8eb46d5be51b419333fbee1_Out_2, _Clamp_3a0f28c23b344448ac636ad89dbdb3e7_Out_3, _Add_fb079be2c07b4115bae3a3c384291108_Out_2);
            float _Split_32fd3b93931741f5ba645cdab3f37d0f_R_1 = _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3[0];
            float _Split_32fd3b93931741f5ba645cdab3f37d0f_G_2 = _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3[1];
            float _Split_32fd3b93931741f5ba645cdab3f37d0f_B_3 = _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3[2];
            float _Split_32fd3b93931741f5ba645cdab3f37d0f_A_4 = _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3[3];
            surface.BaseColor = _Blend_1d413404067041f1a38d59c008106e23_Out_2;
            surface.Emission = (_Add_fb079be2c07b4115bae3a3c384291108_Out_2.xyz);
            surface.Alpha = _Split_32fd3b93931741f5ba645cdab3f37d0f_A_4;
            surface.AlphaClipThreshold = 0;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
            output.AbsoluteWorldSpacePosition =                 GetAbsolutePositionWS(TransformObjectToWorld(input.positionOS));
            output.uv0 =                                        input.uv0;
            output.TimeParameters =                             _TimeParameters.xyz;
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            output.MainNormal = input.MainNormal;
        output.SecondNormal = input.SecondNormal;
        output.FoamDirection1 = input.FoamDirection1;
        output.FoamDirection2 = input.FoamDirection2;
        
        
        
        
        
            output.WorldSpacePosition = input.positionWS;
            output.ScreenPosition = ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
            output.uv0 = input.texCoord0;
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/LightingMetaPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            Name "SceneSelectionPass"
            Tags
            {
                "LightMode" = "SceneSelectionPass"
            }
        
        // Render State
        Cull Off
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 4.5
        #pragma exclude_renderers gles gles3 glcore
        #pragma vertex vert
        #pragma fragment frag
        
        // DotsInstancingOptions: <None>
        // HybridV1InjectedBuiltinProperties: <None>
        
        // Keywords
        // PassKeywords: <None>
        // GraphKeywords: <None>
        
        // Defines
        
        #define _NORMALMAP 1
        #define _NORMAL_DROPOFF_TS 1
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define VARYINGS_NEED_POSITION_WS
        #define VARYINGS_NEED_TEXCOORD0
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_DEPTHONLY
        #define SCENESELECTIONPASS 1
        #define ALPHA_CLIP_THRESHOLD 1
        #define _ALPHATEST_ON 1
        #define REQUIRE_DEPTH_TEXTURE
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float3 positionWS;
             float4 texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
             float3 WorldSpacePosition;
             float4 ScreenPosition;
             float4 uv0;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
             float4 uv0;
             float3 TimeParameters;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float3 interp0 : INTERP0;
             float4 interp1 : INTERP1;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.positionWS;
            output.interp1.xyzw =  input.texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.positionWS = input.interp0.xyz;
            output.texCoord0 = input.interp1.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float4 _PlanarReflectionTexture_TexelSize;
        float Vector1_f108b0f6f7ad4a0fa7970936cde8c93a;
        float Vector1_77a8669616464cc68eec17e9163052aa;
        float4 Color_2bad1140d6ae465a8b096ead483f5370;
        float4 Color_b5081859698940efa07a6cc68ff92e70;
        float4 Color_1;
        float4 Texture2D_2d2e087224e24282b84a086f3316e6e8_TexelSize;
        float2 Vector2_c2fe4e7c2a7649b28d7ab078fdadda1c;
        float Vector1_7614a6098dec470e8a4e96a5c8551362;
        float4 Texture2D_21a78e051aa84ab49c73d2364e78102f_TexelSize;
        float2 Vector2_73fa27b3bcf64608a50eed7c1d0d3411;
        float Vector1_898460d8305d4dfe9af1298eb6f67082;
        float Vector1_0360d732cbbf426e841ca433b0e337aa;
        float Vector1_dcce861f82224ec1ac55aa94df3b3d12;
        float Vector1_3606b8114ded4a74a4e4834f8bf7dc12;
        float Vector1_69bcaf9cf50f40a2bef27afe006bbc8f;
        float4 Color_6e3aa9f38d68448bb94d493ef4e3c30a;
        float Vector1_0d98869735ab4e73a0e4bb36589d00c0;
        float Vector1_aace7401fb3a402e9f06de96963c9b84;
        float4 Texture2D_d65eb6e07c30447ca446c38272609586_TexelSize;
        float2 Vector2_2832e3b0590c4ee98f806b14c0f54c5b;
        float4 _Shallow_Water_Color_2;
        float2 _Panning;
        float _DistortionSpeed;
        float _DistortionIntensity;
        float2 _FoamNoiseTilling;
        float _DistortionScale;
        float _NoiseScale;
        float _Layer1_Scale;
        float _Layer2_Scale;
        float _RefractionDistrotion;
        float _Relection_Strength;
        CBUFFER_END
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_PlanarReflectionTexture);
        SAMPLER(sampler_PlanarReflectionTexture);
        TEXTURE2D(Texture2D_2d2e087224e24282b84a086f3316e6e8);
        SAMPLER(samplerTexture2D_2d2e087224e24282b84a086f3316e6e8);
        TEXTURE2D(Texture2D_21a78e051aa84ab49c73d2364e78102f);
        SAMPLER(samplerTexture2D_21a78e051aa84ab49c73d2364e78102f);
        TEXTURE2D(Texture2D_d65eb6e07c30447ca446c38272609586);
        SAMPLER(samplerTexture2D_d65eb6e07c30447ca446c38272609586);
        
        // Graph Includes
        // GraphIncludes: <None>
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        
        float2 Unity_GradientNoise_Dir_float(float2 p)
        {
            // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
            p = p % 289;
            // need full precision, otherwise half overflows when p > 1
            float x = float(34 * p.x + 1) * p.x % 289 + p.y;
            x = (34 * x + 1) * x % 289;
            x = frac(x / 41) * 2 - 1;
            return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
        }
        
        void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
        {
            float2 p = UV * Scale;
            float2 ip = floor(p);
            float2 fp = frac(p);
            float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
            float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
            float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
            float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
            fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
            Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }
        
        void Unity_Preview_float(float In, out float Out)
        {
            Out = In;
        }
        
        void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
        {
            Out = lerp(A, B, T);
        }
        
        void Unity_SceneDepth_Linear01_float(float4 UV, out float Out)
        {
            Out = Linear01Depth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }
        
        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            float _Split_d8eed8fe26594972914c124586d98bbf_R_1 = IN.ObjectSpacePosition[0];
            float _Split_d8eed8fe26594972914c124586d98bbf_G_2 = IN.ObjectSpacePosition[1];
            float _Split_d8eed8fe26594972914c124586d98bbf_B_3 = IN.ObjectSpacePosition[2];
            float _Split_d8eed8fe26594972914c124586d98bbf_A_4 = 0;
            float _Property_762630e6999b4da0a14b2ccffa4209d8_Out_0 = Vector1_dcce861f82224ec1ac55aa94df3b3d12;
            float _Divide_df746930d1d841c09a66286a0a3543ae_Out_2;
            Unity_Divide_float(_Property_762630e6999b4da0a14b2ccffa4209d8_Out_0, 200, _Divide_df746930d1d841c09a66286a0a3543ae_Out_2);
            float _Property_d73cd49e4412457080da3ad6f38ac94b_Out_0 = Vector1_3606b8114ded4a74a4e4834f8bf7dc12;
            float _Divide_b14ec7aec4874b8ab4371962384288e5_Out_2;
            Unity_Divide_float(_Property_d73cd49e4412457080da3ad6f38ac94b_Out_0, 50, _Divide_b14ec7aec4874b8ab4371962384288e5_Out_2);
            float _Multiply_f97f597155bf4b59afa13426042ec0a0_Out_2;
            Unity_Multiply_float_float(IN.TimeParameters.x, _Divide_b14ec7aec4874b8ab4371962384288e5_Out_2, _Multiply_f97f597155bf4b59afa13426042ec0a0_Out_2);
            float2 _TilingAndOffset_ab2fed3c342049de89287a73af5f4dd1_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, (_Multiply_f97f597155bf4b59afa13426042ec0a0_Out_2.xx), float2 (0, 0), _TilingAndOffset_ab2fed3c342049de89287a73af5f4dd1_Out_3);
            float _GradientNoise_c349a7da229a42f6acfd0e9329f501a7_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_ab2fed3c342049de89287a73af5f4dd1_Out_3, 0.96, _GradientNoise_c349a7da229a42f6acfd0e9329f501a7_Out_2);
            float _Multiply_9460f57a023144a9ae646cb7ff3c8354_Out_2;
            Unity_Multiply_float_float(_Divide_df746930d1d841c09a66286a0a3543ae_Out_2, _GradientNoise_c349a7da229a42f6acfd0e9329f501a7_Out_2, _Multiply_9460f57a023144a9ae646cb7ff3c8354_Out_2);
            float _Add_5cf9a595f1104a0ba7d0c02acbf47625_Out_2;
            Unity_Add_float(_Split_d8eed8fe26594972914c124586d98bbf_G_2, _Multiply_9460f57a023144a9ae646cb7ff3c8354_Out_2, _Add_5cf9a595f1104a0ba7d0c02acbf47625_Out_2);
            float4 _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGBA_4;
            float3 _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGB_5;
            float2 _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RG_6;
            Unity_Combine_float(_Split_d8eed8fe26594972914c124586d98bbf_R_1, _Add_5cf9a595f1104a0ba7d0c02acbf47625_Out_2, _Split_d8eed8fe26594972914c124586d98bbf_B_3, 0, _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGBA_4, _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGB_5, _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RG_6);
            description.Position = _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGB_5;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float4 _Property_53dfc4b4cafc4a9496bd9fde6989ee8f_Out_0 = Color_b5081859698940efa07a6cc68ff92e70;
            float4 _Property_601193b6811a41eeb79befed4e93080a_Out_0 = _Shallow_Water_Color_2;
            float4 _UV_0459ed23840544d4943e249e6bf3def0_Out_0 = IN.uv0;
            float _Split_95c75a1ea7ee4dd7906396bff762bd25_R_1 = _UV_0459ed23840544d4943e249e6bf3def0_Out_0[0];
            float _Split_95c75a1ea7ee4dd7906396bff762bd25_G_2 = _UV_0459ed23840544d4943e249e6bf3def0_Out_0[1];
            float _Split_95c75a1ea7ee4dd7906396bff762bd25_B_3 = _UV_0459ed23840544d4943e249e6bf3def0_Out_0[2];
            float _Split_95c75a1ea7ee4dd7906396bff762bd25_A_4 = _UV_0459ed23840544d4943e249e6bf3def0_Out_0[3];
            float _Preview_0af5c98f89c44402ab2012c583d6f212_Out_1;
            Unity_Preview_float(_Split_95c75a1ea7ee4dd7906396bff762bd25_G_2, _Preview_0af5c98f89c44402ab2012c583d6f212_Out_1);
            float4 _Lerp_c2c00306fc734b0c8dee546205970ae6_Out_3;
            Unity_Lerp_float4(_Property_53dfc4b4cafc4a9496bd9fde6989ee8f_Out_0, _Property_601193b6811a41eeb79befed4e93080a_Out_0, (_Preview_0af5c98f89c44402ab2012c583d6f212_Out_1.xxxx), _Lerp_c2c00306fc734b0c8dee546205970ae6_Out_3);
            float4 _Property_72f89d8f335a4977a093f3bae7ef5ea1_Out_0 = Color_2bad1140d6ae465a8b096ead483f5370;
            float4 _Property_8d638ca6b7cc402595ddc523b14de263_Out_0 = Color_1;
            float4 _Lerp_25807026701046b7a4a6abcec2069726_Out_3;
            Unity_Lerp_float4(_Property_72f89d8f335a4977a093f3bae7ef5ea1_Out_0, _Property_8d638ca6b7cc402595ddc523b14de263_Out_0, (_Preview_0af5c98f89c44402ab2012c583d6f212_Out_1.xxxx), _Lerp_25807026701046b7a4a6abcec2069726_Out_3);
            float _SceneDepth_91aa5f89e7564cb2ac5171231a24afdf_Out_1;
            Unity_SceneDepth_Linear01_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_91aa5f89e7564cb2ac5171231a24afdf_Out_1);
            float _Multiply_619704251bdd44e6a8e9f02add36789c_Out_2;
            Unity_Multiply_float_float(_SceneDepth_91aa5f89e7564cb2ac5171231a24afdf_Out_1, _ProjectionParams.z, _Multiply_619704251bdd44e6a8e9f02add36789c_Out_2);
            float4 _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0 = IN.ScreenPosition;
            float _Split_eb526920998f41cd825cbe42160042f5_R_1 = _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0[0];
            float _Split_eb526920998f41cd825cbe42160042f5_G_2 = _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0[1];
            float _Split_eb526920998f41cd825cbe42160042f5_B_3 = _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0[2];
            float _Split_eb526920998f41cd825cbe42160042f5_A_4 = _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0[3];
            float _Property_f4dad9c86f154090a77929fc0594d2eb_Out_0 = Vector1_f108b0f6f7ad4a0fa7970936cde8c93a;
            float _Add_1d0b28a6a0fe41b9aea6de0b9a290419_Out_2;
            Unity_Add_float(_Split_eb526920998f41cd825cbe42160042f5_A_4, _Property_f4dad9c86f154090a77929fc0594d2eb_Out_0, _Add_1d0b28a6a0fe41b9aea6de0b9a290419_Out_2);
            float _Subtract_c310e84b25994cf7969fb6aec3c12631_Out_2;
            Unity_Subtract_float(_Multiply_619704251bdd44e6a8e9f02add36789c_Out_2, _Add_1d0b28a6a0fe41b9aea6de0b9a290419_Out_2, _Subtract_c310e84b25994cf7969fb6aec3c12631_Out_2);
            float _Property_e2cb78357bf54371b95b04624c624355_Out_0 = Vector1_77a8669616464cc68eec17e9163052aa;
            float _Multiply_77d88fee04a2411ebf64a9f3cf93ee09_Out_2;
            Unity_Multiply_float_float(_Subtract_c310e84b25994cf7969fb6aec3c12631_Out_2, _Property_e2cb78357bf54371b95b04624c624355_Out_0, _Multiply_77d88fee04a2411ebf64a9f3cf93ee09_Out_2);
            float _Clamp_5c303e7a7ab74c80819cff967500a688_Out_3;
            Unity_Clamp_float(_Multiply_77d88fee04a2411ebf64a9f3cf93ee09_Out_2, 0, 1, _Clamp_5c303e7a7ab74c80819cff967500a688_Out_3);
            float4 _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3;
            Unity_Lerp_float4(_Lerp_c2c00306fc734b0c8dee546205970ae6_Out_3, _Lerp_25807026701046b7a4a6abcec2069726_Out_3, (_Clamp_5c303e7a7ab74c80819cff967500a688_Out_3.xxxx), _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3);
            float _Split_32fd3b93931741f5ba645cdab3f37d0f_R_1 = _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3[0];
            float _Split_32fd3b93931741f5ba645cdab3f37d0f_G_2 = _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3[1];
            float _Split_32fd3b93931741f5ba645cdab3f37d0f_B_3 = _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3[2];
            float _Split_32fd3b93931741f5ba645cdab3f37d0f_A_4 = _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3[3];
            surface.Alpha = _Split_32fd3b93931741f5ba645cdab3f37d0f_A_4;
            surface.AlphaClipThreshold = 0;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
            output.uv0 =                                        input.uv0;
            output.TimeParameters =                             _TimeParameters.xyz;
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
        
        
            output.WorldSpacePosition = input.positionWS;
            output.ScreenPosition = ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
            output.uv0 = input.texCoord0;
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/SelectionPickingPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            Name "ScenePickingPass"
            Tags
            {
                "LightMode" = "Picking"
            }
        
        // Render State
        Cull Back
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 4.5
        #pragma exclude_renderers gles gles3 glcore
        #pragma vertex vert
        #pragma fragment frag
        
        // DotsInstancingOptions: <None>
        // HybridV1InjectedBuiltinProperties: <None>
        
        // Keywords
        // PassKeywords: <None>
        // GraphKeywords: <None>
        
        // Defines
        
        #define _NORMALMAP 1
        #define _NORMAL_DROPOFF_TS 1
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define VARYINGS_NEED_POSITION_WS
        #define VARYINGS_NEED_TEXCOORD0
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_DEPTHONLY
        #define SCENEPICKINGPASS 1
        #define ALPHA_CLIP_THRESHOLD 1
        #define _ALPHATEST_ON 1
        #define REQUIRE_DEPTH_TEXTURE
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float3 positionWS;
             float4 texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
             float3 WorldSpacePosition;
             float4 ScreenPosition;
             float4 uv0;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
             float4 uv0;
             float3 TimeParameters;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float3 interp0 : INTERP0;
             float4 interp1 : INTERP1;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.positionWS;
            output.interp1.xyzw =  input.texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.positionWS = input.interp0.xyz;
            output.texCoord0 = input.interp1.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float4 _PlanarReflectionTexture_TexelSize;
        float Vector1_f108b0f6f7ad4a0fa7970936cde8c93a;
        float Vector1_77a8669616464cc68eec17e9163052aa;
        float4 Color_2bad1140d6ae465a8b096ead483f5370;
        float4 Color_b5081859698940efa07a6cc68ff92e70;
        float4 Color_1;
        float4 Texture2D_2d2e087224e24282b84a086f3316e6e8_TexelSize;
        float2 Vector2_c2fe4e7c2a7649b28d7ab078fdadda1c;
        float Vector1_7614a6098dec470e8a4e96a5c8551362;
        float4 Texture2D_21a78e051aa84ab49c73d2364e78102f_TexelSize;
        float2 Vector2_73fa27b3bcf64608a50eed7c1d0d3411;
        float Vector1_898460d8305d4dfe9af1298eb6f67082;
        float Vector1_0360d732cbbf426e841ca433b0e337aa;
        float Vector1_dcce861f82224ec1ac55aa94df3b3d12;
        float Vector1_3606b8114ded4a74a4e4834f8bf7dc12;
        float Vector1_69bcaf9cf50f40a2bef27afe006bbc8f;
        float4 Color_6e3aa9f38d68448bb94d493ef4e3c30a;
        float Vector1_0d98869735ab4e73a0e4bb36589d00c0;
        float Vector1_aace7401fb3a402e9f06de96963c9b84;
        float4 Texture2D_d65eb6e07c30447ca446c38272609586_TexelSize;
        float2 Vector2_2832e3b0590c4ee98f806b14c0f54c5b;
        float4 _Shallow_Water_Color_2;
        float2 _Panning;
        float _DistortionSpeed;
        float _DistortionIntensity;
        float2 _FoamNoiseTilling;
        float _DistortionScale;
        float _NoiseScale;
        float _Layer1_Scale;
        float _Layer2_Scale;
        float _RefractionDistrotion;
        float _Relection_Strength;
        CBUFFER_END
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_PlanarReflectionTexture);
        SAMPLER(sampler_PlanarReflectionTexture);
        TEXTURE2D(Texture2D_2d2e087224e24282b84a086f3316e6e8);
        SAMPLER(samplerTexture2D_2d2e087224e24282b84a086f3316e6e8);
        TEXTURE2D(Texture2D_21a78e051aa84ab49c73d2364e78102f);
        SAMPLER(samplerTexture2D_21a78e051aa84ab49c73d2364e78102f);
        TEXTURE2D(Texture2D_d65eb6e07c30447ca446c38272609586);
        SAMPLER(samplerTexture2D_d65eb6e07c30447ca446c38272609586);
        
        // Graph Includes
        // GraphIncludes: <None>
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        
        float2 Unity_GradientNoise_Dir_float(float2 p)
        {
            // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
            p = p % 289;
            // need full precision, otherwise half overflows when p > 1
            float x = float(34 * p.x + 1) * p.x % 289 + p.y;
            x = (34 * x + 1) * x % 289;
            x = frac(x / 41) * 2 - 1;
            return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
        }
        
        void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
        {
            float2 p = UV * Scale;
            float2 ip = floor(p);
            float2 fp = frac(p);
            float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
            float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
            float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
            float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
            fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
            Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }
        
        void Unity_Preview_float(float In, out float Out)
        {
            Out = In;
        }
        
        void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
        {
            Out = lerp(A, B, T);
        }
        
        void Unity_SceneDepth_Linear01_float(float4 UV, out float Out)
        {
            Out = Linear01Depth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }
        
        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            float _Split_d8eed8fe26594972914c124586d98bbf_R_1 = IN.ObjectSpacePosition[0];
            float _Split_d8eed8fe26594972914c124586d98bbf_G_2 = IN.ObjectSpacePosition[1];
            float _Split_d8eed8fe26594972914c124586d98bbf_B_3 = IN.ObjectSpacePosition[2];
            float _Split_d8eed8fe26594972914c124586d98bbf_A_4 = 0;
            float _Property_762630e6999b4da0a14b2ccffa4209d8_Out_0 = Vector1_dcce861f82224ec1ac55aa94df3b3d12;
            float _Divide_df746930d1d841c09a66286a0a3543ae_Out_2;
            Unity_Divide_float(_Property_762630e6999b4da0a14b2ccffa4209d8_Out_0, 200, _Divide_df746930d1d841c09a66286a0a3543ae_Out_2);
            float _Property_d73cd49e4412457080da3ad6f38ac94b_Out_0 = Vector1_3606b8114ded4a74a4e4834f8bf7dc12;
            float _Divide_b14ec7aec4874b8ab4371962384288e5_Out_2;
            Unity_Divide_float(_Property_d73cd49e4412457080da3ad6f38ac94b_Out_0, 50, _Divide_b14ec7aec4874b8ab4371962384288e5_Out_2);
            float _Multiply_f97f597155bf4b59afa13426042ec0a0_Out_2;
            Unity_Multiply_float_float(IN.TimeParameters.x, _Divide_b14ec7aec4874b8ab4371962384288e5_Out_2, _Multiply_f97f597155bf4b59afa13426042ec0a0_Out_2);
            float2 _TilingAndOffset_ab2fed3c342049de89287a73af5f4dd1_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, (_Multiply_f97f597155bf4b59afa13426042ec0a0_Out_2.xx), float2 (0, 0), _TilingAndOffset_ab2fed3c342049de89287a73af5f4dd1_Out_3);
            float _GradientNoise_c349a7da229a42f6acfd0e9329f501a7_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_ab2fed3c342049de89287a73af5f4dd1_Out_3, 0.96, _GradientNoise_c349a7da229a42f6acfd0e9329f501a7_Out_2);
            float _Multiply_9460f57a023144a9ae646cb7ff3c8354_Out_2;
            Unity_Multiply_float_float(_Divide_df746930d1d841c09a66286a0a3543ae_Out_2, _GradientNoise_c349a7da229a42f6acfd0e9329f501a7_Out_2, _Multiply_9460f57a023144a9ae646cb7ff3c8354_Out_2);
            float _Add_5cf9a595f1104a0ba7d0c02acbf47625_Out_2;
            Unity_Add_float(_Split_d8eed8fe26594972914c124586d98bbf_G_2, _Multiply_9460f57a023144a9ae646cb7ff3c8354_Out_2, _Add_5cf9a595f1104a0ba7d0c02acbf47625_Out_2);
            float4 _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGBA_4;
            float3 _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGB_5;
            float2 _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RG_6;
            Unity_Combine_float(_Split_d8eed8fe26594972914c124586d98bbf_R_1, _Add_5cf9a595f1104a0ba7d0c02acbf47625_Out_2, _Split_d8eed8fe26594972914c124586d98bbf_B_3, 0, _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGBA_4, _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGB_5, _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RG_6);
            description.Position = _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGB_5;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float4 _Property_53dfc4b4cafc4a9496bd9fde6989ee8f_Out_0 = Color_b5081859698940efa07a6cc68ff92e70;
            float4 _Property_601193b6811a41eeb79befed4e93080a_Out_0 = _Shallow_Water_Color_2;
            float4 _UV_0459ed23840544d4943e249e6bf3def0_Out_0 = IN.uv0;
            float _Split_95c75a1ea7ee4dd7906396bff762bd25_R_1 = _UV_0459ed23840544d4943e249e6bf3def0_Out_0[0];
            float _Split_95c75a1ea7ee4dd7906396bff762bd25_G_2 = _UV_0459ed23840544d4943e249e6bf3def0_Out_0[1];
            float _Split_95c75a1ea7ee4dd7906396bff762bd25_B_3 = _UV_0459ed23840544d4943e249e6bf3def0_Out_0[2];
            float _Split_95c75a1ea7ee4dd7906396bff762bd25_A_4 = _UV_0459ed23840544d4943e249e6bf3def0_Out_0[3];
            float _Preview_0af5c98f89c44402ab2012c583d6f212_Out_1;
            Unity_Preview_float(_Split_95c75a1ea7ee4dd7906396bff762bd25_G_2, _Preview_0af5c98f89c44402ab2012c583d6f212_Out_1);
            float4 _Lerp_c2c00306fc734b0c8dee546205970ae6_Out_3;
            Unity_Lerp_float4(_Property_53dfc4b4cafc4a9496bd9fde6989ee8f_Out_0, _Property_601193b6811a41eeb79befed4e93080a_Out_0, (_Preview_0af5c98f89c44402ab2012c583d6f212_Out_1.xxxx), _Lerp_c2c00306fc734b0c8dee546205970ae6_Out_3);
            float4 _Property_72f89d8f335a4977a093f3bae7ef5ea1_Out_0 = Color_2bad1140d6ae465a8b096ead483f5370;
            float4 _Property_8d638ca6b7cc402595ddc523b14de263_Out_0 = Color_1;
            float4 _Lerp_25807026701046b7a4a6abcec2069726_Out_3;
            Unity_Lerp_float4(_Property_72f89d8f335a4977a093f3bae7ef5ea1_Out_0, _Property_8d638ca6b7cc402595ddc523b14de263_Out_0, (_Preview_0af5c98f89c44402ab2012c583d6f212_Out_1.xxxx), _Lerp_25807026701046b7a4a6abcec2069726_Out_3);
            float _SceneDepth_91aa5f89e7564cb2ac5171231a24afdf_Out_1;
            Unity_SceneDepth_Linear01_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_91aa5f89e7564cb2ac5171231a24afdf_Out_1);
            float _Multiply_619704251bdd44e6a8e9f02add36789c_Out_2;
            Unity_Multiply_float_float(_SceneDepth_91aa5f89e7564cb2ac5171231a24afdf_Out_1, _ProjectionParams.z, _Multiply_619704251bdd44e6a8e9f02add36789c_Out_2);
            float4 _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0 = IN.ScreenPosition;
            float _Split_eb526920998f41cd825cbe42160042f5_R_1 = _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0[0];
            float _Split_eb526920998f41cd825cbe42160042f5_G_2 = _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0[1];
            float _Split_eb526920998f41cd825cbe42160042f5_B_3 = _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0[2];
            float _Split_eb526920998f41cd825cbe42160042f5_A_4 = _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0[3];
            float _Property_f4dad9c86f154090a77929fc0594d2eb_Out_0 = Vector1_f108b0f6f7ad4a0fa7970936cde8c93a;
            float _Add_1d0b28a6a0fe41b9aea6de0b9a290419_Out_2;
            Unity_Add_float(_Split_eb526920998f41cd825cbe42160042f5_A_4, _Property_f4dad9c86f154090a77929fc0594d2eb_Out_0, _Add_1d0b28a6a0fe41b9aea6de0b9a290419_Out_2);
            float _Subtract_c310e84b25994cf7969fb6aec3c12631_Out_2;
            Unity_Subtract_float(_Multiply_619704251bdd44e6a8e9f02add36789c_Out_2, _Add_1d0b28a6a0fe41b9aea6de0b9a290419_Out_2, _Subtract_c310e84b25994cf7969fb6aec3c12631_Out_2);
            float _Property_e2cb78357bf54371b95b04624c624355_Out_0 = Vector1_77a8669616464cc68eec17e9163052aa;
            float _Multiply_77d88fee04a2411ebf64a9f3cf93ee09_Out_2;
            Unity_Multiply_float_float(_Subtract_c310e84b25994cf7969fb6aec3c12631_Out_2, _Property_e2cb78357bf54371b95b04624c624355_Out_0, _Multiply_77d88fee04a2411ebf64a9f3cf93ee09_Out_2);
            float _Clamp_5c303e7a7ab74c80819cff967500a688_Out_3;
            Unity_Clamp_float(_Multiply_77d88fee04a2411ebf64a9f3cf93ee09_Out_2, 0, 1, _Clamp_5c303e7a7ab74c80819cff967500a688_Out_3);
            float4 _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3;
            Unity_Lerp_float4(_Lerp_c2c00306fc734b0c8dee546205970ae6_Out_3, _Lerp_25807026701046b7a4a6abcec2069726_Out_3, (_Clamp_5c303e7a7ab74c80819cff967500a688_Out_3.xxxx), _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3);
            float _Split_32fd3b93931741f5ba645cdab3f37d0f_R_1 = _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3[0];
            float _Split_32fd3b93931741f5ba645cdab3f37d0f_G_2 = _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3[1];
            float _Split_32fd3b93931741f5ba645cdab3f37d0f_B_3 = _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3[2];
            float _Split_32fd3b93931741f5ba645cdab3f37d0f_A_4 = _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3[3];
            surface.Alpha = _Split_32fd3b93931741f5ba645cdab3f37d0f_A_4;
            surface.AlphaClipThreshold = 0;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
            output.uv0 =                                        input.uv0;
            output.TimeParameters =                             _TimeParameters.xyz;
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
        
        
            output.WorldSpacePosition = input.positionWS;
            output.ScreenPosition = ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
            output.uv0 = input.texCoord0;
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/SelectionPickingPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            // Name: <None>
            Tags
            {
                "LightMode" = "Universal2D"
            }
        
        // Render State
        Cull Back
        Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
        ZTest LEqual
        ZWrite Off
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 4.5
        #pragma exclude_renderers gles gles3 glcore
        #pragma vertex vert
        #pragma fragment frag
        
        // DotsInstancingOptions: <None>
        // HybridV1InjectedBuiltinProperties: <None>
        
        // Keywords
        // PassKeywords: <None>
        // GraphKeywords: <None>
        
        // Defines
        
        #define _NORMALMAP 1
        #define _NORMAL_DROPOFF_TS 1
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define VARYINGS_NEED_POSITION_WS
        #define VARYINGS_NEED_TEXCOORD0
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_2D
        #define _ALPHATEST_ON 1
        #define REQUIRE_DEPTH_TEXTURE
        #define REQUIRE_OPAQUE_TEXTURE
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float3 positionWS;
             float4 texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
             float2 MainNormal;
             float2 SecondNormal;
        };
        struct SurfaceDescriptionInputs
        {
             float3 WorldSpacePosition;
             float4 ScreenPosition;
             float4 uv0;
             float2 MainNormal;
             float2 SecondNormal;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
             float4 uv0;
             float3 TimeParameters;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float3 interp0 : INTERP0;
             float4 interp1 : INTERP1;
             float4 interp2 : INTERP2;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.positionWS;
            output.interp1.xyzw =  input.texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            output.interp2.xy =  input.MainNormal;
            output.interp2.zw =  input.SecondNormal;
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.positionWS = input.interp0.xyz;
            output.texCoord0 = input.interp1.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            output.MainNormal = input.interp2.xy;
            output.SecondNormal = input.interp2.zw;
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float4 _PlanarReflectionTexture_TexelSize;
        float Vector1_f108b0f6f7ad4a0fa7970936cde8c93a;
        float Vector1_77a8669616464cc68eec17e9163052aa;
        float4 Color_2bad1140d6ae465a8b096ead483f5370;
        float4 Color_b5081859698940efa07a6cc68ff92e70;
        float4 Color_1;
        float4 Texture2D_2d2e087224e24282b84a086f3316e6e8_TexelSize;
        float2 Vector2_c2fe4e7c2a7649b28d7ab078fdadda1c;
        float Vector1_7614a6098dec470e8a4e96a5c8551362;
        float4 Texture2D_21a78e051aa84ab49c73d2364e78102f_TexelSize;
        float2 Vector2_73fa27b3bcf64608a50eed7c1d0d3411;
        float Vector1_898460d8305d4dfe9af1298eb6f67082;
        float Vector1_0360d732cbbf426e841ca433b0e337aa;
        float Vector1_dcce861f82224ec1ac55aa94df3b3d12;
        float Vector1_3606b8114ded4a74a4e4834f8bf7dc12;
        float Vector1_69bcaf9cf50f40a2bef27afe006bbc8f;
        float4 Color_6e3aa9f38d68448bb94d493ef4e3c30a;
        float Vector1_0d98869735ab4e73a0e4bb36589d00c0;
        float Vector1_aace7401fb3a402e9f06de96963c9b84;
        float4 Texture2D_d65eb6e07c30447ca446c38272609586_TexelSize;
        float2 Vector2_2832e3b0590c4ee98f806b14c0f54c5b;
        float4 _Shallow_Water_Color_2;
        float2 _Panning;
        float _DistortionSpeed;
        float _DistortionIntensity;
        float2 _FoamNoiseTilling;
        float _DistortionScale;
        float _NoiseScale;
        float _Layer1_Scale;
        float _Layer2_Scale;
        float _RefractionDistrotion;
        float _Relection_Strength;
        CBUFFER_END
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_PlanarReflectionTexture);
        SAMPLER(sampler_PlanarReflectionTexture);
        TEXTURE2D(Texture2D_2d2e087224e24282b84a086f3316e6e8);
        SAMPLER(samplerTexture2D_2d2e087224e24282b84a086f3316e6e8);
        TEXTURE2D(Texture2D_21a78e051aa84ab49c73d2364e78102f);
        SAMPLER(samplerTexture2D_21a78e051aa84ab49c73d2364e78102f);
        TEXTURE2D(Texture2D_d65eb6e07c30447ca446c38272609586);
        SAMPLER(samplerTexture2D_d65eb6e07c30447ca446c38272609586);
        
        // Graph Includes
        // GraphIncludes: <None>
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        
        float2 Unity_GradientNoise_Dir_float(float2 p)
        {
            // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
            p = p % 289;
            // need full precision, otherwise half overflows when p > 1
            float x = float(34 * p.x + 1) * p.x % 289 + p.y;
            x = (34 * x + 1) * x % 289;
            x = frac(x / 41) * 2 - 1;
            return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
        }
        
        void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
        {
            float2 p = UV * Scale;
            float2 ip = floor(p);
            float2 fp = frac(p);
            float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
            float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
            float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
            float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
            fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
            Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }
        
        void Unity_Preview_float(float In, out float Out)
        {
            Out = In;
        }
        
        void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
        {
            Out = lerp(A, B, T);
        }
        
        void Unity_SceneDepth_Linear01_float(float4 UV, out float Out)
        {
            Out = Linear01Depth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }
        
        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }
        
        void Unity_Add_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A + B;
        }
        
        void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
        {
            Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
        }
        
        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }
        
        void Unity_SceneColor_float(float4 UV, out float3 Out)
        {
            Out = SHADERGRAPH_SAMPLE_SCENE_COLOR(UV.xy);
        }
        
        void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
        {
            Out = lerp(A, B, T);
        }
        
        void Unity_Blend_Multiply_float3(float3 Base, float3 Blend, out float3 Out, float Opacity)
        {
            Out = Base * Blend;
            Out = lerp(Base, Out, Opacity);
        }
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
            float2 MainNormal;
            float2 SecondNormal;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            float _Property_8a79f817e59948938215b338bcdc46df_Out_0 = Vector1_898460d8305d4dfe9af1298eb6f67082;
            float _Multiply_ed606ef7153b456b854854134a8f65f9_Out_2;
            Unity_Multiply_float_float(_Property_8a79f817e59948938215b338bcdc46df_Out_0, 0.01, _Multiply_ed606ef7153b456b854854134a8f65f9_Out_2);
            float2 _Property_0264c1738ed14b318538f5f39eb56d07_Out_0 = Vector2_73fa27b3bcf64608a50eed7c1d0d3411;
            float _Divide_d29c49a16f234ef78eee8f12e556a643_Out_2;
            Unity_Divide_float(IN.TimeParameters.x, 5, _Divide_d29c49a16f234ef78eee8f12e556a643_Out_2);
            float _Multiply_5928ff83990b4a61bfdfa392f6154eda_Out_2;
            Unity_Multiply_float_float(_Divide_d29c49a16f234ef78eee8f12e556a643_Out_2, _Multiply_ed606ef7153b456b854854134a8f65f9_Out_2, _Multiply_5928ff83990b4a61bfdfa392f6154eda_Out_2);
            float2 _TilingAndOffset_08fa9dddbfc44f8b9e671e082ef10419_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Property_0264c1738ed14b318538f5f39eb56d07_Out_0, (_Multiply_5928ff83990b4a61bfdfa392f6154eda_Out_2.xx), _TilingAndOffset_08fa9dddbfc44f8b9e671e082ef10419_Out_3);
            float _Property_32d848f89d264e118a7bc7b7cbae9677_Out_0 = Vector1_7614a6098dec470e8a4e96a5c8551362;
            float _Multiply_1541a6ad358e4ea281033d8831f2ba13_Out_2;
            Unity_Multiply_float_float(_Property_32d848f89d264e118a7bc7b7cbae9677_Out_0, -0.01, _Multiply_1541a6ad358e4ea281033d8831f2ba13_Out_2);
            float _Multiply_edd1ffe542204260a884842fd7a18fc1_Out_2;
            Unity_Multiply_float_float(_Multiply_1541a6ad358e4ea281033d8831f2ba13_Out_2, _Divide_d29c49a16f234ef78eee8f12e556a643_Out_2, _Multiply_edd1ffe542204260a884842fd7a18fc1_Out_2);
            float2 _Property_123c8148386d41aa9d1698d86033f0b5_Out_0 = Vector2_c2fe4e7c2a7649b28d7ab078fdadda1c;
            float2 _TilingAndOffset_924ee153284a4d4abbd47514c96bb1ae_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Property_123c8148386d41aa9d1698d86033f0b5_Out_0, (_Multiply_edd1ffe542204260a884842fd7a18fc1_Out_2.xx), _TilingAndOffset_924ee153284a4d4abbd47514c96bb1ae_Out_3);
            float _Split_d8eed8fe26594972914c124586d98bbf_R_1 = IN.ObjectSpacePosition[0];
            float _Split_d8eed8fe26594972914c124586d98bbf_G_2 = IN.ObjectSpacePosition[1];
            float _Split_d8eed8fe26594972914c124586d98bbf_B_3 = IN.ObjectSpacePosition[2];
            float _Split_d8eed8fe26594972914c124586d98bbf_A_4 = 0;
            float _Property_762630e6999b4da0a14b2ccffa4209d8_Out_0 = Vector1_dcce861f82224ec1ac55aa94df3b3d12;
            float _Divide_df746930d1d841c09a66286a0a3543ae_Out_2;
            Unity_Divide_float(_Property_762630e6999b4da0a14b2ccffa4209d8_Out_0, 200, _Divide_df746930d1d841c09a66286a0a3543ae_Out_2);
            float _Property_d73cd49e4412457080da3ad6f38ac94b_Out_0 = Vector1_3606b8114ded4a74a4e4834f8bf7dc12;
            float _Divide_b14ec7aec4874b8ab4371962384288e5_Out_2;
            Unity_Divide_float(_Property_d73cd49e4412457080da3ad6f38ac94b_Out_0, 50, _Divide_b14ec7aec4874b8ab4371962384288e5_Out_2);
            float _Multiply_f97f597155bf4b59afa13426042ec0a0_Out_2;
            Unity_Multiply_float_float(IN.TimeParameters.x, _Divide_b14ec7aec4874b8ab4371962384288e5_Out_2, _Multiply_f97f597155bf4b59afa13426042ec0a0_Out_2);
            float2 _TilingAndOffset_ab2fed3c342049de89287a73af5f4dd1_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, (_Multiply_f97f597155bf4b59afa13426042ec0a0_Out_2.xx), float2 (0, 0), _TilingAndOffset_ab2fed3c342049de89287a73af5f4dd1_Out_3);
            float _GradientNoise_c349a7da229a42f6acfd0e9329f501a7_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_ab2fed3c342049de89287a73af5f4dd1_Out_3, 0.96, _GradientNoise_c349a7da229a42f6acfd0e9329f501a7_Out_2);
            float _Multiply_9460f57a023144a9ae646cb7ff3c8354_Out_2;
            Unity_Multiply_float_float(_Divide_df746930d1d841c09a66286a0a3543ae_Out_2, _GradientNoise_c349a7da229a42f6acfd0e9329f501a7_Out_2, _Multiply_9460f57a023144a9ae646cb7ff3c8354_Out_2);
            float _Add_5cf9a595f1104a0ba7d0c02acbf47625_Out_2;
            Unity_Add_float(_Split_d8eed8fe26594972914c124586d98bbf_G_2, _Multiply_9460f57a023144a9ae646cb7ff3c8354_Out_2, _Add_5cf9a595f1104a0ba7d0c02acbf47625_Out_2);
            float4 _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGBA_4;
            float3 _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGB_5;
            float2 _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RG_6;
            Unity_Combine_float(_Split_d8eed8fe26594972914c124586d98bbf_R_1, _Add_5cf9a595f1104a0ba7d0c02acbf47625_Out_2, _Split_d8eed8fe26594972914c124586d98bbf_B_3, 0, _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGBA_4, _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGB_5, _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RG_6);
            description.Position = _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGB_5;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            description.MainNormal = _TilingAndOffset_924ee153284a4d4abbd47514c96bb1ae_Out_3;
            description.SecondNormal = _TilingAndOffset_08fa9dddbfc44f8b9e671e082ef10419_Out_3;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        output.MainNormal = input.MainNormal;
        output.SecondNormal = input.SecondNormal;
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float3 BaseColor;
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float4 _Property_53dfc4b4cafc4a9496bd9fde6989ee8f_Out_0 = Color_b5081859698940efa07a6cc68ff92e70;
            float4 _Property_601193b6811a41eeb79befed4e93080a_Out_0 = _Shallow_Water_Color_2;
            float4 _UV_0459ed23840544d4943e249e6bf3def0_Out_0 = IN.uv0;
            float _Split_95c75a1ea7ee4dd7906396bff762bd25_R_1 = _UV_0459ed23840544d4943e249e6bf3def0_Out_0[0];
            float _Split_95c75a1ea7ee4dd7906396bff762bd25_G_2 = _UV_0459ed23840544d4943e249e6bf3def0_Out_0[1];
            float _Split_95c75a1ea7ee4dd7906396bff762bd25_B_3 = _UV_0459ed23840544d4943e249e6bf3def0_Out_0[2];
            float _Split_95c75a1ea7ee4dd7906396bff762bd25_A_4 = _UV_0459ed23840544d4943e249e6bf3def0_Out_0[3];
            float _Preview_0af5c98f89c44402ab2012c583d6f212_Out_1;
            Unity_Preview_float(_Split_95c75a1ea7ee4dd7906396bff762bd25_G_2, _Preview_0af5c98f89c44402ab2012c583d6f212_Out_1);
            float4 _Lerp_c2c00306fc734b0c8dee546205970ae6_Out_3;
            Unity_Lerp_float4(_Property_53dfc4b4cafc4a9496bd9fde6989ee8f_Out_0, _Property_601193b6811a41eeb79befed4e93080a_Out_0, (_Preview_0af5c98f89c44402ab2012c583d6f212_Out_1.xxxx), _Lerp_c2c00306fc734b0c8dee546205970ae6_Out_3);
            float4 _Property_72f89d8f335a4977a093f3bae7ef5ea1_Out_0 = Color_2bad1140d6ae465a8b096ead483f5370;
            float4 _Property_8d638ca6b7cc402595ddc523b14de263_Out_0 = Color_1;
            float4 _Lerp_25807026701046b7a4a6abcec2069726_Out_3;
            Unity_Lerp_float4(_Property_72f89d8f335a4977a093f3bae7ef5ea1_Out_0, _Property_8d638ca6b7cc402595ddc523b14de263_Out_0, (_Preview_0af5c98f89c44402ab2012c583d6f212_Out_1.xxxx), _Lerp_25807026701046b7a4a6abcec2069726_Out_3);
            float _SceneDepth_91aa5f89e7564cb2ac5171231a24afdf_Out_1;
            Unity_SceneDepth_Linear01_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_91aa5f89e7564cb2ac5171231a24afdf_Out_1);
            float _Multiply_619704251bdd44e6a8e9f02add36789c_Out_2;
            Unity_Multiply_float_float(_SceneDepth_91aa5f89e7564cb2ac5171231a24afdf_Out_1, _ProjectionParams.z, _Multiply_619704251bdd44e6a8e9f02add36789c_Out_2);
            float4 _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0 = IN.ScreenPosition;
            float _Split_eb526920998f41cd825cbe42160042f5_R_1 = _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0[0];
            float _Split_eb526920998f41cd825cbe42160042f5_G_2 = _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0[1];
            float _Split_eb526920998f41cd825cbe42160042f5_B_3 = _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0[2];
            float _Split_eb526920998f41cd825cbe42160042f5_A_4 = _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0[3];
            float _Property_f4dad9c86f154090a77929fc0594d2eb_Out_0 = Vector1_f108b0f6f7ad4a0fa7970936cde8c93a;
            float _Add_1d0b28a6a0fe41b9aea6de0b9a290419_Out_2;
            Unity_Add_float(_Split_eb526920998f41cd825cbe42160042f5_A_4, _Property_f4dad9c86f154090a77929fc0594d2eb_Out_0, _Add_1d0b28a6a0fe41b9aea6de0b9a290419_Out_2);
            float _Subtract_c310e84b25994cf7969fb6aec3c12631_Out_2;
            Unity_Subtract_float(_Multiply_619704251bdd44e6a8e9f02add36789c_Out_2, _Add_1d0b28a6a0fe41b9aea6de0b9a290419_Out_2, _Subtract_c310e84b25994cf7969fb6aec3c12631_Out_2);
            float _Property_e2cb78357bf54371b95b04624c624355_Out_0 = Vector1_77a8669616464cc68eec17e9163052aa;
            float _Multiply_77d88fee04a2411ebf64a9f3cf93ee09_Out_2;
            Unity_Multiply_float_float(_Subtract_c310e84b25994cf7969fb6aec3c12631_Out_2, _Property_e2cb78357bf54371b95b04624c624355_Out_0, _Multiply_77d88fee04a2411ebf64a9f3cf93ee09_Out_2);
            float _Clamp_5c303e7a7ab74c80819cff967500a688_Out_3;
            Unity_Clamp_float(_Multiply_77d88fee04a2411ebf64a9f3cf93ee09_Out_2, 0, 1, _Clamp_5c303e7a7ab74c80819cff967500a688_Out_3);
            float4 _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3;
            Unity_Lerp_float4(_Lerp_c2c00306fc734b0c8dee546205970ae6_Out_3, _Lerp_25807026701046b7a4a6abcec2069726_Out_3, (_Clamp_5c303e7a7ab74c80819cff967500a688_Out_3.xxxx), _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3);
            UnityTexture2D _Property_691307347e93408bb228020d56a4f64e_Out_0 = UnityBuildTexture2DStructNoScale(Texture2D_2d2e087224e24282b84a086f3316e6e8);
            float4 _SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0 = SAMPLE_TEXTURE2D(_Property_691307347e93408bb228020d56a4f64e_Out_0.tex, _Property_691307347e93408bb228020d56a4f64e_Out_0.samplerstate, _Property_691307347e93408bb228020d56a4f64e_Out_0.GetTransformedUV(IN.MainNormal));
            _SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0);
            float _SampleTexture2D_3802527e187e464aa45999485a38f24f_R_4 = _SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0.r;
            float _SampleTexture2D_3802527e187e464aa45999485a38f24f_G_5 = _SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0.g;
            float _SampleTexture2D_3802527e187e464aa45999485a38f24f_B_6 = _SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0.b;
            float _SampleTexture2D_3802527e187e464aa45999485a38f24f_A_7 = _SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0.a;
            UnityTexture2D _Property_162be1870c564d31abda704370ecd112_Out_0 = UnityBuildTexture2DStructNoScale(Texture2D_21a78e051aa84ab49c73d2364e78102f);
            float4 _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0 = SAMPLE_TEXTURE2D(_Property_162be1870c564d31abda704370ecd112_Out_0.tex, _Property_162be1870c564d31abda704370ecd112_Out_0.samplerstate, _Property_162be1870c564d31abda704370ecd112_Out_0.GetTransformedUV(IN.SecondNormal));
            _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0);
            float _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_R_4 = _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0.r;
            float _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_G_5 = _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0.g;
            float _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_B_6 = _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0.b;
            float _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_A_7 = _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0.a;
            float4 _Add_357900c2d36f40c0b7995aceda820c48_Out_2;
            Unity_Add_float4(_SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0, _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0, _Add_357900c2d36f40c0b7995aceda820c48_Out_2);
            float _Property_bcb4a350b8234af79860039f232f70bb_Out_0 = Vector1_0360d732cbbf426e841ca433b0e337aa;
            float3 _NormalStrength_353fbbdfa63c4bf1a26d328b90d65d75_Out_2;
            Unity_NormalStrength_float((_Add_357900c2d36f40c0b7995aceda820c48_Out_2.xyz), _Property_bcb4a350b8234af79860039f232f70bb_Out_0, _NormalStrength_353fbbdfa63c4bf1a26d328b90d65d75_Out_2);
            float _Property_435f8911f9614444bccaa1b491910830_Out_0 = _RefractionDistrotion;
            float3 _NormalStrength_c661b7411e0343adbe9cd03e17ec5587_Out_2;
            Unity_NormalStrength_float(_NormalStrength_353fbbdfa63c4bf1a26d328b90d65d75_Out_2, _Property_435f8911f9614444bccaa1b491910830_Out_0, _NormalStrength_c661b7411e0343adbe9cd03e17ec5587_Out_2);
            float4 _ScreenPosition_8195cd06776241d5b37929c91c6dad48_Out_0 = float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0);
            float3 _Add_b257228ea21d4b4d977a6133326b7e06_Out_2;
            Unity_Add_float3(_NormalStrength_c661b7411e0343adbe9cd03e17ec5587_Out_2, (_ScreenPosition_8195cd06776241d5b37929c91c6dad48_Out_0.xyz), _Add_b257228ea21d4b4d977a6133326b7e06_Out_2);
            float3 _SceneColor_2c332a05662541f2bba2d1b5eeb47bd2_Out_1;
            Unity_SceneColor_float((float4(_Add_b257228ea21d4b4d977a6133326b7e06_Out_2, 1.0)), _SceneColor_2c332a05662541f2bba2d1b5eeb47bd2_Out_1);
            UnityTexture2D _Property_c55f1526f461489aa2011515ec7da3a3_Out_0 = UnityBuildTexture2DStructNoScale(_PlanarReflectionTexture);
            float3 _Add_9cc9802b3ef24c21b8771b375a3bff42_Out_2;
            Unity_Add_float3(_NormalStrength_353fbbdfa63c4bf1a26d328b90d65d75_Out_2, (_Clamp_5c303e7a7ab74c80819cff967500a688_Out_3.xxx), _Add_9cc9802b3ef24c21b8771b375a3bff42_Out_2);
            float3 _NormalStrength_6161489259bb4747ba0928987b51a0ea_Out_2;
            Unity_NormalStrength_float(_Add_9cc9802b3ef24c21b8771b375a3bff42_Out_2, _Property_435f8911f9614444bccaa1b491910830_Out_0, _NormalStrength_6161489259bb4747ba0928987b51a0ea_Out_2);
            float3 _Add_51f05a9faaf74e72812fae8a48ed882c_Out_2;
            Unity_Add_float3((_ScreenPosition_8195cd06776241d5b37929c91c6dad48_Out_0.xyz), _NormalStrength_6161489259bb4747ba0928987b51a0ea_Out_2, _Add_51f05a9faaf74e72812fae8a48ed882c_Out_2);
            float4 _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_RGBA_0 = SAMPLE_TEXTURE2D(_Property_c55f1526f461489aa2011515ec7da3a3_Out_0.tex, _Property_c55f1526f461489aa2011515ec7da3a3_Out_0.samplerstate, _Property_c55f1526f461489aa2011515ec7da3a3_Out_0.GetTransformedUV((_Add_51f05a9faaf74e72812fae8a48ed882c_Out_2.xy)));
            float _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_R_4 = _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_RGBA_0.r;
            float _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_G_5 = _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_RGBA_0.g;
            float _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_B_6 = _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_RGBA_0.b;
            float _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_A_7 = _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_RGBA_0.a;
            float3 _Lerp_6bca2423774749ccb6b3d02c089ca6aa_Out_3;
            Unity_Lerp_float3(_SceneColor_2c332a05662541f2bba2d1b5eeb47bd2_Out_1, (_SampleTexture2D_60a5b90e4760409a9760488b39b95feb_RGBA_0.xyz), (_Clamp_5c303e7a7ab74c80819cff967500a688_Out_3.xxx), _Lerp_6bca2423774749ccb6b3d02c089ca6aa_Out_3);
            float _Property_4267d14b41a64c8faa1146ffbcfe3618_Out_0 = _Relection_Strength;
            float3 _Blend_1d413404067041f1a38d59c008106e23_Out_2;
            Unity_Blend_Multiply_float3((_Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3.xyz), _Lerp_6bca2423774749ccb6b3d02c089ca6aa_Out_3, _Blend_1d413404067041f1a38d59c008106e23_Out_2, _Property_4267d14b41a64c8faa1146ffbcfe3618_Out_0);
            float _Split_32fd3b93931741f5ba645cdab3f37d0f_R_1 = _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3[0];
            float _Split_32fd3b93931741f5ba645cdab3f37d0f_G_2 = _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3[1];
            float _Split_32fd3b93931741f5ba645cdab3f37d0f_B_3 = _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3[2];
            float _Split_32fd3b93931741f5ba645cdab3f37d0f_A_4 = _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3[3];
            surface.BaseColor = _Blend_1d413404067041f1a38d59c008106e23_Out_2;
            surface.Alpha = _Split_32fd3b93931741f5ba645cdab3f37d0f_A_4;
            surface.AlphaClipThreshold = 0;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
            output.uv0 =                                        input.uv0;
            output.TimeParameters =                             _TimeParameters.xyz;
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            output.MainNormal = input.MainNormal;
        output.SecondNormal = input.SecondNormal;
        
        
        
        
        
            output.WorldSpacePosition = input.positionWS;
            output.ScreenPosition = ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
            output.uv0 = input.texCoord0;
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBR2DPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
    }
    SubShader
    {
        Tags
        {
            "RenderPipeline"="UniversalPipeline"
            "RenderType"="Transparent"
            "UniversalMaterialType" = "Lit"
            "Queue"="Transparent"
            "ShaderGraphShader"="true"
            "ShaderGraphTargetId"="UniversalLitSubTarget"
        }
        Pass
        {
            Name "Universal Forward"
            Tags
            {
                "LightMode" = "UniversalForward"
            }
        
        // Render State
        Cull Back
        Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
        ZTest LEqual
        ZWrite Off
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 2.0
        #pragma only_renderers gles gles3 glcore d3d11
        #pragma multi_compile_instancing
        #pragma multi_compile_fog
        #pragma instancing_options renderinglayer
        #pragma vertex vert
        #pragma fragment frag
        
        // DotsInstancingOptions: <None>
        // HybridV1InjectedBuiltinProperties: <None>
        
        // Keywords
        #pragma multi_compile _ _SCREEN_SPACE_OCCLUSION
        #pragma multi_compile _ LIGHTMAP_ON
        #pragma multi_compile _ DYNAMICLIGHTMAP_ON
        #pragma multi_compile _ DIRLIGHTMAP_COMBINED
        #pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN
        #pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
        #pragma multi_compile _ _ADDITIONAL_LIGHT_SHADOWS
        #pragma multi_compile _ _REFLECTION_PROBE_BLENDING
        #pragma multi_compile _ _REFLECTION_PROBE_BOX_PROJECTION
        #pragma multi_compile _ _SHADOWS_SOFT
        #pragma multi_compile _ LIGHTMAP_SHADOW_MIXING
        #pragma multi_compile _ SHADOWS_SHADOWMASK
        #pragma multi_compile _ _DBUFFER_MRT1 _DBUFFER_MRT2 _DBUFFER_MRT3
        #pragma multi_compile _ _LIGHT_LAYERS
        #pragma multi_compile _ DEBUG_DISPLAY
        #pragma multi_compile _ _LIGHT_COOKIES
        #pragma multi_compile _ _CLUSTERED_RENDERING
        // GraphKeywords: <None>
        
        // Defines
        
        #define _NORMALMAP 1
        #define _NORMAL_DROPOFF_TS 1
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define ATTRIBUTES_NEED_TEXCOORD1
        #define ATTRIBUTES_NEED_TEXCOORD2
        #define VARYINGS_NEED_POSITION_WS
        #define VARYINGS_NEED_NORMAL_WS
        #define VARYINGS_NEED_TANGENT_WS
        #define VARYINGS_NEED_TEXCOORD0
        #define VARYINGS_NEED_VIEWDIRECTION_WS
        #define VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
        #define VARYINGS_NEED_SHADOW_COORD
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_FORWARD
        #define _FOG_FRAGMENT 1
        #define _SURFACE_TYPE_TRANSPARENT 1
        #define _ALPHATEST_ON 1
        #define REQUIRE_DEPTH_TEXTURE
        #define REQUIRE_OPAQUE_TEXTURE
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DBuffer.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
             float4 uv1 : TEXCOORD1;
             float4 uv2 : TEXCOORD2;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float3 positionWS;
             float3 normalWS;
             float4 tangentWS;
             float4 texCoord0;
             float3 viewDirectionWS;
            #if defined(LIGHTMAP_ON)
             float2 staticLightmapUV;
            #endif
            #if defined(DYNAMICLIGHTMAP_ON)
             float2 dynamicLightmapUV;
            #endif
            #if !defined(LIGHTMAP_ON)
             float3 sh;
            #endif
             float4 fogFactorAndVertexLight;
            #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
             float4 shadowCoord;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
             float2 MainNormal;
             float2 SecondNormal;
             float2 FoamDirection1;
             float2 FoamDirection2;
        };
        struct SurfaceDescriptionInputs
        {
             float3 TangentSpaceNormal;
             float3 WorldSpacePosition;
             float4 ScreenPosition;
             float4 uv0;
             float2 MainNormal;
             float2 SecondNormal;
             float2 FoamDirection1;
             float2 FoamDirection2;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
             float3 AbsoluteWorldSpacePosition;
             float4 uv0;
             float3 TimeParameters;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float3 interp0 : INTERP0;
             float3 interp1 : INTERP1;
             float4 interp2 : INTERP2;
             float4 interp3 : INTERP3;
             float3 interp4 : INTERP4;
             float4 interp5 : INTERP5;
             float4 interp6 : INTERP6;
             float3 interp7 : INTERP7;
             float4 interp8 : INTERP8;
             float4 interp9 : INTERP9;
             float4 interp10 : INTERP10;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.positionWS;
            output.interp1.xyz =  input.normalWS;
            output.interp2.xyzw =  input.tangentWS;
            output.interp3.xyzw =  input.texCoord0;
            output.interp4.xyz =  input.viewDirectionWS;
            #if defined(LIGHTMAP_ON)
            output.interp5.xy =  input.staticLightmapUV;
            #endif
            #if defined(DYNAMICLIGHTMAP_ON)
            output.interp6.xy =  input.dynamicLightmapUV;
            #endif
            #if !defined(LIGHTMAP_ON)
            output.interp7.xyz =  input.sh;
            #endif
            output.interp8.xyzw =  input.fogFactorAndVertexLight;
            #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
            output.interp9.xyzw =  input.shadowCoord;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            output.interp5.zw =  input.MainNormal;
            output.interp6.zw =  input.SecondNormal;
            output.interp10.xy =  input.FoamDirection1;
            output.interp10.zw =  input.FoamDirection2;
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.positionWS = input.interp0.xyz;
            output.normalWS = input.interp1.xyz;
            output.tangentWS = input.interp2.xyzw;
            output.texCoord0 = input.interp3.xyzw;
            output.viewDirectionWS = input.interp4.xyz;
            #if defined(LIGHTMAP_ON)
            output.staticLightmapUV = input.interp5.xy;
            #endif
            #if defined(DYNAMICLIGHTMAP_ON)
            output.dynamicLightmapUV = input.interp6.xy;
            #endif
            #if !defined(LIGHTMAP_ON)
            output.sh = input.interp7.xyz;
            #endif
            output.fogFactorAndVertexLight = input.interp8.xyzw;
            #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
            output.shadowCoord = input.interp9.xyzw;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            output.MainNormal = input.interp5.zw;
            output.SecondNormal = input.interp6.zw;
            output.FoamDirection1 = input.interp10.xy;
            output.FoamDirection2 = input.interp10.zw;
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float4 _PlanarReflectionTexture_TexelSize;
        float Vector1_f108b0f6f7ad4a0fa7970936cde8c93a;
        float Vector1_77a8669616464cc68eec17e9163052aa;
        float4 Color_2bad1140d6ae465a8b096ead483f5370;
        float4 Color_b5081859698940efa07a6cc68ff92e70;
        float4 Color_1;
        float4 Texture2D_2d2e087224e24282b84a086f3316e6e8_TexelSize;
        float2 Vector2_c2fe4e7c2a7649b28d7ab078fdadda1c;
        float Vector1_7614a6098dec470e8a4e96a5c8551362;
        float4 Texture2D_21a78e051aa84ab49c73d2364e78102f_TexelSize;
        float2 Vector2_73fa27b3bcf64608a50eed7c1d0d3411;
        float Vector1_898460d8305d4dfe9af1298eb6f67082;
        float Vector1_0360d732cbbf426e841ca433b0e337aa;
        float Vector1_dcce861f82224ec1ac55aa94df3b3d12;
        float Vector1_3606b8114ded4a74a4e4834f8bf7dc12;
        float Vector1_69bcaf9cf50f40a2bef27afe006bbc8f;
        float4 Color_6e3aa9f38d68448bb94d493ef4e3c30a;
        float Vector1_0d98869735ab4e73a0e4bb36589d00c0;
        float Vector1_aace7401fb3a402e9f06de96963c9b84;
        float4 Texture2D_d65eb6e07c30447ca446c38272609586_TexelSize;
        float2 Vector2_2832e3b0590c4ee98f806b14c0f54c5b;
        float4 _Shallow_Water_Color_2;
        float2 _Panning;
        float _DistortionSpeed;
        float _DistortionIntensity;
        float2 _FoamNoiseTilling;
        float _DistortionScale;
        float _NoiseScale;
        float _Layer1_Scale;
        float _Layer2_Scale;
        float _RefractionDistrotion;
        float _Relection_Strength;
        CBUFFER_END
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_PlanarReflectionTexture);
        SAMPLER(sampler_PlanarReflectionTexture);
        TEXTURE2D(Texture2D_2d2e087224e24282b84a086f3316e6e8);
        SAMPLER(samplerTexture2D_2d2e087224e24282b84a086f3316e6e8);
        TEXTURE2D(Texture2D_21a78e051aa84ab49c73d2364e78102f);
        SAMPLER(samplerTexture2D_21a78e051aa84ab49c73d2364e78102f);
        TEXTURE2D(Texture2D_d65eb6e07c30447ca446c38272609586);
        SAMPLER(samplerTexture2D_d65eb6e07c30447ca446c38272609586);
        
        // Graph Includes
        // GraphIncludes: <None>
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        
        inline float Unity_SimpleNoise_RandomValue_float (float2 uv)
        {
            float angle = dot(uv, float2(12.9898, 78.233));
            #if defined(SHADER_API_MOBILE) && (defined(SHADER_API_GLES) || defined(SHADER_API_GLES3) || defined(SHADER_API_VULKAN))
                // 'sin()' has bad precision on Mali GPUs for inputs > 10000
                angle = fmod(angle, TWO_PI); // Avoid large inputs to sin()
            #endif
            return frac(sin(angle)*43758.5453);
        }
        
        inline float Unity_SimpleNnoise_Interpolate_float (float a, float b, float t)
        {
            return (1.0-t)*a + (t*b);
        }
        
        
        inline float Unity_SimpleNoise_ValueNoise_float (float2 uv)
        {
            float2 i = floor(uv);
            float2 f = frac(uv);
            f = f * f * (3.0 - 2.0 * f);
        
            uv = abs(frac(uv) - 0.5);
            float2 c0 = i + float2(0.0, 0.0);
            float2 c1 = i + float2(1.0, 0.0);
            float2 c2 = i + float2(0.0, 1.0);
            float2 c3 = i + float2(1.0, 1.0);
            float r0 = Unity_SimpleNoise_RandomValue_float(c0);
            float r1 = Unity_SimpleNoise_RandomValue_float(c1);
            float r2 = Unity_SimpleNoise_RandomValue_float(c2);
            float r3 = Unity_SimpleNoise_RandomValue_float(c3);
        
            float bottomOfGrid = Unity_SimpleNnoise_Interpolate_float(r0, r1, f.x);
            float topOfGrid = Unity_SimpleNnoise_Interpolate_float(r2, r3, f.x);
            float t = Unity_SimpleNnoise_Interpolate_float(bottomOfGrid, topOfGrid, f.y);
            return t;
        }
        void Unity_SimpleNoise_float(float2 UV, float Scale, out float Out)
        {
            float t = 0.0;
        
            float freq = pow(2.0, float(0));
            float amp = pow(0.5, float(3-0));
            t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale/freq, UV.y*Scale/freq))*amp;
        
            freq = pow(2.0, float(1));
            amp = pow(0.5, float(3-1));
            t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale/freq, UV.y*Scale/freq))*amp;
        
            freq = pow(2.0, float(2));
            amp = pow(0.5, float(3-2));
            t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale/freq, UV.y*Scale/freq))*amp;
        
            Out = t;
        }
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }
        
        void Unity_Multiply_float2_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A * B;
        }
        
        void Unity_Lerp_float2(float2 A, float2 B, float2 T, out float2 Out)
        {
            Out = lerp(A, B, T);
        }
        
        
        float2 Unity_GradientNoise_Dir_float(float2 p)
        {
            // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
            p = p % 289;
            // need full precision, otherwise half overflows when p > 1
            float x = float(34 * p.x + 1) * p.x % 289 + p.y;
            x = (34 * x + 1) * x % 289;
            x = frac(x / 41) * 2 - 1;
            return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
        }
        
        void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
        {
            float2 p = UV * Scale;
            float2 ip = floor(p);
            float2 fp = frac(p);
            float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
            float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
            float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
            float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
            fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
            Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Preview_float(float In, out float Out)
        {
            Out = In;
        }
        
        void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
        {
            Out = lerp(A, B, T);
        }
        
        void Unity_SceneDepth_Linear01_float(float4 UV, out float Out)
        {
            Out = Linear01Depth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }
        
        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }
        
        void Unity_Add_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A + B;
        }
        
        void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
        {
            Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
        }
        
        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }
        
        void Unity_SceneColor_float(float4 UV, out float3 Out)
        {
            Out = SHADERGRAPH_SAMPLE_SCENE_COLOR(UV.xy);
        }
        
        void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
        {
            Out = lerp(A, B, T);
        }
        
        void Unity_Blend_Multiply_float3(float3 Base, float3 Blend, out float3 Out, float Opacity)
        {
            Out = Base * Blend;
            Out = lerp(Base, Out, Opacity);
        }
        
        void Unity_ColorMask_float(float3 In, float3 MaskColor, float Range, out float Out, float Fuzziness)
        {
            float Distance = distance(MaskColor, In);
            Out = saturate(1 - (Distance - Range) / max(Fuzziness, 1e-5));
        }
        
        void Unity_Multiply_float4_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }
        
        void Unity_Clamp_float4(float4 In, float4 Min, float4 Max, out float4 Out)
        {
            Out = clamp(In, Min, Max);
        }
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
            float2 MainNormal;
            float2 SecondNormal;
            float2 FoamDirection1;
            float2 FoamDirection2;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            float _Property_271cd524054a48d0ac03da3ed0e18981_Out_0 = _NoiseScale;
            float _Property_d6b17372f8e24d1ba887e19ca0b9b532_Out_0 = _DistortionSpeed;
            float _Multiply_6b5e1abaf00147a8a2bd61cb3a63ac2d_Out_2;
            Unity_Multiply_float_float(0.9, _Property_d6b17372f8e24d1ba887e19ca0b9b532_Out_0, _Multiply_6b5e1abaf00147a8a2bd61cb3a63ac2d_Out_2);
            float _Multiply_0b2927096f2b406eade60b0ff8497f06_Out_2;
            Unity_Multiply_float_float(_Multiply_6b5e1abaf00147a8a2bd61cb3a63ac2d_Out_2, IN.TimeParameters.x, _Multiply_0b2927096f2b406eade60b0ff8497f06_Out_2);
            float2 _TilingAndOffset_3ae4fb84d8a24ae6b255b068ec01f495_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, float2 (1, 1), (_Multiply_0b2927096f2b406eade60b0ff8497f06_Out_2.xx), _TilingAndOffset_3ae4fb84d8a24ae6b255b068ec01f495_Out_3);
            float _SimpleNoise_310007c52b3547759f3d9a40829d9fdb_Out_2;
            Unity_SimpleNoise_float(_TilingAndOffset_3ae4fb84d8a24ae6b255b068ec01f495_Out_3, _Property_271cd524054a48d0ac03da3ed0e18981_Out_0, _SimpleNoise_310007c52b3547759f3d9a40829d9fdb_Out_2);
            float2 _Property_caf806c45b8648239ed928655b2dc075_Out_0 = _FoamNoiseTilling;
            float _Property_83fd66d76a934370a36fc75a684ef06a_Out_0 = _DistortionIntensity;
            float _Property_31ef0e62fff04fde85a1f9ac39636e5c_Out_0 = _NoiseScale;
            float _Property_1df622d21af24ccca4f9f326808f58fc_Out_0 = _DistortionSpeed;
            float _Multiply_8c038a6c11994a53b09ad756f38d3c5d_Out_2;
            Unity_Multiply_float_float(-0.9, _Property_1df622d21af24ccca4f9f326808f58fc_Out_0, _Multiply_8c038a6c11994a53b09ad756f38d3c5d_Out_2);
            float _Multiply_c710fb8d99aa474cb13c0d65aa2a1829_Out_2;
            Unity_Multiply_float_float(_Multiply_8c038a6c11994a53b09ad756f38d3c5d_Out_2, IN.TimeParameters.x, _Multiply_c710fb8d99aa474cb13c0d65aa2a1829_Out_2);
            float2 _TilingAndOffset_b5b7efd61dd0407b81b2ec53772b278d_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, float2 (1, 1), (_Multiply_c710fb8d99aa474cb13c0d65aa2a1829_Out_2.xx), _TilingAndOffset_b5b7efd61dd0407b81b2ec53772b278d_Out_3);
            float _SimpleNoise_4e904d56e17345ff8f80d57968580a32_Out_2;
            Unity_SimpleNoise_float(_TilingAndOffset_b5b7efd61dd0407b81b2ec53772b278d_Out_3, _Property_31ef0e62fff04fde85a1f9ac39636e5c_Out_0, _SimpleNoise_4e904d56e17345ff8f80d57968580a32_Out_2);
            float _Divide_2d74bf9a40ba416f9b680ba114404dc2_Out_2;
            Unity_Divide_float(IN.TimeParameters.x, 6, _Divide_2d74bf9a40ba416f9b680ba114404dc2_Out_2);
            float2 _Property_702ff1c785d542499e4ead1def7e1418_Out_0 = _Panning;
            float _Split_252c3e0a27db4d66a7df034157244e21_R_1 = _Property_702ff1c785d542499e4ead1def7e1418_Out_0[0];
            float _Split_252c3e0a27db4d66a7df034157244e21_G_2 = _Property_702ff1c785d542499e4ead1def7e1418_Out_0[1];
            float _Split_252c3e0a27db4d66a7df034157244e21_B_3 = 0;
            float _Split_252c3e0a27db4d66a7df034157244e21_A_4 = 0;
            float _Multiply_e016b9a16b4e4abba2502adb5862e043_Out_2;
            Unity_Multiply_float_float(_Split_252c3e0a27db4d66a7df034157244e21_G_2, _Divide_2d74bf9a40ba416f9b680ba114404dc2_Out_2, _Multiply_e016b9a16b4e4abba2502adb5862e043_Out_2);
            float _Multiply_218b27dc95a243998b30f016e0d3988e_Out_2;
            Unity_Multiply_float_float(_Split_252c3e0a27db4d66a7df034157244e21_R_1, _Divide_2d74bf9a40ba416f9b680ba114404dc2_Out_2, _Multiply_218b27dc95a243998b30f016e0d3988e_Out_2);
            float4 _Combine_6ae549d623c54cce9850c0bc9b3405eb_RGBA_4;
            float3 _Combine_6ae549d623c54cce9850c0bc9b3405eb_RGB_5;
            float2 _Combine_6ae549d623c54cce9850c0bc9b3405eb_RG_6;
            Unity_Combine_float(_Multiply_218b27dc95a243998b30f016e0d3988e_Out_2, _Multiply_e016b9a16b4e4abba2502adb5862e043_Out_2, 0, 0, _Combine_6ae549d623c54cce9850c0bc9b3405eb_RGBA_4, _Combine_6ae549d623c54cce9850c0bc9b3405eb_RGB_5, _Combine_6ae549d623c54cce9850c0bc9b3405eb_RG_6);
            float _Float_f89ffb73213141f1aa48acbe034e5ea3_Out_0 = 0.02;
            float2 _Swizzle_d519ed834a284e518d347105c3a11492_Out_1 = IN.AbsoluteWorldSpacePosition.xz;
            float2 _Multiply_39c33974737143ae9f76cce56d3d33d2_Out_2;
            Unity_Multiply_float2_float2(_Swizzle_d519ed834a284e518d347105c3a11492_Out_1, (_Float_f89ffb73213141f1aa48acbe034e5ea3_Out_0.xx), _Multiply_39c33974737143ae9f76cce56d3d33d2_Out_2);
            float2 _TilingAndOffset_9f5c71641fa94a59a413d51e3a6aec3d_Out_3;
            Unity_TilingAndOffset_float(_Multiply_39c33974737143ae9f76cce56d3d33d2_Out_2, float2 (1, 1), _Combine_6ae549d623c54cce9850c0bc9b3405eb_RG_6, _TilingAndOffset_9f5c71641fa94a59a413d51e3a6aec3d_Out_3);
            float2 _Lerp_6ba3378c16cf44e49e4a44f6e2f26c65_Out_3;
            Unity_Lerp_float2(_TilingAndOffset_9f5c71641fa94a59a413d51e3a6aec3d_Out_3, (_SimpleNoise_310007c52b3547759f3d9a40829d9fdb_Out_2.xx), (_Property_83fd66d76a934370a36fc75a684ef06a_Out_0.xx), _Lerp_6ba3378c16cf44e49e4a44f6e2f26c65_Out_3);
            float2 _TilingAndOffset_c89d2fcde70d4d818249ebe200337480_Out_3;
            Unity_TilingAndOffset_float(_Lerp_6ba3378c16cf44e49e4a44f6e2f26c65_Out_3, _Property_caf806c45b8648239ed928655b2dc075_Out_0, float2 (0.81, 0), _TilingAndOffset_c89d2fcde70d4d818249ebe200337480_Out_3);
            float2 _Lerp_3759f9668f544adb8dd7eee5886abeb0_Out_3;
            Unity_Lerp_float2(_TilingAndOffset_9f5c71641fa94a59a413d51e3a6aec3d_Out_3, (_SimpleNoise_4e904d56e17345ff8f80d57968580a32_Out_2.xx), (_Property_83fd66d76a934370a36fc75a684ef06a_Out_0.xx), _Lerp_3759f9668f544adb8dd7eee5886abeb0_Out_3);
            float2 _TilingAndOffset_e2926df184da41caab0fcf14e34b81a7_Out_3;
            Unity_TilingAndOffset_float(_Lerp_3759f9668f544adb8dd7eee5886abeb0_Out_3, _Property_caf806c45b8648239ed928655b2dc075_Out_0, float2 (0.81, 0), _TilingAndOffset_e2926df184da41caab0fcf14e34b81a7_Out_3);
            float _Property_8a79f817e59948938215b338bcdc46df_Out_0 = Vector1_898460d8305d4dfe9af1298eb6f67082;
            float _Multiply_ed606ef7153b456b854854134a8f65f9_Out_2;
            Unity_Multiply_float_float(_Property_8a79f817e59948938215b338bcdc46df_Out_0, 0.01, _Multiply_ed606ef7153b456b854854134a8f65f9_Out_2);
            float2 _Property_0264c1738ed14b318538f5f39eb56d07_Out_0 = Vector2_73fa27b3bcf64608a50eed7c1d0d3411;
            float _Divide_d29c49a16f234ef78eee8f12e556a643_Out_2;
            Unity_Divide_float(IN.TimeParameters.x, 5, _Divide_d29c49a16f234ef78eee8f12e556a643_Out_2);
            float _Multiply_5928ff83990b4a61bfdfa392f6154eda_Out_2;
            Unity_Multiply_float_float(_Divide_d29c49a16f234ef78eee8f12e556a643_Out_2, _Multiply_ed606ef7153b456b854854134a8f65f9_Out_2, _Multiply_5928ff83990b4a61bfdfa392f6154eda_Out_2);
            float2 _TilingAndOffset_08fa9dddbfc44f8b9e671e082ef10419_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Property_0264c1738ed14b318538f5f39eb56d07_Out_0, (_Multiply_5928ff83990b4a61bfdfa392f6154eda_Out_2.xx), _TilingAndOffset_08fa9dddbfc44f8b9e671e082ef10419_Out_3);
            float _Property_32d848f89d264e118a7bc7b7cbae9677_Out_0 = Vector1_7614a6098dec470e8a4e96a5c8551362;
            float _Multiply_1541a6ad358e4ea281033d8831f2ba13_Out_2;
            Unity_Multiply_float_float(_Property_32d848f89d264e118a7bc7b7cbae9677_Out_0, -0.01, _Multiply_1541a6ad358e4ea281033d8831f2ba13_Out_2);
            float _Multiply_edd1ffe542204260a884842fd7a18fc1_Out_2;
            Unity_Multiply_float_float(_Multiply_1541a6ad358e4ea281033d8831f2ba13_Out_2, _Divide_d29c49a16f234ef78eee8f12e556a643_Out_2, _Multiply_edd1ffe542204260a884842fd7a18fc1_Out_2);
            float2 _Property_123c8148386d41aa9d1698d86033f0b5_Out_0 = Vector2_c2fe4e7c2a7649b28d7ab078fdadda1c;
            float2 _TilingAndOffset_924ee153284a4d4abbd47514c96bb1ae_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Property_123c8148386d41aa9d1698d86033f0b5_Out_0, (_Multiply_edd1ffe542204260a884842fd7a18fc1_Out_2.xx), _TilingAndOffset_924ee153284a4d4abbd47514c96bb1ae_Out_3);
            float _Split_d8eed8fe26594972914c124586d98bbf_R_1 = IN.ObjectSpacePosition[0];
            float _Split_d8eed8fe26594972914c124586d98bbf_G_2 = IN.ObjectSpacePosition[1];
            float _Split_d8eed8fe26594972914c124586d98bbf_B_3 = IN.ObjectSpacePosition[2];
            float _Split_d8eed8fe26594972914c124586d98bbf_A_4 = 0;
            float _Property_762630e6999b4da0a14b2ccffa4209d8_Out_0 = Vector1_dcce861f82224ec1ac55aa94df3b3d12;
            float _Divide_df746930d1d841c09a66286a0a3543ae_Out_2;
            Unity_Divide_float(_Property_762630e6999b4da0a14b2ccffa4209d8_Out_0, 200, _Divide_df746930d1d841c09a66286a0a3543ae_Out_2);
            float _Property_d73cd49e4412457080da3ad6f38ac94b_Out_0 = Vector1_3606b8114ded4a74a4e4834f8bf7dc12;
            float _Divide_b14ec7aec4874b8ab4371962384288e5_Out_2;
            Unity_Divide_float(_Property_d73cd49e4412457080da3ad6f38ac94b_Out_0, 50, _Divide_b14ec7aec4874b8ab4371962384288e5_Out_2);
            float _Multiply_f97f597155bf4b59afa13426042ec0a0_Out_2;
            Unity_Multiply_float_float(IN.TimeParameters.x, _Divide_b14ec7aec4874b8ab4371962384288e5_Out_2, _Multiply_f97f597155bf4b59afa13426042ec0a0_Out_2);
            float2 _TilingAndOffset_ab2fed3c342049de89287a73af5f4dd1_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, (_Multiply_f97f597155bf4b59afa13426042ec0a0_Out_2.xx), float2 (0, 0), _TilingAndOffset_ab2fed3c342049de89287a73af5f4dd1_Out_3);
            float _GradientNoise_c349a7da229a42f6acfd0e9329f501a7_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_ab2fed3c342049de89287a73af5f4dd1_Out_3, 0.96, _GradientNoise_c349a7da229a42f6acfd0e9329f501a7_Out_2);
            float _Multiply_9460f57a023144a9ae646cb7ff3c8354_Out_2;
            Unity_Multiply_float_float(_Divide_df746930d1d841c09a66286a0a3543ae_Out_2, _GradientNoise_c349a7da229a42f6acfd0e9329f501a7_Out_2, _Multiply_9460f57a023144a9ae646cb7ff3c8354_Out_2);
            float _Add_5cf9a595f1104a0ba7d0c02acbf47625_Out_2;
            Unity_Add_float(_Split_d8eed8fe26594972914c124586d98bbf_G_2, _Multiply_9460f57a023144a9ae646cb7ff3c8354_Out_2, _Add_5cf9a595f1104a0ba7d0c02acbf47625_Out_2);
            float4 _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGBA_4;
            float3 _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGB_5;
            float2 _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RG_6;
            Unity_Combine_float(_Split_d8eed8fe26594972914c124586d98bbf_R_1, _Add_5cf9a595f1104a0ba7d0c02acbf47625_Out_2, _Split_d8eed8fe26594972914c124586d98bbf_B_3, 0, _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGBA_4, _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGB_5, _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RG_6);
            description.Position = _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGB_5;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            description.MainNormal = _TilingAndOffset_924ee153284a4d4abbd47514c96bb1ae_Out_3;
            description.SecondNormal = _TilingAndOffset_08fa9dddbfc44f8b9e671e082ef10419_Out_3;
            description.FoamDirection1 = _TilingAndOffset_e2926df184da41caab0fcf14e34b81a7_Out_3;
            description.FoamDirection2 = _TilingAndOffset_c89d2fcde70d4d818249ebe200337480_Out_3;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        output.MainNormal = input.MainNormal;
        output.SecondNormal = input.SecondNormal;
        output.FoamDirection1 = input.FoamDirection1;
        output.FoamDirection2 = input.FoamDirection2;
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float3 BaseColor;
            float3 NormalTS;
            float3 Emission;
            float Metallic;
            float Smoothness;
            float Occlusion;
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float4 _Property_53dfc4b4cafc4a9496bd9fde6989ee8f_Out_0 = Color_b5081859698940efa07a6cc68ff92e70;
            float4 _Property_601193b6811a41eeb79befed4e93080a_Out_0 = _Shallow_Water_Color_2;
            float4 _UV_0459ed23840544d4943e249e6bf3def0_Out_0 = IN.uv0;
            float _Split_95c75a1ea7ee4dd7906396bff762bd25_R_1 = _UV_0459ed23840544d4943e249e6bf3def0_Out_0[0];
            float _Split_95c75a1ea7ee4dd7906396bff762bd25_G_2 = _UV_0459ed23840544d4943e249e6bf3def0_Out_0[1];
            float _Split_95c75a1ea7ee4dd7906396bff762bd25_B_3 = _UV_0459ed23840544d4943e249e6bf3def0_Out_0[2];
            float _Split_95c75a1ea7ee4dd7906396bff762bd25_A_4 = _UV_0459ed23840544d4943e249e6bf3def0_Out_0[3];
            float _Preview_0af5c98f89c44402ab2012c583d6f212_Out_1;
            Unity_Preview_float(_Split_95c75a1ea7ee4dd7906396bff762bd25_G_2, _Preview_0af5c98f89c44402ab2012c583d6f212_Out_1);
            float4 _Lerp_c2c00306fc734b0c8dee546205970ae6_Out_3;
            Unity_Lerp_float4(_Property_53dfc4b4cafc4a9496bd9fde6989ee8f_Out_0, _Property_601193b6811a41eeb79befed4e93080a_Out_0, (_Preview_0af5c98f89c44402ab2012c583d6f212_Out_1.xxxx), _Lerp_c2c00306fc734b0c8dee546205970ae6_Out_3);
            float4 _Property_72f89d8f335a4977a093f3bae7ef5ea1_Out_0 = Color_2bad1140d6ae465a8b096ead483f5370;
            float4 _Property_8d638ca6b7cc402595ddc523b14de263_Out_0 = Color_1;
            float4 _Lerp_25807026701046b7a4a6abcec2069726_Out_3;
            Unity_Lerp_float4(_Property_72f89d8f335a4977a093f3bae7ef5ea1_Out_0, _Property_8d638ca6b7cc402595ddc523b14de263_Out_0, (_Preview_0af5c98f89c44402ab2012c583d6f212_Out_1.xxxx), _Lerp_25807026701046b7a4a6abcec2069726_Out_3);
            float _SceneDepth_91aa5f89e7564cb2ac5171231a24afdf_Out_1;
            Unity_SceneDepth_Linear01_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_91aa5f89e7564cb2ac5171231a24afdf_Out_1);
            float _Multiply_619704251bdd44e6a8e9f02add36789c_Out_2;
            Unity_Multiply_float_float(_SceneDepth_91aa5f89e7564cb2ac5171231a24afdf_Out_1, _ProjectionParams.z, _Multiply_619704251bdd44e6a8e9f02add36789c_Out_2);
            float4 _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0 = IN.ScreenPosition;
            float _Split_eb526920998f41cd825cbe42160042f5_R_1 = _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0[0];
            float _Split_eb526920998f41cd825cbe42160042f5_G_2 = _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0[1];
            float _Split_eb526920998f41cd825cbe42160042f5_B_3 = _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0[2];
            float _Split_eb526920998f41cd825cbe42160042f5_A_4 = _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0[3];
            float _Property_f4dad9c86f154090a77929fc0594d2eb_Out_0 = Vector1_f108b0f6f7ad4a0fa7970936cde8c93a;
            float _Add_1d0b28a6a0fe41b9aea6de0b9a290419_Out_2;
            Unity_Add_float(_Split_eb526920998f41cd825cbe42160042f5_A_4, _Property_f4dad9c86f154090a77929fc0594d2eb_Out_0, _Add_1d0b28a6a0fe41b9aea6de0b9a290419_Out_2);
            float _Subtract_c310e84b25994cf7969fb6aec3c12631_Out_2;
            Unity_Subtract_float(_Multiply_619704251bdd44e6a8e9f02add36789c_Out_2, _Add_1d0b28a6a0fe41b9aea6de0b9a290419_Out_2, _Subtract_c310e84b25994cf7969fb6aec3c12631_Out_2);
            float _Property_e2cb78357bf54371b95b04624c624355_Out_0 = Vector1_77a8669616464cc68eec17e9163052aa;
            float _Multiply_77d88fee04a2411ebf64a9f3cf93ee09_Out_2;
            Unity_Multiply_float_float(_Subtract_c310e84b25994cf7969fb6aec3c12631_Out_2, _Property_e2cb78357bf54371b95b04624c624355_Out_0, _Multiply_77d88fee04a2411ebf64a9f3cf93ee09_Out_2);
            float _Clamp_5c303e7a7ab74c80819cff967500a688_Out_3;
            Unity_Clamp_float(_Multiply_77d88fee04a2411ebf64a9f3cf93ee09_Out_2, 0, 1, _Clamp_5c303e7a7ab74c80819cff967500a688_Out_3);
            float4 _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3;
            Unity_Lerp_float4(_Lerp_c2c00306fc734b0c8dee546205970ae6_Out_3, _Lerp_25807026701046b7a4a6abcec2069726_Out_3, (_Clamp_5c303e7a7ab74c80819cff967500a688_Out_3.xxxx), _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3);
            UnityTexture2D _Property_691307347e93408bb228020d56a4f64e_Out_0 = UnityBuildTexture2DStructNoScale(Texture2D_2d2e087224e24282b84a086f3316e6e8);
            float4 _SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0 = SAMPLE_TEXTURE2D(_Property_691307347e93408bb228020d56a4f64e_Out_0.tex, _Property_691307347e93408bb228020d56a4f64e_Out_0.samplerstate, _Property_691307347e93408bb228020d56a4f64e_Out_0.GetTransformedUV(IN.MainNormal));
            _SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0);
            float _SampleTexture2D_3802527e187e464aa45999485a38f24f_R_4 = _SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0.r;
            float _SampleTexture2D_3802527e187e464aa45999485a38f24f_G_5 = _SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0.g;
            float _SampleTexture2D_3802527e187e464aa45999485a38f24f_B_6 = _SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0.b;
            float _SampleTexture2D_3802527e187e464aa45999485a38f24f_A_7 = _SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0.a;
            UnityTexture2D _Property_162be1870c564d31abda704370ecd112_Out_0 = UnityBuildTexture2DStructNoScale(Texture2D_21a78e051aa84ab49c73d2364e78102f);
            float4 _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0 = SAMPLE_TEXTURE2D(_Property_162be1870c564d31abda704370ecd112_Out_0.tex, _Property_162be1870c564d31abda704370ecd112_Out_0.samplerstate, _Property_162be1870c564d31abda704370ecd112_Out_0.GetTransformedUV(IN.SecondNormal));
            _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0);
            float _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_R_4 = _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0.r;
            float _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_G_5 = _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0.g;
            float _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_B_6 = _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0.b;
            float _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_A_7 = _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0.a;
            float4 _Add_357900c2d36f40c0b7995aceda820c48_Out_2;
            Unity_Add_float4(_SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0, _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0, _Add_357900c2d36f40c0b7995aceda820c48_Out_2);
            float _Property_bcb4a350b8234af79860039f232f70bb_Out_0 = Vector1_0360d732cbbf426e841ca433b0e337aa;
            float3 _NormalStrength_353fbbdfa63c4bf1a26d328b90d65d75_Out_2;
            Unity_NormalStrength_float((_Add_357900c2d36f40c0b7995aceda820c48_Out_2.xyz), _Property_bcb4a350b8234af79860039f232f70bb_Out_0, _NormalStrength_353fbbdfa63c4bf1a26d328b90d65d75_Out_2);
            float _Property_435f8911f9614444bccaa1b491910830_Out_0 = _RefractionDistrotion;
            float3 _NormalStrength_c661b7411e0343adbe9cd03e17ec5587_Out_2;
            Unity_NormalStrength_float(_NormalStrength_353fbbdfa63c4bf1a26d328b90d65d75_Out_2, _Property_435f8911f9614444bccaa1b491910830_Out_0, _NormalStrength_c661b7411e0343adbe9cd03e17ec5587_Out_2);
            float4 _ScreenPosition_8195cd06776241d5b37929c91c6dad48_Out_0 = float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0);
            float3 _Add_b257228ea21d4b4d977a6133326b7e06_Out_2;
            Unity_Add_float3(_NormalStrength_c661b7411e0343adbe9cd03e17ec5587_Out_2, (_ScreenPosition_8195cd06776241d5b37929c91c6dad48_Out_0.xyz), _Add_b257228ea21d4b4d977a6133326b7e06_Out_2);
            float3 _SceneColor_2c332a05662541f2bba2d1b5eeb47bd2_Out_1;
            Unity_SceneColor_float((float4(_Add_b257228ea21d4b4d977a6133326b7e06_Out_2, 1.0)), _SceneColor_2c332a05662541f2bba2d1b5eeb47bd2_Out_1);
            UnityTexture2D _Property_c55f1526f461489aa2011515ec7da3a3_Out_0 = UnityBuildTexture2DStructNoScale(_PlanarReflectionTexture);
            float3 _Add_9cc9802b3ef24c21b8771b375a3bff42_Out_2;
            Unity_Add_float3(_NormalStrength_353fbbdfa63c4bf1a26d328b90d65d75_Out_2, (_Clamp_5c303e7a7ab74c80819cff967500a688_Out_3.xxx), _Add_9cc9802b3ef24c21b8771b375a3bff42_Out_2);
            float3 _NormalStrength_6161489259bb4747ba0928987b51a0ea_Out_2;
            Unity_NormalStrength_float(_Add_9cc9802b3ef24c21b8771b375a3bff42_Out_2, _Property_435f8911f9614444bccaa1b491910830_Out_0, _NormalStrength_6161489259bb4747ba0928987b51a0ea_Out_2);
            float3 _Add_51f05a9faaf74e72812fae8a48ed882c_Out_2;
            Unity_Add_float3((_ScreenPosition_8195cd06776241d5b37929c91c6dad48_Out_0.xyz), _NormalStrength_6161489259bb4747ba0928987b51a0ea_Out_2, _Add_51f05a9faaf74e72812fae8a48ed882c_Out_2);
            float4 _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_RGBA_0 = SAMPLE_TEXTURE2D(_Property_c55f1526f461489aa2011515ec7da3a3_Out_0.tex, _Property_c55f1526f461489aa2011515ec7da3a3_Out_0.samplerstate, _Property_c55f1526f461489aa2011515ec7da3a3_Out_0.GetTransformedUV((_Add_51f05a9faaf74e72812fae8a48ed882c_Out_2.xy)));
            float _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_R_4 = _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_RGBA_0.r;
            float _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_G_5 = _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_RGBA_0.g;
            float _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_B_6 = _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_RGBA_0.b;
            float _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_A_7 = _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_RGBA_0.a;
            float3 _Lerp_6bca2423774749ccb6b3d02c089ca6aa_Out_3;
            Unity_Lerp_float3(_SceneColor_2c332a05662541f2bba2d1b5eeb47bd2_Out_1, (_SampleTexture2D_60a5b90e4760409a9760488b39b95feb_RGBA_0.xyz), (_Clamp_5c303e7a7ab74c80819cff967500a688_Out_3.xxx), _Lerp_6bca2423774749ccb6b3d02c089ca6aa_Out_3);
            float _Property_4267d14b41a64c8faa1146ffbcfe3618_Out_0 = _Relection_Strength;
            float3 _Blend_1d413404067041f1a38d59c008106e23_Out_2;
            Unity_Blend_Multiply_float3((_Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3.xyz), _Lerp_6bca2423774749ccb6b3d02c089ca6aa_Out_3, _Blend_1d413404067041f1a38d59c008106e23_Out_2, _Property_4267d14b41a64c8faa1146ffbcfe3618_Out_0);
            UnityTexture2D _Property_dff6df0bd4d4495f97a7a18e11ec195a_Out_0 = UnityBuildTexture2DStructNoScale(Texture2D_2d2e087224e24282b84a086f3316e6e8);
            float4 _SampleTexture2D_fd9ae2c1f81b405e9021849934e7146d_RGBA_0 = SAMPLE_TEXTURE2D(_Property_dff6df0bd4d4495f97a7a18e11ec195a_Out_0.tex, _Property_dff6df0bd4d4495f97a7a18e11ec195a_Out_0.samplerstate, _Property_dff6df0bd4d4495f97a7a18e11ec195a_Out_0.GetTransformedUV(IN.MainNormal));
            float _SampleTexture2D_fd9ae2c1f81b405e9021849934e7146d_R_4 = _SampleTexture2D_fd9ae2c1f81b405e9021849934e7146d_RGBA_0.r;
            float _SampleTexture2D_fd9ae2c1f81b405e9021849934e7146d_G_5 = _SampleTexture2D_fd9ae2c1f81b405e9021849934e7146d_RGBA_0.g;
            float _SampleTexture2D_fd9ae2c1f81b405e9021849934e7146d_B_6 = _SampleTexture2D_fd9ae2c1f81b405e9021849934e7146d_RGBA_0.b;
            float _SampleTexture2D_fd9ae2c1f81b405e9021849934e7146d_A_7 = _SampleTexture2D_fd9ae2c1f81b405e9021849934e7146d_RGBA_0.a;
            UnityTexture2D _Property_f0238f5adf1d400c886a5a72ea8e3800_Out_0 = UnityBuildTexture2DStructNoScale(Texture2D_2d2e087224e24282b84a086f3316e6e8);
            float4 _SampleTexture2D_b5339f18d32e4578951e0bd01553c041_RGBA_0 = SAMPLE_TEXTURE2D(_Property_f0238f5adf1d400c886a5a72ea8e3800_Out_0.tex, _Property_f0238f5adf1d400c886a5a72ea8e3800_Out_0.samplerstate, _Property_f0238f5adf1d400c886a5a72ea8e3800_Out_0.GetTransformedUV(IN.SecondNormal));
            float _SampleTexture2D_b5339f18d32e4578951e0bd01553c041_R_4 = _SampleTexture2D_b5339f18d32e4578951e0bd01553c041_RGBA_0.r;
            float _SampleTexture2D_b5339f18d32e4578951e0bd01553c041_G_5 = _SampleTexture2D_b5339f18d32e4578951e0bd01553c041_RGBA_0.g;
            float _SampleTexture2D_b5339f18d32e4578951e0bd01553c041_B_6 = _SampleTexture2D_b5339f18d32e4578951e0bd01553c041_RGBA_0.b;
            float _SampleTexture2D_b5339f18d32e4578951e0bd01553c041_A_7 = _SampleTexture2D_b5339f18d32e4578951e0bd01553c041_RGBA_0.a;
            float4 _Add_f4d1aaeeebe741bfac01df2cb63237d2_Out_2;
            Unity_Add_float4(_SampleTexture2D_fd9ae2c1f81b405e9021849934e7146d_RGBA_0, _SampleTexture2D_b5339f18d32e4578951e0bd01553c041_RGBA_0, _Add_f4d1aaeeebe741bfac01df2cb63237d2_Out_2);
            float _Property_94bcaaa57baf401a892936e8d1121760_Out_0 = _Layer1_Scale;
            float _ColorMask_3b67330abbfa4d5da09be858fde593ec_Out_3;
            Unity_ColorMask_float((_Add_f4d1aaeeebe741bfac01df2cb63237d2_Out_2.xyz), IsGammaSpace() ? float3(1, 1, 1) : SRGBToLinear(float3(1, 1, 1)), _Property_94bcaaa57baf401a892936e8d1121760_Out_0, _ColorMask_3b67330abbfa4d5da09be858fde593ec_Out_3, 0.4);
            UnityTexture2D _Property_edbfda5e1a564ea2aad094a54bb3b007_Out_0 = UnityBuildTexture2DStructNoScale(Texture2D_d65eb6e07c30447ca446c38272609586);
            float4 _SampleTexture2D_7464425046b24f39b9304827ccb6101e_RGBA_0 = SAMPLE_TEXTURE2D(_Property_edbfda5e1a564ea2aad094a54bb3b007_Out_0.tex, _Property_edbfda5e1a564ea2aad094a54bb3b007_Out_0.samplerstate, _Property_edbfda5e1a564ea2aad094a54bb3b007_Out_0.GetTransformedUV(IN.FoamDirection1));
            float _SampleTexture2D_7464425046b24f39b9304827ccb6101e_R_4 = _SampleTexture2D_7464425046b24f39b9304827ccb6101e_RGBA_0.r;
            float _SampleTexture2D_7464425046b24f39b9304827ccb6101e_G_5 = _SampleTexture2D_7464425046b24f39b9304827ccb6101e_RGBA_0.g;
            float _SampleTexture2D_7464425046b24f39b9304827ccb6101e_B_6 = _SampleTexture2D_7464425046b24f39b9304827ccb6101e_RGBA_0.b;
            float _SampleTexture2D_7464425046b24f39b9304827ccb6101e_A_7 = _SampleTexture2D_7464425046b24f39b9304827ccb6101e_RGBA_0.a;
            float4 _Property_05ee1312567a419ea766bcaa855dc2ed_Out_0 = Color_6e3aa9f38d68448bb94d493ef4e3c30a;
            float4 _Multiply_75f2ec69c46847e5aaea2cd6420daa9e_Out_2;
            Unity_Multiply_float4_float4((_SampleTexture2D_7464425046b24f39b9304827ccb6101e_G_5.xxxx), _Property_05ee1312567a419ea766bcaa855dc2ed_Out_0, _Multiply_75f2ec69c46847e5aaea2cd6420daa9e_Out_2);
            float4 _Multiply_e5480cb837904b4ab771dec3029ac8d6_Out_2;
            Unity_Multiply_float4_float4((_ColorMask_3b67330abbfa4d5da09be858fde593ec_Out_3.xxxx), _Multiply_75f2ec69c46847e5aaea2cd6420daa9e_Out_2, _Multiply_e5480cb837904b4ab771dec3029ac8d6_Out_2);
            float _Property_aff115291912400081bcc3de12f2f8ec_Out_0 = _Layer2_Scale;
            float _ColorMask_c2b65a71e09b4b4a97fc255b1947e69e_Out_3;
            Unity_ColorMask_float((_Add_f4d1aaeeebe741bfac01df2cb63237d2_Out_2.xyz), IsGammaSpace() ? float3(1, 1, 1) : SRGBToLinear(float3(1, 1, 1)), _Property_aff115291912400081bcc3de12f2f8ec_Out_0, _ColorMask_c2b65a71e09b4b4a97fc255b1947e69e_Out_3, 0.4);
            float4 _SampleTexture2D_4dcd9985d6b54ac3a3070127f41fef44_RGBA_0 = SAMPLE_TEXTURE2D(_Property_edbfda5e1a564ea2aad094a54bb3b007_Out_0.tex, _Property_edbfda5e1a564ea2aad094a54bb3b007_Out_0.samplerstate, _Property_edbfda5e1a564ea2aad094a54bb3b007_Out_0.GetTransformedUV(IN.FoamDirection2));
            float _SampleTexture2D_4dcd9985d6b54ac3a3070127f41fef44_R_4 = _SampleTexture2D_4dcd9985d6b54ac3a3070127f41fef44_RGBA_0.r;
            float _SampleTexture2D_4dcd9985d6b54ac3a3070127f41fef44_G_5 = _SampleTexture2D_4dcd9985d6b54ac3a3070127f41fef44_RGBA_0.g;
            float _SampleTexture2D_4dcd9985d6b54ac3a3070127f41fef44_B_6 = _SampleTexture2D_4dcd9985d6b54ac3a3070127f41fef44_RGBA_0.b;
            float _SampleTexture2D_4dcd9985d6b54ac3a3070127f41fef44_A_7 = _SampleTexture2D_4dcd9985d6b54ac3a3070127f41fef44_RGBA_0.a;
            float4 _Multiply_d1696f7e6e5a4cdcae3d545c0dab56c5_Out_2;
            Unity_Multiply_float4_float4(_Property_05ee1312567a419ea766bcaa855dc2ed_Out_0, (_SampleTexture2D_4dcd9985d6b54ac3a3070127f41fef44_B_6.xxxx), _Multiply_d1696f7e6e5a4cdcae3d545c0dab56c5_Out_2);
            float4 _Multiply_7ddead3a69614c469917ed7b9aafa900_Out_2;
            Unity_Multiply_float4_float4((_ColorMask_c2b65a71e09b4b4a97fc255b1947e69e_Out_3.xxxx), _Multiply_d1696f7e6e5a4cdcae3d545c0dab56c5_Out_2, _Multiply_7ddead3a69614c469917ed7b9aafa900_Out_2);
            float4 _Add_d1b55de8d8eb46d5be51b419333fbee1_Out_2;
            Unity_Add_float4(_Multiply_e5480cb837904b4ab771dec3029ac8d6_Out_2, _Multiply_7ddead3a69614c469917ed7b9aafa900_Out_2, _Add_d1b55de8d8eb46d5be51b419333fbee1_Out_2);
            float4 _Property_91c7296a1fd34a6ba4ba2db430b227cf_Out_0 = Color_6e3aa9f38d68448bb94d493ef4e3c30a;
            float _Property_25ca0be5c8024b6984b39cc03c10699e_Out_0 = Vector1_aace7401fb3a402e9f06de96963c9b84;
            float _Subtract_af5fef32a00b4cd4863e59c7a5aa9f5c_Out_2;
            Unity_Subtract_float(_Multiply_619704251bdd44e6a8e9f02add36789c_Out_2, _Split_eb526920998f41cd825cbe42160042f5_A_4, _Subtract_af5fef32a00b4cd4863e59c7a5aa9f5c_Out_2);
            float _Subtract_5cb3b9da51094bfc9691cff775ed046c_Out_2;
            Unity_Subtract_float(_Property_25ca0be5c8024b6984b39cc03c10699e_Out_0, _Subtract_af5fef32a00b4cd4863e59c7a5aa9f5c_Out_2, _Subtract_5cb3b9da51094bfc9691cff775ed046c_Out_2);
            float _Property_ddab7adb8fc8414e903ddbb8f8b183e2_Out_0 = Vector1_0d98869735ab4e73a0e4bb36589d00c0;
            float _Multiply_efbf135285134c28b8a80ff0e4ba3f17_Out_2;
            Unity_Multiply_float_float(_Subtract_5cb3b9da51094bfc9691cff775ed046c_Out_2, _Property_ddab7adb8fc8414e903ddbb8f8b183e2_Out_0, _Multiply_efbf135285134c28b8a80ff0e4ba3f17_Out_2);
            float4 _Multiply_92e7da0ce3c448e0a75776463e054f66_Out_2;
            Unity_Multiply_float4_float4(_Property_91c7296a1fd34a6ba4ba2db430b227cf_Out_0, (_Multiply_efbf135285134c28b8a80ff0e4ba3f17_Out_2.xxxx), _Multiply_92e7da0ce3c448e0a75776463e054f66_Out_2);
            UnityTexture2D _Property_2613ec34f9504d22aafecb7ad6480e1e_Out_0 = UnityBuildTexture2DStructNoScale(Texture2D_d65eb6e07c30447ca446c38272609586);
            float2 _Property_49ee0e056d6942968b9200a4a85c3251_Out_0 = Vector2_2832e3b0590c4ee98f806b14c0f54c5b;
            float2 _TilingAndOffset_b50bda6ad9b140f9b0ca863214f6b957_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Property_49ee0e056d6942968b9200a4a85c3251_Out_0, float2 (0.18, 0), _TilingAndOffset_b50bda6ad9b140f9b0ca863214f6b957_Out_3);
            float4 _SampleTexture2D_00f1f15016c649f0ae4e0c96597e573f_RGBA_0 = SAMPLE_TEXTURE2D(_Property_2613ec34f9504d22aafecb7ad6480e1e_Out_0.tex, _Property_2613ec34f9504d22aafecb7ad6480e1e_Out_0.samplerstate, _Property_2613ec34f9504d22aafecb7ad6480e1e_Out_0.GetTransformedUV(_TilingAndOffset_b50bda6ad9b140f9b0ca863214f6b957_Out_3));
            float _SampleTexture2D_00f1f15016c649f0ae4e0c96597e573f_R_4 = _SampleTexture2D_00f1f15016c649f0ae4e0c96597e573f_RGBA_0.r;
            float _SampleTexture2D_00f1f15016c649f0ae4e0c96597e573f_G_5 = _SampleTexture2D_00f1f15016c649f0ae4e0c96597e573f_RGBA_0.g;
            float _SampleTexture2D_00f1f15016c649f0ae4e0c96597e573f_B_6 = _SampleTexture2D_00f1f15016c649f0ae4e0c96597e573f_RGBA_0.b;
            float _SampleTexture2D_00f1f15016c649f0ae4e0c96597e573f_A_7 = _SampleTexture2D_00f1f15016c649f0ae4e0c96597e573f_RGBA_0.a;
            float4 _Multiply_4f081b87dfcb4a41bb7615b058040e89_Out_2;
            Unity_Multiply_float4_float4(_Multiply_92e7da0ce3c448e0a75776463e054f66_Out_2, (_SampleTexture2D_00f1f15016c649f0ae4e0c96597e573f_G_5.xxxx), _Multiply_4f081b87dfcb4a41bb7615b058040e89_Out_2);
            float4 _Clamp_3a0f28c23b344448ac636ad89dbdb3e7_Out_3;
            Unity_Clamp_float4(_Multiply_4f081b87dfcb4a41bb7615b058040e89_Out_2, float4(0, 0, 0, 0), float4(1, 1, 1, 1), _Clamp_3a0f28c23b344448ac636ad89dbdb3e7_Out_3);
            float4 _Add_fb079be2c07b4115bae3a3c384291108_Out_2;
            Unity_Add_float4(_Add_d1b55de8d8eb46d5be51b419333fbee1_Out_2, _Clamp_3a0f28c23b344448ac636ad89dbdb3e7_Out_3, _Add_fb079be2c07b4115bae3a3c384291108_Out_2);
            float _Property_c85200fdac2540b9b3e122c51e3ffcbb_Out_0 = Vector1_69bcaf9cf50f40a2bef27afe006bbc8f;
            float _Split_32fd3b93931741f5ba645cdab3f37d0f_R_1 = _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3[0];
            float _Split_32fd3b93931741f5ba645cdab3f37d0f_G_2 = _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3[1];
            float _Split_32fd3b93931741f5ba645cdab3f37d0f_B_3 = _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3[2];
            float _Split_32fd3b93931741f5ba645cdab3f37d0f_A_4 = _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3[3];
            surface.BaseColor = _Blend_1d413404067041f1a38d59c008106e23_Out_2;
            surface.NormalTS = _NormalStrength_353fbbdfa63c4bf1a26d328b90d65d75_Out_2;
            surface.Emission = (_Add_fb079be2c07b4115bae3a3c384291108_Out_2.xyz);
            surface.Metallic = 0;
            surface.Smoothness = _Property_c85200fdac2540b9b3e122c51e3ffcbb_Out_0;
            surface.Occlusion = 1;
            surface.Alpha = _Split_32fd3b93931741f5ba645cdab3f37d0f_A_4;
            surface.AlphaClipThreshold = 0;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
            output.AbsoluteWorldSpacePosition =                 GetAbsolutePositionWS(TransformObjectToWorld(input.positionOS));
            output.uv0 =                                        input.uv0;
            output.TimeParameters =                             _TimeParameters.xyz;
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            output.MainNormal = input.MainNormal;
        output.SecondNormal = input.SecondNormal;
        output.FoamDirection1 = input.FoamDirection1;
        output.FoamDirection2 = input.FoamDirection2;
        
        
        
            output.TangentSpaceNormal = float3(0.0f, 0.0f, 1.0f);
        
        
            output.WorldSpacePosition = input.positionWS;
            output.ScreenPosition = ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
            output.uv0 = input.texCoord0;
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBRForwardPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            Name "DepthNormals"
            Tags
            {
                "LightMode" = "DepthNormals"
            }
        
        // Render State
        Cull Back
        ZTest LEqual
        ZWrite On
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 2.0
        #pragma only_renderers gles gles3 glcore d3d11
        #pragma multi_compile_instancing
        #pragma vertex vert
        #pragma fragment frag
        
        // DotsInstancingOptions: <None>
        // HybridV1InjectedBuiltinProperties: <None>
        
        // Keywords
        // PassKeywords: <None>
        // GraphKeywords: <None>
        
        // Defines
        
        #define _NORMALMAP 1
        #define _NORMAL_DROPOFF_TS 1
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define ATTRIBUTES_NEED_TEXCOORD1
        #define VARYINGS_NEED_POSITION_WS
        #define VARYINGS_NEED_NORMAL_WS
        #define VARYINGS_NEED_TANGENT_WS
        #define VARYINGS_NEED_TEXCOORD0
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_DEPTHNORMALS
        #define _ALPHATEST_ON 1
        #define REQUIRE_DEPTH_TEXTURE
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
             float4 uv1 : TEXCOORD1;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float3 positionWS;
             float3 normalWS;
             float4 tangentWS;
             float4 texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
             float2 MainNormal;
             float2 SecondNormal;
        };
        struct SurfaceDescriptionInputs
        {
             float3 TangentSpaceNormal;
             float3 WorldSpacePosition;
             float4 ScreenPosition;
             float4 uv0;
             float2 MainNormal;
             float2 SecondNormal;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
             float4 uv0;
             float3 TimeParameters;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float3 interp0 : INTERP0;
             float3 interp1 : INTERP1;
             float4 interp2 : INTERP2;
             float4 interp3 : INTERP3;
             float4 interp4 : INTERP4;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.positionWS;
            output.interp1.xyz =  input.normalWS;
            output.interp2.xyzw =  input.tangentWS;
            output.interp3.xyzw =  input.texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            output.interp4.xy =  input.MainNormal;
            output.interp4.zw =  input.SecondNormal;
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.positionWS = input.interp0.xyz;
            output.normalWS = input.interp1.xyz;
            output.tangentWS = input.interp2.xyzw;
            output.texCoord0 = input.interp3.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            output.MainNormal = input.interp4.xy;
            output.SecondNormal = input.interp4.zw;
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float4 _PlanarReflectionTexture_TexelSize;
        float Vector1_f108b0f6f7ad4a0fa7970936cde8c93a;
        float Vector1_77a8669616464cc68eec17e9163052aa;
        float4 Color_2bad1140d6ae465a8b096ead483f5370;
        float4 Color_b5081859698940efa07a6cc68ff92e70;
        float4 Color_1;
        float4 Texture2D_2d2e087224e24282b84a086f3316e6e8_TexelSize;
        float2 Vector2_c2fe4e7c2a7649b28d7ab078fdadda1c;
        float Vector1_7614a6098dec470e8a4e96a5c8551362;
        float4 Texture2D_21a78e051aa84ab49c73d2364e78102f_TexelSize;
        float2 Vector2_73fa27b3bcf64608a50eed7c1d0d3411;
        float Vector1_898460d8305d4dfe9af1298eb6f67082;
        float Vector1_0360d732cbbf426e841ca433b0e337aa;
        float Vector1_dcce861f82224ec1ac55aa94df3b3d12;
        float Vector1_3606b8114ded4a74a4e4834f8bf7dc12;
        float Vector1_69bcaf9cf50f40a2bef27afe006bbc8f;
        float4 Color_6e3aa9f38d68448bb94d493ef4e3c30a;
        float Vector1_0d98869735ab4e73a0e4bb36589d00c0;
        float Vector1_aace7401fb3a402e9f06de96963c9b84;
        float4 Texture2D_d65eb6e07c30447ca446c38272609586_TexelSize;
        float2 Vector2_2832e3b0590c4ee98f806b14c0f54c5b;
        float4 _Shallow_Water_Color_2;
        float2 _Panning;
        float _DistortionSpeed;
        float _DistortionIntensity;
        float2 _FoamNoiseTilling;
        float _DistortionScale;
        float _NoiseScale;
        float _Layer1_Scale;
        float _Layer2_Scale;
        float _RefractionDistrotion;
        float _Relection_Strength;
        CBUFFER_END
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_PlanarReflectionTexture);
        SAMPLER(sampler_PlanarReflectionTexture);
        TEXTURE2D(Texture2D_2d2e087224e24282b84a086f3316e6e8);
        SAMPLER(samplerTexture2D_2d2e087224e24282b84a086f3316e6e8);
        TEXTURE2D(Texture2D_21a78e051aa84ab49c73d2364e78102f);
        SAMPLER(samplerTexture2D_21a78e051aa84ab49c73d2364e78102f);
        TEXTURE2D(Texture2D_d65eb6e07c30447ca446c38272609586);
        SAMPLER(samplerTexture2D_d65eb6e07c30447ca446c38272609586);
        
        // Graph Includes
        // GraphIncludes: <None>
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        
        float2 Unity_GradientNoise_Dir_float(float2 p)
        {
            // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
            p = p % 289;
            // need full precision, otherwise half overflows when p > 1
            float x = float(34 * p.x + 1) * p.x % 289 + p.y;
            x = (34 * x + 1) * x % 289;
            x = frac(x / 41) * 2 - 1;
            return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
        }
        
        void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
        {
            float2 p = UV * Scale;
            float2 ip = floor(p);
            float2 fp = frac(p);
            float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
            float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
            float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
            float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
            fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
            Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }
        
        void Unity_Add_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A + B;
        }
        
        void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
        {
            Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
        }
        
        void Unity_Preview_float(float In, out float Out)
        {
            Out = In;
        }
        
        void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
        {
            Out = lerp(A, B, T);
        }
        
        void Unity_SceneDepth_Linear01_float(float4 UV, out float Out)
        {
            Out = Linear01Depth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }
        
        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
            float2 MainNormal;
            float2 SecondNormal;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            float _Property_8a79f817e59948938215b338bcdc46df_Out_0 = Vector1_898460d8305d4dfe9af1298eb6f67082;
            float _Multiply_ed606ef7153b456b854854134a8f65f9_Out_2;
            Unity_Multiply_float_float(_Property_8a79f817e59948938215b338bcdc46df_Out_0, 0.01, _Multiply_ed606ef7153b456b854854134a8f65f9_Out_2);
            float2 _Property_0264c1738ed14b318538f5f39eb56d07_Out_0 = Vector2_73fa27b3bcf64608a50eed7c1d0d3411;
            float _Divide_d29c49a16f234ef78eee8f12e556a643_Out_2;
            Unity_Divide_float(IN.TimeParameters.x, 5, _Divide_d29c49a16f234ef78eee8f12e556a643_Out_2);
            float _Multiply_5928ff83990b4a61bfdfa392f6154eda_Out_2;
            Unity_Multiply_float_float(_Divide_d29c49a16f234ef78eee8f12e556a643_Out_2, _Multiply_ed606ef7153b456b854854134a8f65f9_Out_2, _Multiply_5928ff83990b4a61bfdfa392f6154eda_Out_2);
            float2 _TilingAndOffset_08fa9dddbfc44f8b9e671e082ef10419_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Property_0264c1738ed14b318538f5f39eb56d07_Out_0, (_Multiply_5928ff83990b4a61bfdfa392f6154eda_Out_2.xx), _TilingAndOffset_08fa9dddbfc44f8b9e671e082ef10419_Out_3);
            float _Property_32d848f89d264e118a7bc7b7cbae9677_Out_0 = Vector1_7614a6098dec470e8a4e96a5c8551362;
            float _Multiply_1541a6ad358e4ea281033d8831f2ba13_Out_2;
            Unity_Multiply_float_float(_Property_32d848f89d264e118a7bc7b7cbae9677_Out_0, -0.01, _Multiply_1541a6ad358e4ea281033d8831f2ba13_Out_2);
            float _Multiply_edd1ffe542204260a884842fd7a18fc1_Out_2;
            Unity_Multiply_float_float(_Multiply_1541a6ad358e4ea281033d8831f2ba13_Out_2, _Divide_d29c49a16f234ef78eee8f12e556a643_Out_2, _Multiply_edd1ffe542204260a884842fd7a18fc1_Out_2);
            float2 _Property_123c8148386d41aa9d1698d86033f0b5_Out_0 = Vector2_c2fe4e7c2a7649b28d7ab078fdadda1c;
            float2 _TilingAndOffset_924ee153284a4d4abbd47514c96bb1ae_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Property_123c8148386d41aa9d1698d86033f0b5_Out_0, (_Multiply_edd1ffe542204260a884842fd7a18fc1_Out_2.xx), _TilingAndOffset_924ee153284a4d4abbd47514c96bb1ae_Out_3);
            float _Split_d8eed8fe26594972914c124586d98bbf_R_1 = IN.ObjectSpacePosition[0];
            float _Split_d8eed8fe26594972914c124586d98bbf_G_2 = IN.ObjectSpacePosition[1];
            float _Split_d8eed8fe26594972914c124586d98bbf_B_3 = IN.ObjectSpacePosition[2];
            float _Split_d8eed8fe26594972914c124586d98bbf_A_4 = 0;
            float _Property_762630e6999b4da0a14b2ccffa4209d8_Out_0 = Vector1_dcce861f82224ec1ac55aa94df3b3d12;
            float _Divide_df746930d1d841c09a66286a0a3543ae_Out_2;
            Unity_Divide_float(_Property_762630e6999b4da0a14b2ccffa4209d8_Out_0, 200, _Divide_df746930d1d841c09a66286a0a3543ae_Out_2);
            float _Property_d73cd49e4412457080da3ad6f38ac94b_Out_0 = Vector1_3606b8114ded4a74a4e4834f8bf7dc12;
            float _Divide_b14ec7aec4874b8ab4371962384288e5_Out_2;
            Unity_Divide_float(_Property_d73cd49e4412457080da3ad6f38ac94b_Out_0, 50, _Divide_b14ec7aec4874b8ab4371962384288e5_Out_2);
            float _Multiply_f97f597155bf4b59afa13426042ec0a0_Out_2;
            Unity_Multiply_float_float(IN.TimeParameters.x, _Divide_b14ec7aec4874b8ab4371962384288e5_Out_2, _Multiply_f97f597155bf4b59afa13426042ec0a0_Out_2);
            float2 _TilingAndOffset_ab2fed3c342049de89287a73af5f4dd1_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, (_Multiply_f97f597155bf4b59afa13426042ec0a0_Out_2.xx), float2 (0, 0), _TilingAndOffset_ab2fed3c342049de89287a73af5f4dd1_Out_3);
            float _GradientNoise_c349a7da229a42f6acfd0e9329f501a7_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_ab2fed3c342049de89287a73af5f4dd1_Out_3, 0.96, _GradientNoise_c349a7da229a42f6acfd0e9329f501a7_Out_2);
            float _Multiply_9460f57a023144a9ae646cb7ff3c8354_Out_2;
            Unity_Multiply_float_float(_Divide_df746930d1d841c09a66286a0a3543ae_Out_2, _GradientNoise_c349a7da229a42f6acfd0e9329f501a7_Out_2, _Multiply_9460f57a023144a9ae646cb7ff3c8354_Out_2);
            float _Add_5cf9a595f1104a0ba7d0c02acbf47625_Out_2;
            Unity_Add_float(_Split_d8eed8fe26594972914c124586d98bbf_G_2, _Multiply_9460f57a023144a9ae646cb7ff3c8354_Out_2, _Add_5cf9a595f1104a0ba7d0c02acbf47625_Out_2);
            float4 _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGBA_4;
            float3 _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGB_5;
            float2 _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RG_6;
            Unity_Combine_float(_Split_d8eed8fe26594972914c124586d98bbf_R_1, _Add_5cf9a595f1104a0ba7d0c02acbf47625_Out_2, _Split_d8eed8fe26594972914c124586d98bbf_B_3, 0, _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGBA_4, _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGB_5, _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RG_6);
            description.Position = _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGB_5;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            description.MainNormal = _TilingAndOffset_924ee153284a4d4abbd47514c96bb1ae_Out_3;
            description.SecondNormal = _TilingAndOffset_08fa9dddbfc44f8b9e671e082ef10419_Out_3;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        output.MainNormal = input.MainNormal;
        output.SecondNormal = input.SecondNormal;
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float3 NormalTS;
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            UnityTexture2D _Property_691307347e93408bb228020d56a4f64e_Out_0 = UnityBuildTexture2DStructNoScale(Texture2D_2d2e087224e24282b84a086f3316e6e8);
            float4 _SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0 = SAMPLE_TEXTURE2D(_Property_691307347e93408bb228020d56a4f64e_Out_0.tex, _Property_691307347e93408bb228020d56a4f64e_Out_0.samplerstate, _Property_691307347e93408bb228020d56a4f64e_Out_0.GetTransformedUV(IN.MainNormal));
            _SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0);
            float _SampleTexture2D_3802527e187e464aa45999485a38f24f_R_4 = _SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0.r;
            float _SampleTexture2D_3802527e187e464aa45999485a38f24f_G_5 = _SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0.g;
            float _SampleTexture2D_3802527e187e464aa45999485a38f24f_B_6 = _SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0.b;
            float _SampleTexture2D_3802527e187e464aa45999485a38f24f_A_7 = _SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0.a;
            UnityTexture2D _Property_162be1870c564d31abda704370ecd112_Out_0 = UnityBuildTexture2DStructNoScale(Texture2D_21a78e051aa84ab49c73d2364e78102f);
            float4 _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0 = SAMPLE_TEXTURE2D(_Property_162be1870c564d31abda704370ecd112_Out_0.tex, _Property_162be1870c564d31abda704370ecd112_Out_0.samplerstate, _Property_162be1870c564d31abda704370ecd112_Out_0.GetTransformedUV(IN.SecondNormal));
            _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0);
            float _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_R_4 = _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0.r;
            float _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_G_5 = _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0.g;
            float _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_B_6 = _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0.b;
            float _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_A_7 = _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0.a;
            float4 _Add_357900c2d36f40c0b7995aceda820c48_Out_2;
            Unity_Add_float4(_SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0, _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0, _Add_357900c2d36f40c0b7995aceda820c48_Out_2);
            float _Property_bcb4a350b8234af79860039f232f70bb_Out_0 = Vector1_0360d732cbbf426e841ca433b0e337aa;
            float3 _NormalStrength_353fbbdfa63c4bf1a26d328b90d65d75_Out_2;
            Unity_NormalStrength_float((_Add_357900c2d36f40c0b7995aceda820c48_Out_2.xyz), _Property_bcb4a350b8234af79860039f232f70bb_Out_0, _NormalStrength_353fbbdfa63c4bf1a26d328b90d65d75_Out_2);
            float4 _Property_53dfc4b4cafc4a9496bd9fde6989ee8f_Out_0 = Color_b5081859698940efa07a6cc68ff92e70;
            float4 _Property_601193b6811a41eeb79befed4e93080a_Out_0 = _Shallow_Water_Color_2;
            float4 _UV_0459ed23840544d4943e249e6bf3def0_Out_0 = IN.uv0;
            float _Split_95c75a1ea7ee4dd7906396bff762bd25_R_1 = _UV_0459ed23840544d4943e249e6bf3def0_Out_0[0];
            float _Split_95c75a1ea7ee4dd7906396bff762bd25_G_2 = _UV_0459ed23840544d4943e249e6bf3def0_Out_0[1];
            float _Split_95c75a1ea7ee4dd7906396bff762bd25_B_3 = _UV_0459ed23840544d4943e249e6bf3def0_Out_0[2];
            float _Split_95c75a1ea7ee4dd7906396bff762bd25_A_4 = _UV_0459ed23840544d4943e249e6bf3def0_Out_0[3];
            float _Preview_0af5c98f89c44402ab2012c583d6f212_Out_1;
            Unity_Preview_float(_Split_95c75a1ea7ee4dd7906396bff762bd25_G_2, _Preview_0af5c98f89c44402ab2012c583d6f212_Out_1);
            float4 _Lerp_c2c00306fc734b0c8dee546205970ae6_Out_3;
            Unity_Lerp_float4(_Property_53dfc4b4cafc4a9496bd9fde6989ee8f_Out_0, _Property_601193b6811a41eeb79befed4e93080a_Out_0, (_Preview_0af5c98f89c44402ab2012c583d6f212_Out_1.xxxx), _Lerp_c2c00306fc734b0c8dee546205970ae6_Out_3);
            float4 _Property_72f89d8f335a4977a093f3bae7ef5ea1_Out_0 = Color_2bad1140d6ae465a8b096ead483f5370;
            float4 _Property_8d638ca6b7cc402595ddc523b14de263_Out_0 = Color_1;
            float4 _Lerp_25807026701046b7a4a6abcec2069726_Out_3;
            Unity_Lerp_float4(_Property_72f89d8f335a4977a093f3bae7ef5ea1_Out_0, _Property_8d638ca6b7cc402595ddc523b14de263_Out_0, (_Preview_0af5c98f89c44402ab2012c583d6f212_Out_1.xxxx), _Lerp_25807026701046b7a4a6abcec2069726_Out_3);
            float _SceneDepth_91aa5f89e7564cb2ac5171231a24afdf_Out_1;
            Unity_SceneDepth_Linear01_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_91aa5f89e7564cb2ac5171231a24afdf_Out_1);
            float _Multiply_619704251bdd44e6a8e9f02add36789c_Out_2;
            Unity_Multiply_float_float(_SceneDepth_91aa5f89e7564cb2ac5171231a24afdf_Out_1, _ProjectionParams.z, _Multiply_619704251bdd44e6a8e9f02add36789c_Out_2);
            float4 _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0 = IN.ScreenPosition;
            float _Split_eb526920998f41cd825cbe42160042f5_R_1 = _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0[0];
            float _Split_eb526920998f41cd825cbe42160042f5_G_2 = _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0[1];
            float _Split_eb526920998f41cd825cbe42160042f5_B_3 = _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0[2];
            float _Split_eb526920998f41cd825cbe42160042f5_A_4 = _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0[3];
            float _Property_f4dad9c86f154090a77929fc0594d2eb_Out_0 = Vector1_f108b0f6f7ad4a0fa7970936cde8c93a;
            float _Add_1d0b28a6a0fe41b9aea6de0b9a290419_Out_2;
            Unity_Add_float(_Split_eb526920998f41cd825cbe42160042f5_A_4, _Property_f4dad9c86f154090a77929fc0594d2eb_Out_0, _Add_1d0b28a6a0fe41b9aea6de0b9a290419_Out_2);
            float _Subtract_c310e84b25994cf7969fb6aec3c12631_Out_2;
            Unity_Subtract_float(_Multiply_619704251bdd44e6a8e9f02add36789c_Out_2, _Add_1d0b28a6a0fe41b9aea6de0b9a290419_Out_2, _Subtract_c310e84b25994cf7969fb6aec3c12631_Out_2);
            float _Property_e2cb78357bf54371b95b04624c624355_Out_0 = Vector1_77a8669616464cc68eec17e9163052aa;
            float _Multiply_77d88fee04a2411ebf64a9f3cf93ee09_Out_2;
            Unity_Multiply_float_float(_Subtract_c310e84b25994cf7969fb6aec3c12631_Out_2, _Property_e2cb78357bf54371b95b04624c624355_Out_0, _Multiply_77d88fee04a2411ebf64a9f3cf93ee09_Out_2);
            float _Clamp_5c303e7a7ab74c80819cff967500a688_Out_3;
            Unity_Clamp_float(_Multiply_77d88fee04a2411ebf64a9f3cf93ee09_Out_2, 0, 1, _Clamp_5c303e7a7ab74c80819cff967500a688_Out_3);
            float4 _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3;
            Unity_Lerp_float4(_Lerp_c2c00306fc734b0c8dee546205970ae6_Out_3, _Lerp_25807026701046b7a4a6abcec2069726_Out_3, (_Clamp_5c303e7a7ab74c80819cff967500a688_Out_3.xxxx), _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3);
            float _Split_32fd3b93931741f5ba645cdab3f37d0f_R_1 = _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3[0];
            float _Split_32fd3b93931741f5ba645cdab3f37d0f_G_2 = _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3[1];
            float _Split_32fd3b93931741f5ba645cdab3f37d0f_B_3 = _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3[2];
            float _Split_32fd3b93931741f5ba645cdab3f37d0f_A_4 = _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3[3];
            surface.NormalTS = _NormalStrength_353fbbdfa63c4bf1a26d328b90d65d75_Out_2;
            surface.Alpha = _Split_32fd3b93931741f5ba645cdab3f37d0f_A_4;
            surface.AlphaClipThreshold = 0;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
            output.uv0 =                                        input.uv0;
            output.TimeParameters =                             _TimeParameters.xyz;
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            output.MainNormal = input.MainNormal;
        output.SecondNormal = input.SecondNormal;
        
        
        
            output.TangentSpaceNormal = float3(0.0f, 0.0f, 1.0f);
        
        
            output.WorldSpacePosition = input.positionWS;
            output.ScreenPosition = ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
            output.uv0 = input.texCoord0;
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/DepthNormalsOnlyPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            Name "Meta"
            Tags
            {
                "LightMode" = "Meta"
            }
        
        // Render State
        Cull Off
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 2.0
        #pragma only_renderers gles gles3 glcore d3d11
        #pragma vertex vert
        #pragma fragment frag
        
        // DotsInstancingOptions: <None>
        // HybridV1InjectedBuiltinProperties: <None>
        
        // Keywords
        #pragma shader_feature _ EDITOR_VISUALIZATION
        // GraphKeywords: <None>
        
        // Defines
        
        #define _NORMALMAP 1
        #define _NORMAL_DROPOFF_TS 1
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define ATTRIBUTES_NEED_TEXCOORD1
        #define ATTRIBUTES_NEED_TEXCOORD2
        #define VARYINGS_NEED_POSITION_WS
        #define VARYINGS_NEED_TEXCOORD0
        #define VARYINGS_NEED_TEXCOORD1
        #define VARYINGS_NEED_TEXCOORD2
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_META
        #define _FOG_FRAGMENT 1
        #define _ALPHATEST_ON 1
        #define REQUIRE_DEPTH_TEXTURE
        #define REQUIRE_OPAQUE_TEXTURE
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/MetaInput.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
             float4 uv1 : TEXCOORD1;
             float4 uv2 : TEXCOORD2;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float3 positionWS;
             float4 texCoord0;
             float4 texCoord1;
             float4 texCoord2;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
             float2 MainNormal;
             float2 SecondNormal;
             float2 FoamDirection1;
             float2 FoamDirection2;
        };
        struct SurfaceDescriptionInputs
        {
             float3 WorldSpacePosition;
             float4 ScreenPosition;
             float4 uv0;
             float2 MainNormal;
             float2 SecondNormal;
             float2 FoamDirection1;
             float2 FoamDirection2;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
             float3 AbsoluteWorldSpacePosition;
             float4 uv0;
             float3 TimeParameters;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float3 interp0 : INTERP0;
             float4 interp1 : INTERP1;
             float4 interp2 : INTERP2;
             float4 interp3 : INTERP3;
             float4 interp4 : INTERP4;
             float4 interp5 : INTERP5;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.positionWS;
            output.interp1.xyzw =  input.texCoord0;
            output.interp2.xyzw =  input.texCoord1;
            output.interp3.xyzw =  input.texCoord2;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            output.interp4.xy =  input.MainNormal;
            output.interp4.zw =  input.SecondNormal;
            output.interp5.xy =  input.FoamDirection1;
            output.interp5.zw =  input.FoamDirection2;
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.positionWS = input.interp0.xyz;
            output.texCoord0 = input.interp1.xyzw;
            output.texCoord1 = input.interp2.xyzw;
            output.texCoord2 = input.interp3.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            output.MainNormal = input.interp4.xy;
            output.SecondNormal = input.interp4.zw;
            output.FoamDirection1 = input.interp5.xy;
            output.FoamDirection2 = input.interp5.zw;
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float4 _PlanarReflectionTexture_TexelSize;
        float Vector1_f108b0f6f7ad4a0fa7970936cde8c93a;
        float Vector1_77a8669616464cc68eec17e9163052aa;
        float4 Color_2bad1140d6ae465a8b096ead483f5370;
        float4 Color_b5081859698940efa07a6cc68ff92e70;
        float4 Color_1;
        float4 Texture2D_2d2e087224e24282b84a086f3316e6e8_TexelSize;
        float2 Vector2_c2fe4e7c2a7649b28d7ab078fdadda1c;
        float Vector1_7614a6098dec470e8a4e96a5c8551362;
        float4 Texture2D_21a78e051aa84ab49c73d2364e78102f_TexelSize;
        float2 Vector2_73fa27b3bcf64608a50eed7c1d0d3411;
        float Vector1_898460d8305d4dfe9af1298eb6f67082;
        float Vector1_0360d732cbbf426e841ca433b0e337aa;
        float Vector1_dcce861f82224ec1ac55aa94df3b3d12;
        float Vector1_3606b8114ded4a74a4e4834f8bf7dc12;
        float Vector1_69bcaf9cf50f40a2bef27afe006bbc8f;
        float4 Color_6e3aa9f38d68448bb94d493ef4e3c30a;
        float Vector1_0d98869735ab4e73a0e4bb36589d00c0;
        float Vector1_aace7401fb3a402e9f06de96963c9b84;
        float4 Texture2D_d65eb6e07c30447ca446c38272609586_TexelSize;
        float2 Vector2_2832e3b0590c4ee98f806b14c0f54c5b;
        float4 _Shallow_Water_Color_2;
        float2 _Panning;
        float _DistortionSpeed;
        float _DistortionIntensity;
        float2 _FoamNoiseTilling;
        float _DistortionScale;
        float _NoiseScale;
        float _Layer1_Scale;
        float _Layer2_Scale;
        float _RefractionDistrotion;
        float _Relection_Strength;
        CBUFFER_END
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_PlanarReflectionTexture);
        SAMPLER(sampler_PlanarReflectionTexture);
        TEXTURE2D(Texture2D_2d2e087224e24282b84a086f3316e6e8);
        SAMPLER(samplerTexture2D_2d2e087224e24282b84a086f3316e6e8);
        TEXTURE2D(Texture2D_21a78e051aa84ab49c73d2364e78102f);
        SAMPLER(samplerTexture2D_21a78e051aa84ab49c73d2364e78102f);
        TEXTURE2D(Texture2D_d65eb6e07c30447ca446c38272609586);
        SAMPLER(samplerTexture2D_d65eb6e07c30447ca446c38272609586);
        
        // Graph Includes
        // GraphIncludes: <None>
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        
        inline float Unity_SimpleNoise_RandomValue_float (float2 uv)
        {
            float angle = dot(uv, float2(12.9898, 78.233));
            #if defined(SHADER_API_MOBILE) && (defined(SHADER_API_GLES) || defined(SHADER_API_GLES3) || defined(SHADER_API_VULKAN))
                // 'sin()' has bad precision on Mali GPUs for inputs > 10000
                angle = fmod(angle, TWO_PI); // Avoid large inputs to sin()
            #endif
            return frac(sin(angle)*43758.5453);
        }
        
        inline float Unity_SimpleNnoise_Interpolate_float (float a, float b, float t)
        {
            return (1.0-t)*a + (t*b);
        }
        
        
        inline float Unity_SimpleNoise_ValueNoise_float (float2 uv)
        {
            float2 i = floor(uv);
            float2 f = frac(uv);
            f = f * f * (3.0 - 2.0 * f);
        
            uv = abs(frac(uv) - 0.5);
            float2 c0 = i + float2(0.0, 0.0);
            float2 c1 = i + float2(1.0, 0.0);
            float2 c2 = i + float2(0.0, 1.0);
            float2 c3 = i + float2(1.0, 1.0);
            float r0 = Unity_SimpleNoise_RandomValue_float(c0);
            float r1 = Unity_SimpleNoise_RandomValue_float(c1);
            float r2 = Unity_SimpleNoise_RandomValue_float(c2);
            float r3 = Unity_SimpleNoise_RandomValue_float(c3);
        
            float bottomOfGrid = Unity_SimpleNnoise_Interpolate_float(r0, r1, f.x);
            float topOfGrid = Unity_SimpleNnoise_Interpolate_float(r2, r3, f.x);
            float t = Unity_SimpleNnoise_Interpolate_float(bottomOfGrid, topOfGrid, f.y);
            return t;
        }
        void Unity_SimpleNoise_float(float2 UV, float Scale, out float Out)
        {
            float t = 0.0;
        
            float freq = pow(2.0, float(0));
            float amp = pow(0.5, float(3-0));
            t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale/freq, UV.y*Scale/freq))*amp;
        
            freq = pow(2.0, float(1));
            amp = pow(0.5, float(3-1));
            t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale/freq, UV.y*Scale/freq))*amp;
        
            freq = pow(2.0, float(2));
            amp = pow(0.5, float(3-2));
            t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale/freq, UV.y*Scale/freq))*amp;
        
            Out = t;
        }
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }
        
        void Unity_Multiply_float2_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A * B;
        }
        
        void Unity_Lerp_float2(float2 A, float2 B, float2 T, out float2 Out)
        {
            Out = lerp(A, B, T);
        }
        
        
        float2 Unity_GradientNoise_Dir_float(float2 p)
        {
            // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
            p = p % 289;
            // need full precision, otherwise half overflows when p > 1
            float x = float(34 * p.x + 1) * p.x % 289 + p.y;
            x = (34 * x + 1) * x % 289;
            x = frac(x / 41) * 2 - 1;
            return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
        }
        
        void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
        {
            float2 p = UV * Scale;
            float2 ip = floor(p);
            float2 fp = frac(p);
            float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
            float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
            float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
            float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
            fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
            Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Preview_float(float In, out float Out)
        {
            Out = In;
        }
        
        void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
        {
            Out = lerp(A, B, T);
        }
        
        void Unity_SceneDepth_Linear01_float(float4 UV, out float Out)
        {
            Out = Linear01Depth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }
        
        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }
        
        void Unity_Add_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A + B;
        }
        
        void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
        {
            Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
        }
        
        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }
        
        void Unity_SceneColor_float(float4 UV, out float3 Out)
        {
            Out = SHADERGRAPH_SAMPLE_SCENE_COLOR(UV.xy);
        }
        
        void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
        {
            Out = lerp(A, B, T);
        }
        
        void Unity_Blend_Multiply_float3(float3 Base, float3 Blend, out float3 Out, float Opacity)
        {
            Out = Base * Blend;
            Out = lerp(Base, Out, Opacity);
        }
        
        void Unity_ColorMask_float(float3 In, float3 MaskColor, float Range, out float Out, float Fuzziness)
        {
            float Distance = distance(MaskColor, In);
            Out = saturate(1 - (Distance - Range) / max(Fuzziness, 1e-5));
        }
        
        void Unity_Multiply_float4_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }
        
        void Unity_Clamp_float4(float4 In, float4 Min, float4 Max, out float4 Out)
        {
            Out = clamp(In, Min, Max);
        }
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
            float2 MainNormal;
            float2 SecondNormal;
            float2 FoamDirection1;
            float2 FoamDirection2;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            float _Property_271cd524054a48d0ac03da3ed0e18981_Out_0 = _NoiseScale;
            float _Property_d6b17372f8e24d1ba887e19ca0b9b532_Out_0 = _DistortionSpeed;
            float _Multiply_6b5e1abaf00147a8a2bd61cb3a63ac2d_Out_2;
            Unity_Multiply_float_float(0.9, _Property_d6b17372f8e24d1ba887e19ca0b9b532_Out_0, _Multiply_6b5e1abaf00147a8a2bd61cb3a63ac2d_Out_2);
            float _Multiply_0b2927096f2b406eade60b0ff8497f06_Out_2;
            Unity_Multiply_float_float(_Multiply_6b5e1abaf00147a8a2bd61cb3a63ac2d_Out_2, IN.TimeParameters.x, _Multiply_0b2927096f2b406eade60b0ff8497f06_Out_2);
            float2 _TilingAndOffset_3ae4fb84d8a24ae6b255b068ec01f495_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, float2 (1, 1), (_Multiply_0b2927096f2b406eade60b0ff8497f06_Out_2.xx), _TilingAndOffset_3ae4fb84d8a24ae6b255b068ec01f495_Out_3);
            float _SimpleNoise_310007c52b3547759f3d9a40829d9fdb_Out_2;
            Unity_SimpleNoise_float(_TilingAndOffset_3ae4fb84d8a24ae6b255b068ec01f495_Out_3, _Property_271cd524054a48d0ac03da3ed0e18981_Out_0, _SimpleNoise_310007c52b3547759f3d9a40829d9fdb_Out_2);
            float2 _Property_caf806c45b8648239ed928655b2dc075_Out_0 = _FoamNoiseTilling;
            float _Property_83fd66d76a934370a36fc75a684ef06a_Out_0 = _DistortionIntensity;
            float _Property_31ef0e62fff04fde85a1f9ac39636e5c_Out_0 = _NoiseScale;
            float _Property_1df622d21af24ccca4f9f326808f58fc_Out_0 = _DistortionSpeed;
            float _Multiply_8c038a6c11994a53b09ad756f38d3c5d_Out_2;
            Unity_Multiply_float_float(-0.9, _Property_1df622d21af24ccca4f9f326808f58fc_Out_0, _Multiply_8c038a6c11994a53b09ad756f38d3c5d_Out_2);
            float _Multiply_c710fb8d99aa474cb13c0d65aa2a1829_Out_2;
            Unity_Multiply_float_float(_Multiply_8c038a6c11994a53b09ad756f38d3c5d_Out_2, IN.TimeParameters.x, _Multiply_c710fb8d99aa474cb13c0d65aa2a1829_Out_2);
            float2 _TilingAndOffset_b5b7efd61dd0407b81b2ec53772b278d_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, float2 (1, 1), (_Multiply_c710fb8d99aa474cb13c0d65aa2a1829_Out_2.xx), _TilingAndOffset_b5b7efd61dd0407b81b2ec53772b278d_Out_3);
            float _SimpleNoise_4e904d56e17345ff8f80d57968580a32_Out_2;
            Unity_SimpleNoise_float(_TilingAndOffset_b5b7efd61dd0407b81b2ec53772b278d_Out_3, _Property_31ef0e62fff04fde85a1f9ac39636e5c_Out_0, _SimpleNoise_4e904d56e17345ff8f80d57968580a32_Out_2);
            float _Divide_2d74bf9a40ba416f9b680ba114404dc2_Out_2;
            Unity_Divide_float(IN.TimeParameters.x, 6, _Divide_2d74bf9a40ba416f9b680ba114404dc2_Out_2);
            float2 _Property_702ff1c785d542499e4ead1def7e1418_Out_0 = _Panning;
            float _Split_252c3e0a27db4d66a7df034157244e21_R_1 = _Property_702ff1c785d542499e4ead1def7e1418_Out_0[0];
            float _Split_252c3e0a27db4d66a7df034157244e21_G_2 = _Property_702ff1c785d542499e4ead1def7e1418_Out_0[1];
            float _Split_252c3e0a27db4d66a7df034157244e21_B_3 = 0;
            float _Split_252c3e0a27db4d66a7df034157244e21_A_4 = 0;
            float _Multiply_e016b9a16b4e4abba2502adb5862e043_Out_2;
            Unity_Multiply_float_float(_Split_252c3e0a27db4d66a7df034157244e21_G_2, _Divide_2d74bf9a40ba416f9b680ba114404dc2_Out_2, _Multiply_e016b9a16b4e4abba2502adb5862e043_Out_2);
            float _Multiply_218b27dc95a243998b30f016e0d3988e_Out_2;
            Unity_Multiply_float_float(_Split_252c3e0a27db4d66a7df034157244e21_R_1, _Divide_2d74bf9a40ba416f9b680ba114404dc2_Out_2, _Multiply_218b27dc95a243998b30f016e0d3988e_Out_2);
            float4 _Combine_6ae549d623c54cce9850c0bc9b3405eb_RGBA_4;
            float3 _Combine_6ae549d623c54cce9850c0bc9b3405eb_RGB_5;
            float2 _Combine_6ae549d623c54cce9850c0bc9b3405eb_RG_6;
            Unity_Combine_float(_Multiply_218b27dc95a243998b30f016e0d3988e_Out_2, _Multiply_e016b9a16b4e4abba2502adb5862e043_Out_2, 0, 0, _Combine_6ae549d623c54cce9850c0bc9b3405eb_RGBA_4, _Combine_6ae549d623c54cce9850c0bc9b3405eb_RGB_5, _Combine_6ae549d623c54cce9850c0bc9b3405eb_RG_6);
            float _Float_f89ffb73213141f1aa48acbe034e5ea3_Out_0 = 0.02;
            float2 _Swizzle_d519ed834a284e518d347105c3a11492_Out_1 = IN.AbsoluteWorldSpacePosition.xz;
            float2 _Multiply_39c33974737143ae9f76cce56d3d33d2_Out_2;
            Unity_Multiply_float2_float2(_Swizzle_d519ed834a284e518d347105c3a11492_Out_1, (_Float_f89ffb73213141f1aa48acbe034e5ea3_Out_0.xx), _Multiply_39c33974737143ae9f76cce56d3d33d2_Out_2);
            float2 _TilingAndOffset_9f5c71641fa94a59a413d51e3a6aec3d_Out_3;
            Unity_TilingAndOffset_float(_Multiply_39c33974737143ae9f76cce56d3d33d2_Out_2, float2 (1, 1), _Combine_6ae549d623c54cce9850c0bc9b3405eb_RG_6, _TilingAndOffset_9f5c71641fa94a59a413d51e3a6aec3d_Out_3);
            float2 _Lerp_6ba3378c16cf44e49e4a44f6e2f26c65_Out_3;
            Unity_Lerp_float2(_TilingAndOffset_9f5c71641fa94a59a413d51e3a6aec3d_Out_3, (_SimpleNoise_310007c52b3547759f3d9a40829d9fdb_Out_2.xx), (_Property_83fd66d76a934370a36fc75a684ef06a_Out_0.xx), _Lerp_6ba3378c16cf44e49e4a44f6e2f26c65_Out_3);
            float2 _TilingAndOffset_c89d2fcde70d4d818249ebe200337480_Out_3;
            Unity_TilingAndOffset_float(_Lerp_6ba3378c16cf44e49e4a44f6e2f26c65_Out_3, _Property_caf806c45b8648239ed928655b2dc075_Out_0, float2 (0.81, 0), _TilingAndOffset_c89d2fcde70d4d818249ebe200337480_Out_3);
            float2 _Lerp_3759f9668f544adb8dd7eee5886abeb0_Out_3;
            Unity_Lerp_float2(_TilingAndOffset_9f5c71641fa94a59a413d51e3a6aec3d_Out_3, (_SimpleNoise_4e904d56e17345ff8f80d57968580a32_Out_2.xx), (_Property_83fd66d76a934370a36fc75a684ef06a_Out_0.xx), _Lerp_3759f9668f544adb8dd7eee5886abeb0_Out_3);
            float2 _TilingAndOffset_e2926df184da41caab0fcf14e34b81a7_Out_3;
            Unity_TilingAndOffset_float(_Lerp_3759f9668f544adb8dd7eee5886abeb0_Out_3, _Property_caf806c45b8648239ed928655b2dc075_Out_0, float2 (0.81, 0), _TilingAndOffset_e2926df184da41caab0fcf14e34b81a7_Out_3);
            float _Property_8a79f817e59948938215b338bcdc46df_Out_0 = Vector1_898460d8305d4dfe9af1298eb6f67082;
            float _Multiply_ed606ef7153b456b854854134a8f65f9_Out_2;
            Unity_Multiply_float_float(_Property_8a79f817e59948938215b338bcdc46df_Out_0, 0.01, _Multiply_ed606ef7153b456b854854134a8f65f9_Out_2);
            float2 _Property_0264c1738ed14b318538f5f39eb56d07_Out_0 = Vector2_73fa27b3bcf64608a50eed7c1d0d3411;
            float _Divide_d29c49a16f234ef78eee8f12e556a643_Out_2;
            Unity_Divide_float(IN.TimeParameters.x, 5, _Divide_d29c49a16f234ef78eee8f12e556a643_Out_2);
            float _Multiply_5928ff83990b4a61bfdfa392f6154eda_Out_2;
            Unity_Multiply_float_float(_Divide_d29c49a16f234ef78eee8f12e556a643_Out_2, _Multiply_ed606ef7153b456b854854134a8f65f9_Out_2, _Multiply_5928ff83990b4a61bfdfa392f6154eda_Out_2);
            float2 _TilingAndOffset_08fa9dddbfc44f8b9e671e082ef10419_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Property_0264c1738ed14b318538f5f39eb56d07_Out_0, (_Multiply_5928ff83990b4a61bfdfa392f6154eda_Out_2.xx), _TilingAndOffset_08fa9dddbfc44f8b9e671e082ef10419_Out_3);
            float _Property_32d848f89d264e118a7bc7b7cbae9677_Out_0 = Vector1_7614a6098dec470e8a4e96a5c8551362;
            float _Multiply_1541a6ad358e4ea281033d8831f2ba13_Out_2;
            Unity_Multiply_float_float(_Property_32d848f89d264e118a7bc7b7cbae9677_Out_0, -0.01, _Multiply_1541a6ad358e4ea281033d8831f2ba13_Out_2);
            float _Multiply_edd1ffe542204260a884842fd7a18fc1_Out_2;
            Unity_Multiply_float_float(_Multiply_1541a6ad358e4ea281033d8831f2ba13_Out_2, _Divide_d29c49a16f234ef78eee8f12e556a643_Out_2, _Multiply_edd1ffe542204260a884842fd7a18fc1_Out_2);
            float2 _Property_123c8148386d41aa9d1698d86033f0b5_Out_0 = Vector2_c2fe4e7c2a7649b28d7ab078fdadda1c;
            float2 _TilingAndOffset_924ee153284a4d4abbd47514c96bb1ae_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Property_123c8148386d41aa9d1698d86033f0b5_Out_0, (_Multiply_edd1ffe542204260a884842fd7a18fc1_Out_2.xx), _TilingAndOffset_924ee153284a4d4abbd47514c96bb1ae_Out_3);
            float _Split_d8eed8fe26594972914c124586d98bbf_R_1 = IN.ObjectSpacePosition[0];
            float _Split_d8eed8fe26594972914c124586d98bbf_G_2 = IN.ObjectSpacePosition[1];
            float _Split_d8eed8fe26594972914c124586d98bbf_B_3 = IN.ObjectSpacePosition[2];
            float _Split_d8eed8fe26594972914c124586d98bbf_A_4 = 0;
            float _Property_762630e6999b4da0a14b2ccffa4209d8_Out_0 = Vector1_dcce861f82224ec1ac55aa94df3b3d12;
            float _Divide_df746930d1d841c09a66286a0a3543ae_Out_2;
            Unity_Divide_float(_Property_762630e6999b4da0a14b2ccffa4209d8_Out_0, 200, _Divide_df746930d1d841c09a66286a0a3543ae_Out_2);
            float _Property_d73cd49e4412457080da3ad6f38ac94b_Out_0 = Vector1_3606b8114ded4a74a4e4834f8bf7dc12;
            float _Divide_b14ec7aec4874b8ab4371962384288e5_Out_2;
            Unity_Divide_float(_Property_d73cd49e4412457080da3ad6f38ac94b_Out_0, 50, _Divide_b14ec7aec4874b8ab4371962384288e5_Out_2);
            float _Multiply_f97f597155bf4b59afa13426042ec0a0_Out_2;
            Unity_Multiply_float_float(IN.TimeParameters.x, _Divide_b14ec7aec4874b8ab4371962384288e5_Out_2, _Multiply_f97f597155bf4b59afa13426042ec0a0_Out_2);
            float2 _TilingAndOffset_ab2fed3c342049de89287a73af5f4dd1_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, (_Multiply_f97f597155bf4b59afa13426042ec0a0_Out_2.xx), float2 (0, 0), _TilingAndOffset_ab2fed3c342049de89287a73af5f4dd1_Out_3);
            float _GradientNoise_c349a7da229a42f6acfd0e9329f501a7_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_ab2fed3c342049de89287a73af5f4dd1_Out_3, 0.96, _GradientNoise_c349a7da229a42f6acfd0e9329f501a7_Out_2);
            float _Multiply_9460f57a023144a9ae646cb7ff3c8354_Out_2;
            Unity_Multiply_float_float(_Divide_df746930d1d841c09a66286a0a3543ae_Out_2, _GradientNoise_c349a7da229a42f6acfd0e9329f501a7_Out_2, _Multiply_9460f57a023144a9ae646cb7ff3c8354_Out_2);
            float _Add_5cf9a595f1104a0ba7d0c02acbf47625_Out_2;
            Unity_Add_float(_Split_d8eed8fe26594972914c124586d98bbf_G_2, _Multiply_9460f57a023144a9ae646cb7ff3c8354_Out_2, _Add_5cf9a595f1104a0ba7d0c02acbf47625_Out_2);
            float4 _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGBA_4;
            float3 _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGB_5;
            float2 _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RG_6;
            Unity_Combine_float(_Split_d8eed8fe26594972914c124586d98bbf_R_1, _Add_5cf9a595f1104a0ba7d0c02acbf47625_Out_2, _Split_d8eed8fe26594972914c124586d98bbf_B_3, 0, _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGBA_4, _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGB_5, _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RG_6);
            description.Position = _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGB_5;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            description.MainNormal = _TilingAndOffset_924ee153284a4d4abbd47514c96bb1ae_Out_3;
            description.SecondNormal = _TilingAndOffset_08fa9dddbfc44f8b9e671e082ef10419_Out_3;
            description.FoamDirection1 = _TilingAndOffset_e2926df184da41caab0fcf14e34b81a7_Out_3;
            description.FoamDirection2 = _TilingAndOffset_c89d2fcde70d4d818249ebe200337480_Out_3;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        output.MainNormal = input.MainNormal;
        output.SecondNormal = input.SecondNormal;
        output.FoamDirection1 = input.FoamDirection1;
        output.FoamDirection2 = input.FoamDirection2;
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float3 BaseColor;
            float3 Emission;
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float4 _Property_53dfc4b4cafc4a9496bd9fde6989ee8f_Out_0 = Color_b5081859698940efa07a6cc68ff92e70;
            float4 _Property_601193b6811a41eeb79befed4e93080a_Out_0 = _Shallow_Water_Color_2;
            float4 _UV_0459ed23840544d4943e249e6bf3def0_Out_0 = IN.uv0;
            float _Split_95c75a1ea7ee4dd7906396bff762bd25_R_1 = _UV_0459ed23840544d4943e249e6bf3def0_Out_0[0];
            float _Split_95c75a1ea7ee4dd7906396bff762bd25_G_2 = _UV_0459ed23840544d4943e249e6bf3def0_Out_0[1];
            float _Split_95c75a1ea7ee4dd7906396bff762bd25_B_3 = _UV_0459ed23840544d4943e249e6bf3def0_Out_0[2];
            float _Split_95c75a1ea7ee4dd7906396bff762bd25_A_4 = _UV_0459ed23840544d4943e249e6bf3def0_Out_0[3];
            float _Preview_0af5c98f89c44402ab2012c583d6f212_Out_1;
            Unity_Preview_float(_Split_95c75a1ea7ee4dd7906396bff762bd25_G_2, _Preview_0af5c98f89c44402ab2012c583d6f212_Out_1);
            float4 _Lerp_c2c00306fc734b0c8dee546205970ae6_Out_3;
            Unity_Lerp_float4(_Property_53dfc4b4cafc4a9496bd9fde6989ee8f_Out_0, _Property_601193b6811a41eeb79befed4e93080a_Out_0, (_Preview_0af5c98f89c44402ab2012c583d6f212_Out_1.xxxx), _Lerp_c2c00306fc734b0c8dee546205970ae6_Out_3);
            float4 _Property_72f89d8f335a4977a093f3bae7ef5ea1_Out_0 = Color_2bad1140d6ae465a8b096ead483f5370;
            float4 _Property_8d638ca6b7cc402595ddc523b14de263_Out_0 = Color_1;
            float4 _Lerp_25807026701046b7a4a6abcec2069726_Out_3;
            Unity_Lerp_float4(_Property_72f89d8f335a4977a093f3bae7ef5ea1_Out_0, _Property_8d638ca6b7cc402595ddc523b14de263_Out_0, (_Preview_0af5c98f89c44402ab2012c583d6f212_Out_1.xxxx), _Lerp_25807026701046b7a4a6abcec2069726_Out_3);
            float _SceneDepth_91aa5f89e7564cb2ac5171231a24afdf_Out_1;
            Unity_SceneDepth_Linear01_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_91aa5f89e7564cb2ac5171231a24afdf_Out_1);
            float _Multiply_619704251bdd44e6a8e9f02add36789c_Out_2;
            Unity_Multiply_float_float(_SceneDepth_91aa5f89e7564cb2ac5171231a24afdf_Out_1, _ProjectionParams.z, _Multiply_619704251bdd44e6a8e9f02add36789c_Out_2);
            float4 _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0 = IN.ScreenPosition;
            float _Split_eb526920998f41cd825cbe42160042f5_R_1 = _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0[0];
            float _Split_eb526920998f41cd825cbe42160042f5_G_2 = _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0[1];
            float _Split_eb526920998f41cd825cbe42160042f5_B_3 = _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0[2];
            float _Split_eb526920998f41cd825cbe42160042f5_A_4 = _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0[3];
            float _Property_f4dad9c86f154090a77929fc0594d2eb_Out_0 = Vector1_f108b0f6f7ad4a0fa7970936cde8c93a;
            float _Add_1d0b28a6a0fe41b9aea6de0b9a290419_Out_2;
            Unity_Add_float(_Split_eb526920998f41cd825cbe42160042f5_A_4, _Property_f4dad9c86f154090a77929fc0594d2eb_Out_0, _Add_1d0b28a6a0fe41b9aea6de0b9a290419_Out_2);
            float _Subtract_c310e84b25994cf7969fb6aec3c12631_Out_2;
            Unity_Subtract_float(_Multiply_619704251bdd44e6a8e9f02add36789c_Out_2, _Add_1d0b28a6a0fe41b9aea6de0b9a290419_Out_2, _Subtract_c310e84b25994cf7969fb6aec3c12631_Out_2);
            float _Property_e2cb78357bf54371b95b04624c624355_Out_0 = Vector1_77a8669616464cc68eec17e9163052aa;
            float _Multiply_77d88fee04a2411ebf64a9f3cf93ee09_Out_2;
            Unity_Multiply_float_float(_Subtract_c310e84b25994cf7969fb6aec3c12631_Out_2, _Property_e2cb78357bf54371b95b04624c624355_Out_0, _Multiply_77d88fee04a2411ebf64a9f3cf93ee09_Out_2);
            float _Clamp_5c303e7a7ab74c80819cff967500a688_Out_3;
            Unity_Clamp_float(_Multiply_77d88fee04a2411ebf64a9f3cf93ee09_Out_2, 0, 1, _Clamp_5c303e7a7ab74c80819cff967500a688_Out_3);
            float4 _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3;
            Unity_Lerp_float4(_Lerp_c2c00306fc734b0c8dee546205970ae6_Out_3, _Lerp_25807026701046b7a4a6abcec2069726_Out_3, (_Clamp_5c303e7a7ab74c80819cff967500a688_Out_3.xxxx), _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3);
            UnityTexture2D _Property_691307347e93408bb228020d56a4f64e_Out_0 = UnityBuildTexture2DStructNoScale(Texture2D_2d2e087224e24282b84a086f3316e6e8);
            float4 _SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0 = SAMPLE_TEXTURE2D(_Property_691307347e93408bb228020d56a4f64e_Out_0.tex, _Property_691307347e93408bb228020d56a4f64e_Out_0.samplerstate, _Property_691307347e93408bb228020d56a4f64e_Out_0.GetTransformedUV(IN.MainNormal));
            _SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0);
            float _SampleTexture2D_3802527e187e464aa45999485a38f24f_R_4 = _SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0.r;
            float _SampleTexture2D_3802527e187e464aa45999485a38f24f_G_5 = _SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0.g;
            float _SampleTexture2D_3802527e187e464aa45999485a38f24f_B_6 = _SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0.b;
            float _SampleTexture2D_3802527e187e464aa45999485a38f24f_A_7 = _SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0.a;
            UnityTexture2D _Property_162be1870c564d31abda704370ecd112_Out_0 = UnityBuildTexture2DStructNoScale(Texture2D_21a78e051aa84ab49c73d2364e78102f);
            float4 _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0 = SAMPLE_TEXTURE2D(_Property_162be1870c564d31abda704370ecd112_Out_0.tex, _Property_162be1870c564d31abda704370ecd112_Out_0.samplerstate, _Property_162be1870c564d31abda704370ecd112_Out_0.GetTransformedUV(IN.SecondNormal));
            _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0);
            float _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_R_4 = _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0.r;
            float _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_G_5 = _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0.g;
            float _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_B_6 = _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0.b;
            float _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_A_7 = _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0.a;
            float4 _Add_357900c2d36f40c0b7995aceda820c48_Out_2;
            Unity_Add_float4(_SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0, _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0, _Add_357900c2d36f40c0b7995aceda820c48_Out_2);
            float _Property_bcb4a350b8234af79860039f232f70bb_Out_0 = Vector1_0360d732cbbf426e841ca433b0e337aa;
            float3 _NormalStrength_353fbbdfa63c4bf1a26d328b90d65d75_Out_2;
            Unity_NormalStrength_float((_Add_357900c2d36f40c0b7995aceda820c48_Out_2.xyz), _Property_bcb4a350b8234af79860039f232f70bb_Out_0, _NormalStrength_353fbbdfa63c4bf1a26d328b90d65d75_Out_2);
            float _Property_435f8911f9614444bccaa1b491910830_Out_0 = _RefractionDistrotion;
            float3 _NormalStrength_c661b7411e0343adbe9cd03e17ec5587_Out_2;
            Unity_NormalStrength_float(_NormalStrength_353fbbdfa63c4bf1a26d328b90d65d75_Out_2, _Property_435f8911f9614444bccaa1b491910830_Out_0, _NormalStrength_c661b7411e0343adbe9cd03e17ec5587_Out_2);
            float4 _ScreenPosition_8195cd06776241d5b37929c91c6dad48_Out_0 = float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0);
            float3 _Add_b257228ea21d4b4d977a6133326b7e06_Out_2;
            Unity_Add_float3(_NormalStrength_c661b7411e0343adbe9cd03e17ec5587_Out_2, (_ScreenPosition_8195cd06776241d5b37929c91c6dad48_Out_0.xyz), _Add_b257228ea21d4b4d977a6133326b7e06_Out_2);
            float3 _SceneColor_2c332a05662541f2bba2d1b5eeb47bd2_Out_1;
            Unity_SceneColor_float((float4(_Add_b257228ea21d4b4d977a6133326b7e06_Out_2, 1.0)), _SceneColor_2c332a05662541f2bba2d1b5eeb47bd2_Out_1);
            UnityTexture2D _Property_c55f1526f461489aa2011515ec7da3a3_Out_0 = UnityBuildTexture2DStructNoScale(_PlanarReflectionTexture);
            float3 _Add_9cc9802b3ef24c21b8771b375a3bff42_Out_2;
            Unity_Add_float3(_NormalStrength_353fbbdfa63c4bf1a26d328b90d65d75_Out_2, (_Clamp_5c303e7a7ab74c80819cff967500a688_Out_3.xxx), _Add_9cc9802b3ef24c21b8771b375a3bff42_Out_2);
            float3 _NormalStrength_6161489259bb4747ba0928987b51a0ea_Out_2;
            Unity_NormalStrength_float(_Add_9cc9802b3ef24c21b8771b375a3bff42_Out_2, _Property_435f8911f9614444bccaa1b491910830_Out_0, _NormalStrength_6161489259bb4747ba0928987b51a0ea_Out_2);
            float3 _Add_51f05a9faaf74e72812fae8a48ed882c_Out_2;
            Unity_Add_float3((_ScreenPosition_8195cd06776241d5b37929c91c6dad48_Out_0.xyz), _NormalStrength_6161489259bb4747ba0928987b51a0ea_Out_2, _Add_51f05a9faaf74e72812fae8a48ed882c_Out_2);
            float4 _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_RGBA_0 = SAMPLE_TEXTURE2D(_Property_c55f1526f461489aa2011515ec7da3a3_Out_0.tex, _Property_c55f1526f461489aa2011515ec7da3a3_Out_0.samplerstate, _Property_c55f1526f461489aa2011515ec7da3a3_Out_0.GetTransformedUV((_Add_51f05a9faaf74e72812fae8a48ed882c_Out_2.xy)));
            float _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_R_4 = _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_RGBA_0.r;
            float _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_G_5 = _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_RGBA_0.g;
            float _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_B_6 = _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_RGBA_0.b;
            float _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_A_7 = _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_RGBA_0.a;
            float3 _Lerp_6bca2423774749ccb6b3d02c089ca6aa_Out_3;
            Unity_Lerp_float3(_SceneColor_2c332a05662541f2bba2d1b5eeb47bd2_Out_1, (_SampleTexture2D_60a5b90e4760409a9760488b39b95feb_RGBA_0.xyz), (_Clamp_5c303e7a7ab74c80819cff967500a688_Out_3.xxx), _Lerp_6bca2423774749ccb6b3d02c089ca6aa_Out_3);
            float _Property_4267d14b41a64c8faa1146ffbcfe3618_Out_0 = _Relection_Strength;
            float3 _Blend_1d413404067041f1a38d59c008106e23_Out_2;
            Unity_Blend_Multiply_float3((_Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3.xyz), _Lerp_6bca2423774749ccb6b3d02c089ca6aa_Out_3, _Blend_1d413404067041f1a38d59c008106e23_Out_2, _Property_4267d14b41a64c8faa1146ffbcfe3618_Out_0);
            UnityTexture2D _Property_dff6df0bd4d4495f97a7a18e11ec195a_Out_0 = UnityBuildTexture2DStructNoScale(Texture2D_2d2e087224e24282b84a086f3316e6e8);
            float4 _SampleTexture2D_fd9ae2c1f81b405e9021849934e7146d_RGBA_0 = SAMPLE_TEXTURE2D(_Property_dff6df0bd4d4495f97a7a18e11ec195a_Out_0.tex, _Property_dff6df0bd4d4495f97a7a18e11ec195a_Out_0.samplerstate, _Property_dff6df0bd4d4495f97a7a18e11ec195a_Out_0.GetTransformedUV(IN.MainNormal));
            float _SampleTexture2D_fd9ae2c1f81b405e9021849934e7146d_R_4 = _SampleTexture2D_fd9ae2c1f81b405e9021849934e7146d_RGBA_0.r;
            float _SampleTexture2D_fd9ae2c1f81b405e9021849934e7146d_G_5 = _SampleTexture2D_fd9ae2c1f81b405e9021849934e7146d_RGBA_0.g;
            float _SampleTexture2D_fd9ae2c1f81b405e9021849934e7146d_B_6 = _SampleTexture2D_fd9ae2c1f81b405e9021849934e7146d_RGBA_0.b;
            float _SampleTexture2D_fd9ae2c1f81b405e9021849934e7146d_A_7 = _SampleTexture2D_fd9ae2c1f81b405e9021849934e7146d_RGBA_0.a;
            UnityTexture2D _Property_f0238f5adf1d400c886a5a72ea8e3800_Out_0 = UnityBuildTexture2DStructNoScale(Texture2D_2d2e087224e24282b84a086f3316e6e8);
            float4 _SampleTexture2D_b5339f18d32e4578951e0bd01553c041_RGBA_0 = SAMPLE_TEXTURE2D(_Property_f0238f5adf1d400c886a5a72ea8e3800_Out_0.tex, _Property_f0238f5adf1d400c886a5a72ea8e3800_Out_0.samplerstate, _Property_f0238f5adf1d400c886a5a72ea8e3800_Out_0.GetTransformedUV(IN.SecondNormal));
            float _SampleTexture2D_b5339f18d32e4578951e0bd01553c041_R_4 = _SampleTexture2D_b5339f18d32e4578951e0bd01553c041_RGBA_0.r;
            float _SampleTexture2D_b5339f18d32e4578951e0bd01553c041_G_5 = _SampleTexture2D_b5339f18d32e4578951e0bd01553c041_RGBA_0.g;
            float _SampleTexture2D_b5339f18d32e4578951e0bd01553c041_B_6 = _SampleTexture2D_b5339f18d32e4578951e0bd01553c041_RGBA_0.b;
            float _SampleTexture2D_b5339f18d32e4578951e0bd01553c041_A_7 = _SampleTexture2D_b5339f18d32e4578951e0bd01553c041_RGBA_0.a;
            float4 _Add_f4d1aaeeebe741bfac01df2cb63237d2_Out_2;
            Unity_Add_float4(_SampleTexture2D_fd9ae2c1f81b405e9021849934e7146d_RGBA_0, _SampleTexture2D_b5339f18d32e4578951e0bd01553c041_RGBA_0, _Add_f4d1aaeeebe741bfac01df2cb63237d2_Out_2);
            float _Property_94bcaaa57baf401a892936e8d1121760_Out_0 = _Layer1_Scale;
            float _ColorMask_3b67330abbfa4d5da09be858fde593ec_Out_3;
            Unity_ColorMask_float((_Add_f4d1aaeeebe741bfac01df2cb63237d2_Out_2.xyz), IsGammaSpace() ? float3(1, 1, 1) : SRGBToLinear(float3(1, 1, 1)), _Property_94bcaaa57baf401a892936e8d1121760_Out_0, _ColorMask_3b67330abbfa4d5da09be858fde593ec_Out_3, 0.4);
            UnityTexture2D _Property_edbfda5e1a564ea2aad094a54bb3b007_Out_0 = UnityBuildTexture2DStructNoScale(Texture2D_d65eb6e07c30447ca446c38272609586);
            float4 _SampleTexture2D_7464425046b24f39b9304827ccb6101e_RGBA_0 = SAMPLE_TEXTURE2D(_Property_edbfda5e1a564ea2aad094a54bb3b007_Out_0.tex, _Property_edbfda5e1a564ea2aad094a54bb3b007_Out_0.samplerstate, _Property_edbfda5e1a564ea2aad094a54bb3b007_Out_0.GetTransformedUV(IN.FoamDirection1));
            float _SampleTexture2D_7464425046b24f39b9304827ccb6101e_R_4 = _SampleTexture2D_7464425046b24f39b9304827ccb6101e_RGBA_0.r;
            float _SampleTexture2D_7464425046b24f39b9304827ccb6101e_G_5 = _SampleTexture2D_7464425046b24f39b9304827ccb6101e_RGBA_0.g;
            float _SampleTexture2D_7464425046b24f39b9304827ccb6101e_B_6 = _SampleTexture2D_7464425046b24f39b9304827ccb6101e_RGBA_0.b;
            float _SampleTexture2D_7464425046b24f39b9304827ccb6101e_A_7 = _SampleTexture2D_7464425046b24f39b9304827ccb6101e_RGBA_0.a;
            float4 _Property_05ee1312567a419ea766bcaa855dc2ed_Out_0 = Color_6e3aa9f38d68448bb94d493ef4e3c30a;
            float4 _Multiply_75f2ec69c46847e5aaea2cd6420daa9e_Out_2;
            Unity_Multiply_float4_float4((_SampleTexture2D_7464425046b24f39b9304827ccb6101e_G_5.xxxx), _Property_05ee1312567a419ea766bcaa855dc2ed_Out_0, _Multiply_75f2ec69c46847e5aaea2cd6420daa9e_Out_2);
            float4 _Multiply_e5480cb837904b4ab771dec3029ac8d6_Out_2;
            Unity_Multiply_float4_float4((_ColorMask_3b67330abbfa4d5da09be858fde593ec_Out_3.xxxx), _Multiply_75f2ec69c46847e5aaea2cd6420daa9e_Out_2, _Multiply_e5480cb837904b4ab771dec3029ac8d6_Out_2);
            float _Property_aff115291912400081bcc3de12f2f8ec_Out_0 = _Layer2_Scale;
            float _ColorMask_c2b65a71e09b4b4a97fc255b1947e69e_Out_3;
            Unity_ColorMask_float((_Add_f4d1aaeeebe741bfac01df2cb63237d2_Out_2.xyz), IsGammaSpace() ? float3(1, 1, 1) : SRGBToLinear(float3(1, 1, 1)), _Property_aff115291912400081bcc3de12f2f8ec_Out_0, _ColorMask_c2b65a71e09b4b4a97fc255b1947e69e_Out_3, 0.4);
            float4 _SampleTexture2D_4dcd9985d6b54ac3a3070127f41fef44_RGBA_0 = SAMPLE_TEXTURE2D(_Property_edbfda5e1a564ea2aad094a54bb3b007_Out_0.tex, _Property_edbfda5e1a564ea2aad094a54bb3b007_Out_0.samplerstate, _Property_edbfda5e1a564ea2aad094a54bb3b007_Out_0.GetTransformedUV(IN.FoamDirection2));
            float _SampleTexture2D_4dcd9985d6b54ac3a3070127f41fef44_R_4 = _SampleTexture2D_4dcd9985d6b54ac3a3070127f41fef44_RGBA_0.r;
            float _SampleTexture2D_4dcd9985d6b54ac3a3070127f41fef44_G_5 = _SampleTexture2D_4dcd9985d6b54ac3a3070127f41fef44_RGBA_0.g;
            float _SampleTexture2D_4dcd9985d6b54ac3a3070127f41fef44_B_6 = _SampleTexture2D_4dcd9985d6b54ac3a3070127f41fef44_RGBA_0.b;
            float _SampleTexture2D_4dcd9985d6b54ac3a3070127f41fef44_A_7 = _SampleTexture2D_4dcd9985d6b54ac3a3070127f41fef44_RGBA_0.a;
            float4 _Multiply_d1696f7e6e5a4cdcae3d545c0dab56c5_Out_2;
            Unity_Multiply_float4_float4(_Property_05ee1312567a419ea766bcaa855dc2ed_Out_0, (_SampleTexture2D_4dcd9985d6b54ac3a3070127f41fef44_B_6.xxxx), _Multiply_d1696f7e6e5a4cdcae3d545c0dab56c5_Out_2);
            float4 _Multiply_7ddead3a69614c469917ed7b9aafa900_Out_2;
            Unity_Multiply_float4_float4((_ColorMask_c2b65a71e09b4b4a97fc255b1947e69e_Out_3.xxxx), _Multiply_d1696f7e6e5a4cdcae3d545c0dab56c5_Out_2, _Multiply_7ddead3a69614c469917ed7b9aafa900_Out_2);
            float4 _Add_d1b55de8d8eb46d5be51b419333fbee1_Out_2;
            Unity_Add_float4(_Multiply_e5480cb837904b4ab771dec3029ac8d6_Out_2, _Multiply_7ddead3a69614c469917ed7b9aafa900_Out_2, _Add_d1b55de8d8eb46d5be51b419333fbee1_Out_2);
            float4 _Property_91c7296a1fd34a6ba4ba2db430b227cf_Out_0 = Color_6e3aa9f38d68448bb94d493ef4e3c30a;
            float _Property_25ca0be5c8024b6984b39cc03c10699e_Out_0 = Vector1_aace7401fb3a402e9f06de96963c9b84;
            float _Subtract_af5fef32a00b4cd4863e59c7a5aa9f5c_Out_2;
            Unity_Subtract_float(_Multiply_619704251bdd44e6a8e9f02add36789c_Out_2, _Split_eb526920998f41cd825cbe42160042f5_A_4, _Subtract_af5fef32a00b4cd4863e59c7a5aa9f5c_Out_2);
            float _Subtract_5cb3b9da51094bfc9691cff775ed046c_Out_2;
            Unity_Subtract_float(_Property_25ca0be5c8024b6984b39cc03c10699e_Out_0, _Subtract_af5fef32a00b4cd4863e59c7a5aa9f5c_Out_2, _Subtract_5cb3b9da51094bfc9691cff775ed046c_Out_2);
            float _Property_ddab7adb8fc8414e903ddbb8f8b183e2_Out_0 = Vector1_0d98869735ab4e73a0e4bb36589d00c0;
            float _Multiply_efbf135285134c28b8a80ff0e4ba3f17_Out_2;
            Unity_Multiply_float_float(_Subtract_5cb3b9da51094bfc9691cff775ed046c_Out_2, _Property_ddab7adb8fc8414e903ddbb8f8b183e2_Out_0, _Multiply_efbf135285134c28b8a80ff0e4ba3f17_Out_2);
            float4 _Multiply_92e7da0ce3c448e0a75776463e054f66_Out_2;
            Unity_Multiply_float4_float4(_Property_91c7296a1fd34a6ba4ba2db430b227cf_Out_0, (_Multiply_efbf135285134c28b8a80ff0e4ba3f17_Out_2.xxxx), _Multiply_92e7da0ce3c448e0a75776463e054f66_Out_2);
            UnityTexture2D _Property_2613ec34f9504d22aafecb7ad6480e1e_Out_0 = UnityBuildTexture2DStructNoScale(Texture2D_d65eb6e07c30447ca446c38272609586);
            float2 _Property_49ee0e056d6942968b9200a4a85c3251_Out_0 = Vector2_2832e3b0590c4ee98f806b14c0f54c5b;
            float2 _TilingAndOffset_b50bda6ad9b140f9b0ca863214f6b957_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Property_49ee0e056d6942968b9200a4a85c3251_Out_0, float2 (0.18, 0), _TilingAndOffset_b50bda6ad9b140f9b0ca863214f6b957_Out_3);
            float4 _SampleTexture2D_00f1f15016c649f0ae4e0c96597e573f_RGBA_0 = SAMPLE_TEXTURE2D(_Property_2613ec34f9504d22aafecb7ad6480e1e_Out_0.tex, _Property_2613ec34f9504d22aafecb7ad6480e1e_Out_0.samplerstate, _Property_2613ec34f9504d22aafecb7ad6480e1e_Out_0.GetTransformedUV(_TilingAndOffset_b50bda6ad9b140f9b0ca863214f6b957_Out_3));
            float _SampleTexture2D_00f1f15016c649f0ae4e0c96597e573f_R_4 = _SampleTexture2D_00f1f15016c649f0ae4e0c96597e573f_RGBA_0.r;
            float _SampleTexture2D_00f1f15016c649f0ae4e0c96597e573f_G_5 = _SampleTexture2D_00f1f15016c649f0ae4e0c96597e573f_RGBA_0.g;
            float _SampleTexture2D_00f1f15016c649f0ae4e0c96597e573f_B_6 = _SampleTexture2D_00f1f15016c649f0ae4e0c96597e573f_RGBA_0.b;
            float _SampleTexture2D_00f1f15016c649f0ae4e0c96597e573f_A_7 = _SampleTexture2D_00f1f15016c649f0ae4e0c96597e573f_RGBA_0.a;
            float4 _Multiply_4f081b87dfcb4a41bb7615b058040e89_Out_2;
            Unity_Multiply_float4_float4(_Multiply_92e7da0ce3c448e0a75776463e054f66_Out_2, (_SampleTexture2D_00f1f15016c649f0ae4e0c96597e573f_G_5.xxxx), _Multiply_4f081b87dfcb4a41bb7615b058040e89_Out_2);
            float4 _Clamp_3a0f28c23b344448ac636ad89dbdb3e7_Out_3;
            Unity_Clamp_float4(_Multiply_4f081b87dfcb4a41bb7615b058040e89_Out_2, float4(0, 0, 0, 0), float4(1, 1, 1, 1), _Clamp_3a0f28c23b344448ac636ad89dbdb3e7_Out_3);
            float4 _Add_fb079be2c07b4115bae3a3c384291108_Out_2;
            Unity_Add_float4(_Add_d1b55de8d8eb46d5be51b419333fbee1_Out_2, _Clamp_3a0f28c23b344448ac636ad89dbdb3e7_Out_3, _Add_fb079be2c07b4115bae3a3c384291108_Out_2);
            float _Split_32fd3b93931741f5ba645cdab3f37d0f_R_1 = _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3[0];
            float _Split_32fd3b93931741f5ba645cdab3f37d0f_G_2 = _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3[1];
            float _Split_32fd3b93931741f5ba645cdab3f37d0f_B_3 = _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3[2];
            float _Split_32fd3b93931741f5ba645cdab3f37d0f_A_4 = _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3[3];
            surface.BaseColor = _Blend_1d413404067041f1a38d59c008106e23_Out_2;
            surface.Emission = (_Add_fb079be2c07b4115bae3a3c384291108_Out_2.xyz);
            surface.Alpha = _Split_32fd3b93931741f5ba645cdab3f37d0f_A_4;
            surface.AlphaClipThreshold = 0;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
            output.AbsoluteWorldSpacePosition =                 GetAbsolutePositionWS(TransformObjectToWorld(input.positionOS));
            output.uv0 =                                        input.uv0;
            output.TimeParameters =                             _TimeParameters.xyz;
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            output.MainNormal = input.MainNormal;
        output.SecondNormal = input.SecondNormal;
        output.FoamDirection1 = input.FoamDirection1;
        output.FoamDirection2 = input.FoamDirection2;
        
        
        
        
        
            output.WorldSpacePosition = input.positionWS;
            output.ScreenPosition = ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
            output.uv0 = input.texCoord0;
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/LightingMetaPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            Name "SceneSelectionPass"
            Tags
            {
                "LightMode" = "SceneSelectionPass"
            }
        
        // Render State
        Cull Off
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 2.0
        #pragma only_renderers gles gles3 glcore d3d11
        #pragma multi_compile_instancing
        #pragma vertex vert
        #pragma fragment frag
        
        // DotsInstancingOptions: <None>
        // HybridV1InjectedBuiltinProperties: <None>
        
        // Keywords
        // PassKeywords: <None>
        // GraphKeywords: <None>
        
        // Defines
        
        #define _NORMALMAP 1
        #define _NORMAL_DROPOFF_TS 1
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define VARYINGS_NEED_POSITION_WS
        #define VARYINGS_NEED_TEXCOORD0
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_DEPTHONLY
        #define SCENESELECTIONPASS 1
        #define ALPHA_CLIP_THRESHOLD 1
        #define _ALPHATEST_ON 1
        #define REQUIRE_DEPTH_TEXTURE
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float3 positionWS;
             float4 texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
             float3 WorldSpacePosition;
             float4 ScreenPosition;
             float4 uv0;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
             float4 uv0;
             float3 TimeParameters;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float3 interp0 : INTERP0;
             float4 interp1 : INTERP1;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.positionWS;
            output.interp1.xyzw =  input.texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.positionWS = input.interp0.xyz;
            output.texCoord0 = input.interp1.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float4 _PlanarReflectionTexture_TexelSize;
        float Vector1_f108b0f6f7ad4a0fa7970936cde8c93a;
        float Vector1_77a8669616464cc68eec17e9163052aa;
        float4 Color_2bad1140d6ae465a8b096ead483f5370;
        float4 Color_b5081859698940efa07a6cc68ff92e70;
        float4 Color_1;
        float4 Texture2D_2d2e087224e24282b84a086f3316e6e8_TexelSize;
        float2 Vector2_c2fe4e7c2a7649b28d7ab078fdadda1c;
        float Vector1_7614a6098dec470e8a4e96a5c8551362;
        float4 Texture2D_21a78e051aa84ab49c73d2364e78102f_TexelSize;
        float2 Vector2_73fa27b3bcf64608a50eed7c1d0d3411;
        float Vector1_898460d8305d4dfe9af1298eb6f67082;
        float Vector1_0360d732cbbf426e841ca433b0e337aa;
        float Vector1_dcce861f82224ec1ac55aa94df3b3d12;
        float Vector1_3606b8114ded4a74a4e4834f8bf7dc12;
        float Vector1_69bcaf9cf50f40a2bef27afe006bbc8f;
        float4 Color_6e3aa9f38d68448bb94d493ef4e3c30a;
        float Vector1_0d98869735ab4e73a0e4bb36589d00c0;
        float Vector1_aace7401fb3a402e9f06de96963c9b84;
        float4 Texture2D_d65eb6e07c30447ca446c38272609586_TexelSize;
        float2 Vector2_2832e3b0590c4ee98f806b14c0f54c5b;
        float4 _Shallow_Water_Color_2;
        float2 _Panning;
        float _DistortionSpeed;
        float _DistortionIntensity;
        float2 _FoamNoiseTilling;
        float _DistortionScale;
        float _NoiseScale;
        float _Layer1_Scale;
        float _Layer2_Scale;
        float _RefractionDistrotion;
        float _Relection_Strength;
        CBUFFER_END
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_PlanarReflectionTexture);
        SAMPLER(sampler_PlanarReflectionTexture);
        TEXTURE2D(Texture2D_2d2e087224e24282b84a086f3316e6e8);
        SAMPLER(samplerTexture2D_2d2e087224e24282b84a086f3316e6e8);
        TEXTURE2D(Texture2D_21a78e051aa84ab49c73d2364e78102f);
        SAMPLER(samplerTexture2D_21a78e051aa84ab49c73d2364e78102f);
        TEXTURE2D(Texture2D_d65eb6e07c30447ca446c38272609586);
        SAMPLER(samplerTexture2D_d65eb6e07c30447ca446c38272609586);
        
        // Graph Includes
        // GraphIncludes: <None>
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        
        float2 Unity_GradientNoise_Dir_float(float2 p)
        {
            // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
            p = p % 289;
            // need full precision, otherwise half overflows when p > 1
            float x = float(34 * p.x + 1) * p.x % 289 + p.y;
            x = (34 * x + 1) * x % 289;
            x = frac(x / 41) * 2 - 1;
            return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
        }
        
        void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
        {
            float2 p = UV * Scale;
            float2 ip = floor(p);
            float2 fp = frac(p);
            float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
            float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
            float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
            float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
            fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
            Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }
        
        void Unity_Preview_float(float In, out float Out)
        {
            Out = In;
        }
        
        void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
        {
            Out = lerp(A, B, T);
        }
        
        void Unity_SceneDepth_Linear01_float(float4 UV, out float Out)
        {
            Out = Linear01Depth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }
        
        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            float _Split_d8eed8fe26594972914c124586d98bbf_R_1 = IN.ObjectSpacePosition[0];
            float _Split_d8eed8fe26594972914c124586d98bbf_G_2 = IN.ObjectSpacePosition[1];
            float _Split_d8eed8fe26594972914c124586d98bbf_B_3 = IN.ObjectSpacePosition[2];
            float _Split_d8eed8fe26594972914c124586d98bbf_A_4 = 0;
            float _Property_762630e6999b4da0a14b2ccffa4209d8_Out_0 = Vector1_dcce861f82224ec1ac55aa94df3b3d12;
            float _Divide_df746930d1d841c09a66286a0a3543ae_Out_2;
            Unity_Divide_float(_Property_762630e6999b4da0a14b2ccffa4209d8_Out_0, 200, _Divide_df746930d1d841c09a66286a0a3543ae_Out_2);
            float _Property_d73cd49e4412457080da3ad6f38ac94b_Out_0 = Vector1_3606b8114ded4a74a4e4834f8bf7dc12;
            float _Divide_b14ec7aec4874b8ab4371962384288e5_Out_2;
            Unity_Divide_float(_Property_d73cd49e4412457080da3ad6f38ac94b_Out_0, 50, _Divide_b14ec7aec4874b8ab4371962384288e5_Out_2);
            float _Multiply_f97f597155bf4b59afa13426042ec0a0_Out_2;
            Unity_Multiply_float_float(IN.TimeParameters.x, _Divide_b14ec7aec4874b8ab4371962384288e5_Out_2, _Multiply_f97f597155bf4b59afa13426042ec0a0_Out_2);
            float2 _TilingAndOffset_ab2fed3c342049de89287a73af5f4dd1_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, (_Multiply_f97f597155bf4b59afa13426042ec0a0_Out_2.xx), float2 (0, 0), _TilingAndOffset_ab2fed3c342049de89287a73af5f4dd1_Out_3);
            float _GradientNoise_c349a7da229a42f6acfd0e9329f501a7_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_ab2fed3c342049de89287a73af5f4dd1_Out_3, 0.96, _GradientNoise_c349a7da229a42f6acfd0e9329f501a7_Out_2);
            float _Multiply_9460f57a023144a9ae646cb7ff3c8354_Out_2;
            Unity_Multiply_float_float(_Divide_df746930d1d841c09a66286a0a3543ae_Out_2, _GradientNoise_c349a7da229a42f6acfd0e9329f501a7_Out_2, _Multiply_9460f57a023144a9ae646cb7ff3c8354_Out_2);
            float _Add_5cf9a595f1104a0ba7d0c02acbf47625_Out_2;
            Unity_Add_float(_Split_d8eed8fe26594972914c124586d98bbf_G_2, _Multiply_9460f57a023144a9ae646cb7ff3c8354_Out_2, _Add_5cf9a595f1104a0ba7d0c02acbf47625_Out_2);
            float4 _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGBA_4;
            float3 _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGB_5;
            float2 _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RG_6;
            Unity_Combine_float(_Split_d8eed8fe26594972914c124586d98bbf_R_1, _Add_5cf9a595f1104a0ba7d0c02acbf47625_Out_2, _Split_d8eed8fe26594972914c124586d98bbf_B_3, 0, _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGBA_4, _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGB_5, _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RG_6);
            description.Position = _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGB_5;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float4 _Property_53dfc4b4cafc4a9496bd9fde6989ee8f_Out_0 = Color_b5081859698940efa07a6cc68ff92e70;
            float4 _Property_601193b6811a41eeb79befed4e93080a_Out_0 = _Shallow_Water_Color_2;
            float4 _UV_0459ed23840544d4943e249e6bf3def0_Out_0 = IN.uv0;
            float _Split_95c75a1ea7ee4dd7906396bff762bd25_R_1 = _UV_0459ed23840544d4943e249e6bf3def0_Out_0[0];
            float _Split_95c75a1ea7ee4dd7906396bff762bd25_G_2 = _UV_0459ed23840544d4943e249e6bf3def0_Out_0[1];
            float _Split_95c75a1ea7ee4dd7906396bff762bd25_B_3 = _UV_0459ed23840544d4943e249e6bf3def0_Out_0[2];
            float _Split_95c75a1ea7ee4dd7906396bff762bd25_A_4 = _UV_0459ed23840544d4943e249e6bf3def0_Out_0[3];
            float _Preview_0af5c98f89c44402ab2012c583d6f212_Out_1;
            Unity_Preview_float(_Split_95c75a1ea7ee4dd7906396bff762bd25_G_2, _Preview_0af5c98f89c44402ab2012c583d6f212_Out_1);
            float4 _Lerp_c2c00306fc734b0c8dee546205970ae6_Out_3;
            Unity_Lerp_float4(_Property_53dfc4b4cafc4a9496bd9fde6989ee8f_Out_0, _Property_601193b6811a41eeb79befed4e93080a_Out_0, (_Preview_0af5c98f89c44402ab2012c583d6f212_Out_1.xxxx), _Lerp_c2c00306fc734b0c8dee546205970ae6_Out_3);
            float4 _Property_72f89d8f335a4977a093f3bae7ef5ea1_Out_0 = Color_2bad1140d6ae465a8b096ead483f5370;
            float4 _Property_8d638ca6b7cc402595ddc523b14de263_Out_0 = Color_1;
            float4 _Lerp_25807026701046b7a4a6abcec2069726_Out_3;
            Unity_Lerp_float4(_Property_72f89d8f335a4977a093f3bae7ef5ea1_Out_0, _Property_8d638ca6b7cc402595ddc523b14de263_Out_0, (_Preview_0af5c98f89c44402ab2012c583d6f212_Out_1.xxxx), _Lerp_25807026701046b7a4a6abcec2069726_Out_3);
            float _SceneDepth_91aa5f89e7564cb2ac5171231a24afdf_Out_1;
            Unity_SceneDepth_Linear01_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_91aa5f89e7564cb2ac5171231a24afdf_Out_1);
            float _Multiply_619704251bdd44e6a8e9f02add36789c_Out_2;
            Unity_Multiply_float_float(_SceneDepth_91aa5f89e7564cb2ac5171231a24afdf_Out_1, _ProjectionParams.z, _Multiply_619704251bdd44e6a8e9f02add36789c_Out_2);
            float4 _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0 = IN.ScreenPosition;
            float _Split_eb526920998f41cd825cbe42160042f5_R_1 = _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0[0];
            float _Split_eb526920998f41cd825cbe42160042f5_G_2 = _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0[1];
            float _Split_eb526920998f41cd825cbe42160042f5_B_3 = _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0[2];
            float _Split_eb526920998f41cd825cbe42160042f5_A_4 = _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0[3];
            float _Property_f4dad9c86f154090a77929fc0594d2eb_Out_0 = Vector1_f108b0f6f7ad4a0fa7970936cde8c93a;
            float _Add_1d0b28a6a0fe41b9aea6de0b9a290419_Out_2;
            Unity_Add_float(_Split_eb526920998f41cd825cbe42160042f5_A_4, _Property_f4dad9c86f154090a77929fc0594d2eb_Out_0, _Add_1d0b28a6a0fe41b9aea6de0b9a290419_Out_2);
            float _Subtract_c310e84b25994cf7969fb6aec3c12631_Out_2;
            Unity_Subtract_float(_Multiply_619704251bdd44e6a8e9f02add36789c_Out_2, _Add_1d0b28a6a0fe41b9aea6de0b9a290419_Out_2, _Subtract_c310e84b25994cf7969fb6aec3c12631_Out_2);
            float _Property_e2cb78357bf54371b95b04624c624355_Out_0 = Vector1_77a8669616464cc68eec17e9163052aa;
            float _Multiply_77d88fee04a2411ebf64a9f3cf93ee09_Out_2;
            Unity_Multiply_float_float(_Subtract_c310e84b25994cf7969fb6aec3c12631_Out_2, _Property_e2cb78357bf54371b95b04624c624355_Out_0, _Multiply_77d88fee04a2411ebf64a9f3cf93ee09_Out_2);
            float _Clamp_5c303e7a7ab74c80819cff967500a688_Out_3;
            Unity_Clamp_float(_Multiply_77d88fee04a2411ebf64a9f3cf93ee09_Out_2, 0, 1, _Clamp_5c303e7a7ab74c80819cff967500a688_Out_3);
            float4 _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3;
            Unity_Lerp_float4(_Lerp_c2c00306fc734b0c8dee546205970ae6_Out_3, _Lerp_25807026701046b7a4a6abcec2069726_Out_3, (_Clamp_5c303e7a7ab74c80819cff967500a688_Out_3.xxxx), _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3);
            float _Split_32fd3b93931741f5ba645cdab3f37d0f_R_1 = _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3[0];
            float _Split_32fd3b93931741f5ba645cdab3f37d0f_G_2 = _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3[1];
            float _Split_32fd3b93931741f5ba645cdab3f37d0f_B_3 = _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3[2];
            float _Split_32fd3b93931741f5ba645cdab3f37d0f_A_4 = _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3[3];
            surface.Alpha = _Split_32fd3b93931741f5ba645cdab3f37d0f_A_4;
            surface.AlphaClipThreshold = 0;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
            output.uv0 =                                        input.uv0;
            output.TimeParameters =                             _TimeParameters.xyz;
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
        
        
            output.WorldSpacePosition = input.positionWS;
            output.ScreenPosition = ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
            output.uv0 = input.texCoord0;
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/SelectionPickingPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            Name "ScenePickingPass"
            Tags
            {
                "LightMode" = "Picking"
            }
        
        // Render State
        Cull Back
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 2.0
        #pragma only_renderers gles gles3 glcore d3d11
        #pragma multi_compile_instancing
        #pragma vertex vert
        #pragma fragment frag
        
        // DotsInstancingOptions: <None>
        // HybridV1InjectedBuiltinProperties: <None>
        
        // Keywords
        // PassKeywords: <None>
        // GraphKeywords: <None>
        
        // Defines
        
        #define _NORMALMAP 1
        #define _NORMAL_DROPOFF_TS 1
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define VARYINGS_NEED_POSITION_WS
        #define VARYINGS_NEED_TEXCOORD0
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_DEPTHONLY
        #define SCENEPICKINGPASS 1
        #define ALPHA_CLIP_THRESHOLD 1
        #define _ALPHATEST_ON 1
        #define REQUIRE_DEPTH_TEXTURE
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float3 positionWS;
             float4 texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
             float3 WorldSpacePosition;
             float4 ScreenPosition;
             float4 uv0;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
             float4 uv0;
             float3 TimeParameters;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float3 interp0 : INTERP0;
             float4 interp1 : INTERP1;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.positionWS;
            output.interp1.xyzw =  input.texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.positionWS = input.interp0.xyz;
            output.texCoord0 = input.interp1.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float4 _PlanarReflectionTexture_TexelSize;
        float Vector1_f108b0f6f7ad4a0fa7970936cde8c93a;
        float Vector1_77a8669616464cc68eec17e9163052aa;
        float4 Color_2bad1140d6ae465a8b096ead483f5370;
        float4 Color_b5081859698940efa07a6cc68ff92e70;
        float4 Color_1;
        float4 Texture2D_2d2e087224e24282b84a086f3316e6e8_TexelSize;
        float2 Vector2_c2fe4e7c2a7649b28d7ab078fdadda1c;
        float Vector1_7614a6098dec470e8a4e96a5c8551362;
        float4 Texture2D_21a78e051aa84ab49c73d2364e78102f_TexelSize;
        float2 Vector2_73fa27b3bcf64608a50eed7c1d0d3411;
        float Vector1_898460d8305d4dfe9af1298eb6f67082;
        float Vector1_0360d732cbbf426e841ca433b0e337aa;
        float Vector1_dcce861f82224ec1ac55aa94df3b3d12;
        float Vector1_3606b8114ded4a74a4e4834f8bf7dc12;
        float Vector1_69bcaf9cf50f40a2bef27afe006bbc8f;
        float4 Color_6e3aa9f38d68448bb94d493ef4e3c30a;
        float Vector1_0d98869735ab4e73a0e4bb36589d00c0;
        float Vector1_aace7401fb3a402e9f06de96963c9b84;
        float4 Texture2D_d65eb6e07c30447ca446c38272609586_TexelSize;
        float2 Vector2_2832e3b0590c4ee98f806b14c0f54c5b;
        float4 _Shallow_Water_Color_2;
        float2 _Panning;
        float _DistortionSpeed;
        float _DistortionIntensity;
        float2 _FoamNoiseTilling;
        float _DistortionScale;
        float _NoiseScale;
        float _Layer1_Scale;
        float _Layer2_Scale;
        float _RefractionDistrotion;
        float _Relection_Strength;
        CBUFFER_END
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_PlanarReflectionTexture);
        SAMPLER(sampler_PlanarReflectionTexture);
        TEXTURE2D(Texture2D_2d2e087224e24282b84a086f3316e6e8);
        SAMPLER(samplerTexture2D_2d2e087224e24282b84a086f3316e6e8);
        TEXTURE2D(Texture2D_21a78e051aa84ab49c73d2364e78102f);
        SAMPLER(samplerTexture2D_21a78e051aa84ab49c73d2364e78102f);
        TEXTURE2D(Texture2D_d65eb6e07c30447ca446c38272609586);
        SAMPLER(samplerTexture2D_d65eb6e07c30447ca446c38272609586);
        
        // Graph Includes
        // GraphIncludes: <None>
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        
        float2 Unity_GradientNoise_Dir_float(float2 p)
        {
            // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
            p = p % 289;
            // need full precision, otherwise half overflows when p > 1
            float x = float(34 * p.x + 1) * p.x % 289 + p.y;
            x = (34 * x + 1) * x % 289;
            x = frac(x / 41) * 2 - 1;
            return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
        }
        
        void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
        {
            float2 p = UV * Scale;
            float2 ip = floor(p);
            float2 fp = frac(p);
            float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
            float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
            float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
            float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
            fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
            Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }
        
        void Unity_Preview_float(float In, out float Out)
        {
            Out = In;
        }
        
        void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
        {
            Out = lerp(A, B, T);
        }
        
        void Unity_SceneDepth_Linear01_float(float4 UV, out float Out)
        {
            Out = Linear01Depth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }
        
        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            float _Split_d8eed8fe26594972914c124586d98bbf_R_1 = IN.ObjectSpacePosition[0];
            float _Split_d8eed8fe26594972914c124586d98bbf_G_2 = IN.ObjectSpacePosition[1];
            float _Split_d8eed8fe26594972914c124586d98bbf_B_3 = IN.ObjectSpacePosition[2];
            float _Split_d8eed8fe26594972914c124586d98bbf_A_4 = 0;
            float _Property_762630e6999b4da0a14b2ccffa4209d8_Out_0 = Vector1_dcce861f82224ec1ac55aa94df3b3d12;
            float _Divide_df746930d1d841c09a66286a0a3543ae_Out_2;
            Unity_Divide_float(_Property_762630e6999b4da0a14b2ccffa4209d8_Out_0, 200, _Divide_df746930d1d841c09a66286a0a3543ae_Out_2);
            float _Property_d73cd49e4412457080da3ad6f38ac94b_Out_0 = Vector1_3606b8114ded4a74a4e4834f8bf7dc12;
            float _Divide_b14ec7aec4874b8ab4371962384288e5_Out_2;
            Unity_Divide_float(_Property_d73cd49e4412457080da3ad6f38ac94b_Out_0, 50, _Divide_b14ec7aec4874b8ab4371962384288e5_Out_2);
            float _Multiply_f97f597155bf4b59afa13426042ec0a0_Out_2;
            Unity_Multiply_float_float(IN.TimeParameters.x, _Divide_b14ec7aec4874b8ab4371962384288e5_Out_2, _Multiply_f97f597155bf4b59afa13426042ec0a0_Out_2);
            float2 _TilingAndOffset_ab2fed3c342049de89287a73af5f4dd1_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, (_Multiply_f97f597155bf4b59afa13426042ec0a0_Out_2.xx), float2 (0, 0), _TilingAndOffset_ab2fed3c342049de89287a73af5f4dd1_Out_3);
            float _GradientNoise_c349a7da229a42f6acfd0e9329f501a7_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_ab2fed3c342049de89287a73af5f4dd1_Out_3, 0.96, _GradientNoise_c349a7da229a42f6acfd0e9329f501a7_Out_2);
            float _Multiply_9460f57a023144a9ae646cb7ff3c8354_Out_2;
            Unity_Multiply_float_float(_Divide_df746930d1d841c09a66286a0a3543ae_Out_2, _GradientNoise_c349a7da229a42f6acfd0e9329f501a7_Out_2, _Multiply_9460f57a023144a9ae646cb7ff3c8354_Out_2);
            float _Add_5cf9a595f1104a0ba7d0c02acbf47625_Out_2;
            Unity_Add_float(_Split_d8eed8fe26594972914c124586d98bbf_G_2, _Multiply_9460f57a023144a9ae646cb7ff3c8354_Out_2, _Add_5cf9a595f1104a0ba7d0c02acbf47625_Out_2);
            float4 _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGBA_4;
            float3 _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGB_5;
            float2 _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RG_6;
            Unity_Combine_float(_Split_d8eed8fe26594972914c124586d98bbf_R_1, _Add_5cf9a595f1104a0ba7d0c02acbf47625_Out_2, _Split_d8eed8fe26594972914c124586d98bbf_B_3, 0, _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGBA_4, _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGB_5, _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RG_6);
            description.Position = _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGB_5;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float4 _Property_53dfc4b4cafc4a9496bd9fde6989ee8f_Out_0 = Color_b5081859698940efa07a6cc68ff92e70;
            float4 _Property_601193b6811a41eeb79befed4e93080a_Out_0 = _Shallow_Water_Color_2;
            float4 _UV_0459ed23840544d4943e249e6bf3def0_Out_0 = IN.uv0;
            float _Split_95c75a1ea7ee4dd7906396bff762bd25_R_1 = _UV_0459ed23840544d4943e249e6bf3def0_Out_0[0];
            float _Split_95c75a1ea7ee4dd7906396bff762bd25_G_2 = _UV_0459ed23840544d4943e249e6bf3def0_Out_0[1];
            float _Split_95c75a1ea7ee4dd7906396bff762bd25_B_3 = _UV_0459ed23840544d4943e249e6bf3def0_Out_0[2];
            float _Split_95c75a1ea7ee4dd7906396bff762bd25_A_4 = _UV_0459ed23840544d4943e249e6bf3def0_Out_0[3];
            float _Preview_0af5c98f89c44402ab2012c583d6f212_Out_1;
            Unity_Preview_float(_Split_95c75a1ea7ee4dd7906396bff762bd25_G_2, _Preview_0af5c98f89c44402ab2012c583d6f212_Out_1);
            float4 _Lerp_c2c00306fc734b0c8dee546205970ae6_Out_3;
            Unity_Lerp_float4(_Property_53dfc4b4cafc4a9496bd9fde6989ee8f_Out_0, _Property_601193b6811a41eeb79befed4e93080a_Out_0, (_Preview_0af5c98f89c44402ab2012c583d6f212_Out_1.xxxx), _Lerp_c2c00306fc734b0c8dee546205970ae6_Out_3);
            float4 _Property_72f89d8f335a4977a093f3bae7ef5ea1_Out_0 = Color_2bad1140d6ae465a8b096ead483f5370;
            float4 _Property_8d638ca6b7cc402595ddc523b14de263_Out_0 = Color_1;
            float4 _Lerp_25807026701046b7a4a6abcec2069726_Out_3;
            Unity_Lerp_float4(_Property_72f89d8f335a4977a093f3bae7ef5ea1_Out_0, _Property_8d638ca6b7cc402595ddc523b14de263_Out_0, (_Preview_0af5c98f89c44402ab2012c583d6f212_Out_1.xxxx), _Lerp_25807026701046b7a4a6abcec2069726_Out_3);
            float _SceneDepth_91aa5f89e7564cb2ac5171231a24afdf_Out_1;
            Unity_SceneDepth_Linear01_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_91aa5f89e7564cb2ac5171231a24afdf_Out_1);
            float _Multiply_619704251bdd44e6a8e9f02add36789c_Out_2;
            Unity_Multiply_float_float(_SceneDepth_91aa5f89e7564cb2ac5171231a24afdf_Out_1, _ProjectionParams.z, _Multiply_619704251bdd44e6a8e9f02add36789c_Out_2);
            float4 _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0 = IN.ScreenPosition;
            float _Split_eb526920998f41cd825cbe42160042f5_R_1 = _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0[0];
            float _Split_eb526920998f41cd825cbe42160042f5_G_2 = _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0[1];
            float _Split_eb526920998f41cd825cbe42160042f5_B_3 = _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0[2];
            float _Split_eb526920998f41cd825cbe42160042f5_A_4 = _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0[3];
            float _Property_f4dad9c86f154090a77929fc0594d2eb_Out_0 = Vector1_f108b0f6f7ad4a0fa7970936cde8c93a;
            float _Add_1d0b28a6a0fe41b9aea6de0b9a290419_Out_2;
            Unity_Add_float(_Split_eb526920998f41cd825cbe42160042f5_A_4, _Property_f4dad9c86f154090a77929fc0594d2eb_Out_0, _Add_1d0b28a6a0fe41b9aea6de0b9a290419_Out_2);
            float _Subtract_c310e84b25994cf7969fb6aec3c12631_Out_2;
            Unity_Subtract_float(_Multiply_619704251bdd44e6a8e9f02add36789c_Out_2, _Add_1d0b28a6a0fe41b9aea6de0b9a290419_Out_2, _Subtract_c310e84b25994cf7969fb6aec3c12631_Out_2);
            float _Property_e2cb78357bf54371b95b04624c624355_Out_0 = Vector1_77a8669616464cc68eec17e9163052aa;
            float _Multiply_77d88fee04a2411ebf64a9f3cf93ee09_Out_2;
            Unity_Multiply_float_float(_Subtract_c310e84b25994cf7969fb6aec3c12631_Out_2, _Property_e2cb78357bf54371b95b04624c624355_Out_0, _Multiply_77d88fee04a2411ebf64a9f3cf93ee09_Out_2);
            float _Clamp_5c303e7a7ab74c80819cff967500a688_Out_3;
            Unity_Clamp_float(_Multiply_77d88fee04a2411ebf64a9f3cf93ee09_Out_2, 0, 1, _Clamp_5c303e7a7ab74c80819cff967500a688_Out_3);
            float4 _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3;
            Unity_Lerp_float4(_Lerp_c2c00306fc734b0c8dee546205970ae6_Out_3, _Lerp_25807026701046b7a4a6abcec2069726_Out_3, (_Clamp_5c303e7a7ab74c80819cff967500a688_Out_3.xxxx), _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3);
            float _Split_32fd3b93931741f5ba645cdab3f37d0f_R_1 = _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3[0];
            float _Split_32fd3b93931741f5ba645cdab3f37d0f_G_2 = _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3[1];
            float _Split_32fd3b93931741f5ba645cdab3f37d0f_B_3 = _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3[2];
            float _Split_32fd3b93931741f5ba645cdab3f37d0f_A_4 = _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3[3];
            surface.Alpha = _Split_32fd3b93931741f5ba645cdab3f37d0f_A_4;
            surface.AlphaClipThreshold = 0;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
            output.uv0 =                                        input.uv0;
            output.TimeParameters =                             _TimeParameters.xyz;
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
        
        
            output.WorldSpacePosition = input.positionWS;
            output.ScreenPosition = ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
            output.uv0 = input.texCoord0;
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/SelectionPickingPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            // Name: <None>
            Tags
            {
                "LightMode" = "Universal2D"
            }
        
        // Render State
        Cull Back
        Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
        ZTest LEqual
        ZWrite Off
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 2.0
        #pragma only_renderers gles gles3 glcore d3d11
        #pragma multi_compile_instancing
        #pragma vertex vert
        #pragma fragment frag
        
        // DotsInstancingOptions: <None>
        // HybridV1InjectedBuiltinProperties: <None>
        
        // Keywords
        // PassKeywords: <None>
        // GraphKeywords: <None>
        
        // Defines
        
        #define _NORMALMAP 1
        #define _NORMAL_DROPOFF_TS 1
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define VARYINGS_NEED_POSITION_WS
        #define VARYINGS_NEED_TEXCOORD0
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_2D
        #define _ALPHATEST_ON 1
        #define REQUIRE_DEPTH_TEXTURE
        #define REQUIRE_OPAQUE_TEXTURE
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float3 positionWS;
             float4 texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
             float2 MainNormal;
             float2 SecondNormal;
        };
        struct SurfaceDescriptionInputs
        {
             float3 WorldSpacePosition;
             float4 ScreenPosition;
             float4 uv0;
             float2 MainNormal;
             float2 SecondNormal;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
             float4 uv0;
             float3 TimeParameters;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float3 interp0 : INTERP0;
             float4 interp1 : INTERP1;
             float4 interp2 : INTERP2;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.positionWS;
            output.interp1.xyzw =  input.texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            output.interp2.xy =  input.MainNormal;
            output.interp2.zw =  input.SecondNormal;
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.positionWS = input.interp0.xyz;
            output.texCoord0 = input.interp1.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            output.MainNormal = input.interp2.xy;
            output.SecondNormal = input.interp2.zw;
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float4 _PlanarReflectionTexture_TexelSize;
        float Vector1_f108b0f6f7ad4a0fa7970936cde8c93a;
        float Vector1_77a8669616464cc68eec17e9163052aa;
        float4 Color_2bad1140d6ae465a8b096ead483f5370;
        float4 Color_b5081859698940efa07a6cc68ff92e70;
        float4 Color_1;
        float4 Texture2D_2d2e087224e24282b84a086f3316e6e8_TexelSize;
        float2 Vector2_c2fe4e7c2a7649b28d7ab078fdadda1c;
        float Vector1_7614a6098dec470e8a4e96a5c8551362;
        float4 Texture2D_21a78e051aa84ab49c73d2364e78102f_TexelSize;
        float2 Vector2_73fa27b3bcf64608a50eed7c1d0d3411;
        float Vector1_898460d8305d4dfe9af1298eb6f67082;
        float Vector1_0360d732cbbf426e841ca433b0e337aa;
        float Vector1_dcce861f82224ec1ac55aa94df3b3d12;
        float Vector1_3606b8114ded4a74a4e4834f8bf7dc12;
        float Vector1_69bcaf9cf50f40a2bef27afe006bbc8f;
        float4 Color_6e3aa9f38d68448bb94d493ef4e3c30a;
        float Vector1_0d98869735ab4e73a0e4bb36589d00c0;
        float Vector1_aace7401fb3a402e9f06de96963c9b84;
        float4 Texture2D_d65eb6e07c30447ca446c38272609586_TexelSize;
        float2 Vector2_2832e3b0590c4ee98f806b14c0f54c5b;
        float4 _Shallow_Water_Color_2;
        float2 _Panning;
        float _DistortionSpeed;
        float _DistortionIntensity;
        float2 _FoamNoiseTilling;
        float _DistortionScale;
        float _NoiseScale;
        float _Layer1_Scale;
        float _Layer2_Scale;
        float _RefractionDistrotion;
        float _Relection_Strength;
        CBUFFER_END
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_PlanarReflectionTexture);
        SAMPLER(sampler_PlanarReflectionTexture);
        TEXTURE2D(Texture2D_2d2e087224e24282b84a086f3316e6e8);
        SAMPLER(samplerTexture2D_2d2e087224e24282b84a086f3316e6e8);
        TEXTURE2D(Texture2D_21a78e051aa84ab49c73d2364e78102f);
        SAMPLER(samplerTexture2D_21a78e051aa84ab49c73d2364e78102f);
        TEXTURE2D(Texture2D_d65eb6e07c30447ca446c38272609586);
        SAMPLER(samplerTexture2D_d65eb6e07c30447ca446c38272609586);
        
        // Graph Includes
        // GraphIncludes: <None>
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        
        float2 Unity_GradientNoise_Dir_float(float2 p)
        {
            // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
            p = p % 289;
            // need full precision, otherwise half overflows when p > 1
            float x = float(34 * p.x + 1) * p.x % 289 + p.y;
            x = (34 * x + 1) * x % 289;
            x = frac(x / 41) * 2 - 1;
            return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
        }
        
        void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
        {
            float2 p = UV * Scale;
            float2 ip = floor(p);
            float2 fp = frac(p);
            float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
            float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
            float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
            float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
            fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
            Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }
        
        void Unity_Preview_float(float In, out float Out)
        {
            Out = In;
        }
        
        void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
        {
            Out = lerp(A, B, T);
        }
        
        void Unity_SceneDepth_Linear01_float(float4 UV, out float Out)
        {
            Out = Linear01Depth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }
        
        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }
        
        void Unity_Add_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A + B;
        }
        
        void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
        {
            Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
        }
        
        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }
        
        void Unity_SceneColor_float(float4 UV, out float3 Out)
        {
            Out = SHADERGRAPH_SAMPLE_SCENE_COLOR(UV.xy);
        }
        
        void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
        {
            Out = lerp(A, B, T);
        }
        
        void Unity_Blend_Multiply_float3(float3 Base, float3 Blend, out float3 Out, float Opacity)
        {
            Out = Base * Blend;
            Out = lerp(Base, Out, Opacity);
        }
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
            float2 MainNormal;
            float2 SecondNormal;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            float _Property_8a79f817e59948938215b338bcdc46df_Out_0 = Vector1_898460d8305d4dfe9af1298eb6f67082;
            float _Multiply_ed606ef7153b456b854854134a8f65f9_Out_2;
            Unity_Multiply_float_float(_Property_8a79f817e59948938215b338bcdc46df_Out_0, 0.01, _Multiply_ed606ef7153b456b854854134a8f65f9_Out_2);
            float2 _Property_0264c1738ed14b318538f5f39eb56d07_Out_0 = Vector2_73fa27b3bcf64608a50eed7c1d0d3411;
            float _Divide_d29c49a16f234ef78eee8f12e556a643_Out_2;
            Unity_Divide_float(IN.TimeParameters.x, 5, _Divide_d29c49a16f234ef78eee8f12e556a643_Out_2);
            float _Multiply_5928ff83990b4a61bfdfa392f6154eda_Out_2;
            Unity_Multiply_float_float(_Divide_d29c49a16f234ef78eee8f12e556a643_Out_2, _Multiply_ed606ef7153b456b854854134a8f65f9_Out_2, _Multiply_5928ff83990b4a61bfdfa392f6154eda_Out_2);
            float2 _TilingAndOffset_08fa9dddbfc44f8b9e671e082ef10419_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Property_0264c1738ed14b318538f5f39eb56d07_Out_0, (_Multiply_5928ff83990b4a61bfdfa392f6154eda_Out_2.xx), _TilingAndOffset_08fa9dddbfc44f8b9e671e082ef10419_Out_3);
            float _Property_32d848f89d264e118a7bc7b7cbae9677_Out_0 = Vector1_7614a6098dec470e8a4e96a5c8551362;
            float _Multiply_1541a6ad358e4ea281033d8831f2ba13_Out_2;
            Unity_Multiply_float_float(_Property_32d848f89d264e118a7bc7b7cbae9677_Out_0, -0.01, _Multiply_1541a6ad358e4ea281033d8831f2ba13_Out_2);
            float _Multiply_edd1ffe542204260a884842fd7a18fc1_Out_2;
            Unity_Multiply_float_float(_Multiply_1541a6ad358e4ea281033d8831f2ba13_Out_2, _Divide_d29c49a16f234ef78eee8f12e556a643_Out_2, _Multiply_edd1ffe542204260a884842fd7a18fc1_Out_2);
            float2 _Property_123c8148386d41aa9d1698d86033f0b5_Out_0 = Vector2_c2fe4e7c2a7649b28d7ab078fdadda1c;
            float2 _TilingAndOffset_924ee153284a4d4abbd47514c96bb1ae_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Property_123c8148386d41aa9d1698d86033f0b5_Out_0, (_Multiply_edd1ffe542204260a884842fd7a18fc1_Out_2.xx), _TilingAndOffset_924ee153284a4d4abbd47514c96bb1ae_Out_3);
            float _Split_d8eed8fe26594972914c124586d98bbf_R_1 = IN.ObjectSpacePosition[0];
            float _Split_d8eed8fe26594972914c124586d98bbf_G_2 = IN.ObjectSpacePosition[1];
            float _Split_d8eed8fe26594972914c124586d98bbf_B_3 = IN.ObjectSpacePosition[2];
            float _Split_d8eed8fe26594972914c124586d98bbf_A_4 = 0;
            float _Property_762630e6999b4da0a14b2ccffa4209d8_Out_0 = Vector1_dcce861f82224ec1ac55aa94df3b3d12;
            float _Divide_df746930d1d841c09a66286a0a3543ae_Out_2;
            Unity_Divide_float(_Property_762630e6999b4da0a14b2ccffa4209d8_Out_0, 200, _Divide_df746930d1d841c09a66286a0a3543ae_Out_2);
            float _Property_d73cd49e4412457080da3ad6f38ac94b_Out_0 = Vector1_3606b8114ded4a74a4e4834f8bf7dc12;
            float _Divide_b14ec7aec4874b8ab4371962384288e5_Out_2;
            Unity_Divide_float(_Property_d73cd49e4412457080da3ad6f38ac94b_Out_0, 50, _Divide_b14ec7aec4874b8ab4371962384288e5_Out_2);
            float _Multiply_f97f597155bf4b59afa13426042ec0a0_Out_2;
            Unity_Multiply_float_float(IN.TimeParameters.x, _Divide_b14ec7aec4874b8ab4371962384288e5_Out_2, _Multiply_f97f597155bf4b59afa13426042ec0a0_Out_2);
            float2 _TilingAndOffset_ab2fed3c342049de89287a73af5f4dd1_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, (_Multiply_f97f597155bf4b59afa13426042ec0a0_Out_2.xx), float2 (0, 0), _TilingAndOffset_ab2fed3c342049de89287a73af5f4dd1_Out_3);
            float _GradientNoise_c349a7da229a42f6acfd0e9329f501a7_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_ab2fed3c342049de89287a73af5f4dd1_Out_3, 0.96, _GradientNoise_c349a7da229a42f6acfd0e9329f501a7_Out_2);
            float _Multiply_9460f57a023144a9ae646cb7ff3c8354_Out_2;
            Unity_Multiply_float_float(_Divide_df746930d1d841c09a66286a0a3543ae_Out_2, _GradientNoise_c349a7da229a42f6acfd0e9329f501a7_Out_2, _Multiply_9460f57a023144a9ae646cb7ff3c8354_Out_2);
            float _Add_5cf9a595f1104a0ba7d0c02acbf47625_Out_2;
            Unity_Add_float(_Split_d8eed8fe26594972914c124586d98bbf_G_2, _Multiply_9460f57a023144a9ae646cb7ff3c8354_Out_2, _Add_5cf9a595f1104a0ba7d0c02acbf47625_Out_2);
            float4 _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGBA_4;
            float3 _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGB_5;
            float2 _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RG_6;
            Unity_Combine_float(_Split_d8eed8fe26594972914c124586d98bbf_R_1, _Add_5cf9a595f1104a0ba7d0c02acbf47625_Out_2, _Split_d8eed8fe26594972914c124586d98bbf_B_3, 0, _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGBA_4, _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGB_5, _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RG_6);
            description.Position = _Combine_b8bed03ea43b4fdbbe0f3ab61430a3d4_RGB_5;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            description.MainNormal = _TilingAndOffset_924ee153284a4d4abbd47514c96bb1ae_Out_3;
            description.SecondNormal = _TilingAndOffset_08fa9dddbfc44f8b9e671e082ef10419_Out_3;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        output.MainNormal = input.MainNormal;
        output.SecondNormal = input.SecondNormal;
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float3 BaseColor;
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float4 _Property_53dfc4b4cafc4a9496bd9fde6989ee8f_Out_0 = Color_b5081859698940efa07a6cc68ff92e70;
            float4 _Property_601193b6811a41eeb79befed4e93080a_Out_0 = _Shallow_Water_Color_2;
            float4 _UV_0459ed23840544d4943e249e6bf3def0_Out_0 = IN.uv0;
            float _Split_95c75a1ea7ee4dd7906396bff762bd25_R_1 = _UV_0459ed23840544d4943e249e6bf3def0_Out_0[0];
            float _Split_95c75a1ea7ee4dd7906396bff762bd25_G_2 = _UV_0459ed23840544d4943e249e6bf3def0_Out_0[1];
            float _Split_95c75a1ea7ee4dd7906396bff762bd25_B_3 = _UV_0459ed23840544d4943e249e6bf3def0_Out_0[2];
            float _Split_95c75a1ea7ee4dd7906396bff762bd25_A_4 = _UV_0459ed23840544d4943e249e6bf3def0_Out_0[3];
            float _Preview_0af5c98f89c44402ab2012c583d6f212_Out_1;
            Unity_Preview_float(_Split_95c75a1ea7ee4dd7906396bff762bd25_G_2, _Preview_0af5c98f89c44402ab2012c583d6f212_Out_1);
            float4 _Lerp_c2c00306fc734b0c8dee546205970ae6_Out_3;
            Unity_Lerp_float4(_Property_53dfc4b4cafc4a9496bd9fde6989ee8f_Out_0, _Property_601193b6811a41eeb79befed4e93080a_Out_0, (_Preview_0af5c98f89c44402ab2012c583d6f212_Out_1.xxxx), _Lerp_c2c00306fc734b0c8dee546205970ae6_Out_3);
            float4 _Property_72f89d8f335a4977a093f3bae7ef5ea1_Out_0 = Color_2bad1140d6ae465a8b096ead483f5370;
            float4 _Property_8d638ca6b7cc402595ddc523b14de263_Out_0 = Color_1;
            float4 _Lerp_25807026701046b7a4a6abcec2069726_Out_3;
            Unity_Lerp_float4(_Property_72f89d8f335a4977a093f3bae7ef5ea1_Out_0, _Property_8d638ca6b7cc402595ddc523b14de263_Out_0, (_Preview_0af5c98f89c44402ab2012c583d6f212_Out_1.xxxx), _Lerp_25807026701046b7a4a6abcec2069726_Out_3);
            float _SceneDepth_91aa5f89e7564cb2ac5171231a24afdf_Out_1;
            Unity_SceneDepth_Linear01_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_91aa5f89e7564cb2ac5171231a24afdf_Out_1);
            float _Multiply_619704251bdd44e6a8e9f02add36789c_Out_2;
            Unity_Multiply_float_float(_SceneDepth_91aa5f89e7564cb2ac5171231a24afdf_Out_1, _ProjectionParams.z, _Multiply_619704251bdd44e6a8e9f02add36789c_Out_2);
            float4 _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0 = IN.ScreenPosition;
            float _Split_eb526920998f41cd825cbe42160042f5_R_1 = _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0[0];
            float _Split_eb526920998f41cd825cbe42160042f5_G_2 = _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0[1];
            float _Split_eb526920998f41cd825cbe42160042f5_B_3 = _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0[2];
            float _Split_eb526920998f41cd825cbe42160042f5_A_4 = _ScreenPosition_6e3386a14a294b44a5984c03794d79ca_Out_0[3];
            float _Property_f4dad9c86f154090a77929fc0594d2eb_Out_0 = Vector1_f108b0f6f7ad4a0fa7970936cde8c93a;
            float _Add_1d0b28a6a0fe41b9aea6de0b9a290419_Out_2;
            Unity_Add_float(_Split_eb526920998f41cd825cbe42160042f5_A_4, _Property_f4dad9c86f154090a77929fc0594d2eb_Out_0, _Add_1d0b28a6a0fe41b9aea6de0b9a290419_Out_2);
            float _Subtract_c310e84b25994cf7969fb6aec3c12631_Out_2;
            Unity_Subtract_float(_Multiply_619704251bdd44e6a8e9f02add36789c_Out_2, _Add_1d0b28a6a0fe41b9aea6de0b9a290419_Out_2, _Subtract_c310e84b25994cf7969fb6aec3c12631_Out_2);
            float _Property_e2cb78357bf54371b95b04624c624355_Out_0 = Vector1_77a8669616464cc68eec17e9163052aa;
            float _Multiply_77d88fee04a2411ebf64a9f3cf93ee09_Out_2;
            Unity_Multiply_float_float(_Subtract_c310e84b25994cf7969fb6aec3c12631_Out_2, _Property_e2cb78357bf54371b95b04624c624355_Out_0, _Multiply_77d88fee04a2411ebf64a9f3cf93ee09_Out_2);
            float _Clamp_5c303e7a7ab74c80819cff967500a688_Out_3;
            Unity_Clamp_float(_Multiply_77d88fee04a2411ebf64a9f3cf93ee09_Out_2, 0, 1, _Clamp_5c303e7a7ab74c80819cff967500a688_Out_3);
            float4 _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3;
            Unity_Lerp_float4(_Lerp_c2c00306fc734b0c8dee546205970ae6_Out_3, _Lerp_25807026701046b7a4a6abcec2069726_Out_3, (_Clamp_5c303e7a7ab74c80819cff967500a688_Out_3.xxxx), _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3);
            UnityTexture2D _Property_691307347e93408bb228020d56a4f64e_Out_0 = UnityBuildTexture2DStructNoScale(Texture2D_2d2e087224e24282b84a086f3316e6e8);
            float4 _SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0 = SAMPLE_TEXTURE2D(_Property_691307347e93408bb228020d56a4f64e_Out_0.tex, _Property_691307347e93408bb228020d56a4f64e_Out_0.samplerstate, _Property_691307347e93408bb228020d56a4f64e_Out_0.GetTransformedUV(IN.MainNormal));
            _SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0);
            float _SampleTexture2D_3802527e187e464aa45999485a38f24f_R_4 = _SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0.r;
            float _SampleTexture2D_3802527e187e464aa45999485a38f24f_G_5 = _SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0.g;
            float _SampleTexture2D_3802527e187e464aa45999485a38f24f_B_6 = _SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0.b;
            float _SampleTexture2D_3802527e187e464aa45999485a38f24f_A_7 = _SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0.a;
            UnityTexture2D _Property_162be1870c564d31abda704370ecd112_Out_0 = UnityBuildTexture2DStructNoScale(Texture2D_21a78e051aa84ab49c73d2364e78102f);
            float4 _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0 = SAMPLE_TEXTURE2D(_Property_162be1870c564d31abda704370ecd112_Out_0.tex, _Property_162be1870c564d31abda704370ecd112_Out_0.samplerstate, _Property_162be1870c564d31abda704370ecd112_Out_0.GetTransformedUV(IN.SecondNormal));
            _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0);
            float _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_R_4 = _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0.r;
            float _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_G_5 = _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0.g;
            float _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_B_6 = _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0.b;
            float _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_A_7 = _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0.a;
            float4 _Add_357900c2d36f40c0b7995aceda820c48_Out_2;
            Unity_Add_float4(_SampleTexture2D_3802527e187e464aa45999485a38f24f_RGBA_0, _SampleTexture2D_15ecbf69a8444e639b4d010d848122e2_RGBA_0, _Add_357900c2d36f40c0b7995aceda820c48_Out_2);
            float _Property_bcb4a350b8234af79860039f232f70bb_Out_0 = Vector1_0360d732cbbf426e841ca433b0e337aa;
            float3 _NormalStrength_353fbbdfa63c4bf1a26d328b90d65d75_Out_2;
            Unity_NormalStrength_float((_Add_357900c2d36f40c0b7995aceda820c48_Out_2.xyz), _Property_bcb4a350b8234af79860039f232f70bb_Out_0, _NormalStrength_353fbbdfa63c4bf1a26d328b90d65d75_Out_2);
            float _Property_435f8911f9614444bccaa1b491910830_Out_0 = _RefractionDistrotion;
            float3 _NormalStrength_c661b7411e0343adbe9cd03e17ec5587_Out_2;
            Unity_NormalStrength_float(_NormalStrength_353fbbdfa63c4bf1a26d328b90d65d75_Out_2, _Property_435f8911f9614444bccaa1b491910830_Out_0, _NormalStrength_c661b7411e0343adbe9cd03e17ec5587_Out_2);
            float4 _ScreenPosition_8195cd06776241d5b37929c91c6dad48_Out_0 = float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0);
            float3 _Add_b257228ea21d4b4d977a6133326b7e06_Out_2;
            Unity_Add_float3(_NormalStrength_c661b7411e0343adbe9cd03e17ec5587_Out_2, (_ScreenPosition_8195cd06776241d5b37929c91c6dad48_Out_0.xyz), _Add_b257228ea21d4b4d977a6133326b7e06_Out_2);
            float3 _SceneColor_2c332a05662541f2bba2d1b5eeb47bd2_Out_1;
            Unity_SceneColor_float((float4(_Add_b257228ea21d4b4d977a6133326b7e06_Out_2, 1.0)), _SceneColor_2c332a05662541f2bba2d1b5eeb47bd2_Out_1);
            UnityTexture2D _Property_c55f1526f461489aa2011515ec7da3a3_Out_0 = UnityBuildTexture2DStructNoScale(_PlanarReflectionTexture);
            float3 _Add_9cc9802b3ef24c21b8771b375a3bff42_Out_2;
            Unity_Add_float3(_NormalStrength_353fbbdfa63c4bf1a26d328b90d65d75_Out_2, (_Clamp_5c303e7a7ab74c80819cff967500a688_Out_3.xxx), _Add_9cc9802b3ef24c21b8771b375a3bff42_Out_2);
            float3 _NormalStrength_6161489259bb4747ba0928987b51a0ea_Out_2;
            Unity_NormalStrength_float(_Add_9cc9802b3ef24c21b8771b375a3bff42_Out_2, _Property_435f8911f9614444bccaa1b491910830_Out_0, _NormalStrength_6161489259bb4747ba0928987b51a0ea_Out_2);
            float3 _Add_51f05a9faaf74e72812fae8a48ed882c_Out_2;
            Unity_Add_float3((_ScreenPosition_8195cd06776241d5b37929c91c6dad48_Out_0.xyz), _NormalStrength_6161489259bb4747ba0928987b51a0ea_Out_2, _Add_51f05a9faaf74e72812fae8a48ed882c_Out_2);
            float4 _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_RGBA_0 = SAMPLE_TEXTURE2D(_Property_c55f1526f461489aa2011515ec7da3a3_Out_0.tex, _Property_c55f1526f461489aa2011515ec7da3a3_Out_0.samplerstate, _Property_c55f1526f461489aa2011515ec7da3a3_Out_0.GetTransformedUV((_Add_51f05a9faaf74e72812fae8a48ed882c_Out_2.xy)));
            float _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_R_4 = _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_RGBA_0.r;
            float _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_G_5 = _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_RGBA_0.g;
            float _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_B_6 = _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_RGBA_0.b;
            float _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_A_7 = _SampleTexture2D_60a5b90e4760409a9760488b39b95feb_RGBA_0.a;
            float3 _Lerp_6bca2423774749ccb6b3d02c089ca6aa_Out_3;
            Unity_Lerp_float3(_SceneColor_2c332a05662541f2bba2d1b5eeb47bd2_Out_1, (_SampleTexture2D_60a5b90e4760409a9760488b39b95feb_RGBA_0.xyz), (_Clamp_5c303e7a7ab74c80819cff967500a688_Out_3.xxx), _Lerp_6bca2423774749ccb6b3d02c089ca6aa_Out_3);
            float _Property_4267d14b41a64c8faa1146ffbcfe3618_Out_0 = _Relection_Strength;
            float3 _Blend_1d413404067041f1a38d59c008106e23_Out_2;
            Unity_Blend_Multiply_float3((_Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3.xyz), _Lerp_6bca2423774749ccb6b3d02c089ca6aa_Out_3, _Blend_1d413404067041f1a38d59c008106e23_Out_2, _Property_4267d14b41a64c8faa1146ffbcfe3618_Out_0);
            float _Split_32fd3b93931741f5ba645cdab3f37d0f_R_1 = _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3[0];
            float _Split_32fd3b93931741f5ba645cdab3f37d0f_G_2 = _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3[1];
            float _Split_32fd3b93931741f5ba645cdab3f37d0f_B_3 = _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3[2];
            float _Split_32fd3b93931741f5ba645cdab3f37d0f_A_4 = _Lerp_fb7d0e72ad954d98879dd3d7905c9508_Out_3[3];
            surface.BaseColor = _Blend_1d413404067041f1a38d59c008106e23_Out_2;
            surface.Alpha = _Split_32fd3b93931741f5ba645cdab3f37d0f_A_4;
            surface.AlphaClipThreshold = 0;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
            output.uv0 =                                        input.uv0;
            output.TimeParameters =                             _TimeParameters.xyz;
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            output.MainNormal = input.MainNormal;
        output.SecondNormal = input.SecondNormal;
        
        
        
        
        
            output.WorldSpacePosition = input.positionWS;
            output.ScreenPosition = ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
            output.uv0 = input.texCoord0;
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBR2DPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
    }
    CustomEditorForRenderPipeline "UnityEditor.ShaderGraphLitGUI" "UnityEngine.Rendering.Universal.UniversalRenderPipelineAsset"
    CustomEditor "UnityEditor.ShaderGraph.GenericShaderGraphMaterialGUI"
    FallBack "Hidden/Shader Graph/FallbackError"
}