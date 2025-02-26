Shader "CustomShaderForJellyKT"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,0.5) // ���� � ������������� (����� = 0.5)
        _Glossiness ("Smoothness", Range(0,1)) = 0.5 // ���������
        _Metallic ("Metallic", Range(0,1)) = 0.0 // �������������
        _RimColor ("Rim Color", Color) = (1,1,1,1) // ���� ������
        _RimPower ("Rim Power", Range(1,4)) = 2.0 // ���� ������
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue"="Transparent" }
        LOD 200

        Blend SrcAlpha OneMinusSrcAlpha
        ZWrite Off

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows alpha:fade

        struct Input
        {
            float3 viewDir;
        };

        half _Glossiness;
        half _Metallic;
        fixed4 _Color;
        fixed4 _RimColor;
        float _RimPower;

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            // �������� ����
            o.Albedo = _Color.rgb;
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = _Color.a; // ������������

            // ������ ������
            float3 viewDir = normalize(IN.viewDir);
            float rim = 1.0 - saturate(dot(o.Normal, viewDir));
            o.Emission = _RimColor.rgb * pow(rim, _RimPower); // �������� �� �����
        }
        ENDCG
    }
    FallBack "Transparent/Diffuse"
}