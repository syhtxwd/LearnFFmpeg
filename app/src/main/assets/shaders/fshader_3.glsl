#version 300 es
precision highp float;
in vec2 v_texCoord;
layout(location = 0) out vec4 outColor;
uniform sampler2D s_texture0;
uniform sampler2D s_texture1;
uniform sampler2D s_texture2;
uniform int u_nImgType;// 1:RGBA, 2:NV21, 3:NV12, 4:I420
uniform float u_Offset;
uniform vec2 u_TexSize;

/**
 *
 * Created by syh on 2021/3/16.
 *
 * 缩放的圆
 * */

vec4 sampleImage(vec2 texCoord) {
    vec4 outColor;
    if(u_nImgType == 1) //RGBA
    {
        outColor = texture(s_texture0, texCoord);
    }
    else if(u_nImgType == 2) //NV21
    {
        vec3 yuv;
        yuv.x = texture(s_texture0, texCoord).r;
        yuv.y = texture(s_texture1, texCoord).a - 0.5;
        yuv.z = texture(s_texture1, texCoord).r - 0.5;
        highp vec3 rgb = mat3(1.0,       1.0,     1.0,
        0.0,  -0.344,  1.770,
        1.403,  -0.714,     0.0) * yuv;
        outColor = vec4(rgb, 1.0);

    }
    else if(u_nImgType == 3) //NV12
    {
        vec3 yuv;
        yuv.x = texture(s_texture0, texCoord).r;
        yuv.y = texture(s_texture1, texCoord).r - 0.5;
        yuv.z = texture(s_texture1, texCoord).a - 0.5;
        highp vec3 rgb = mat3(1.0,       1.0,     1.0,
        0.0,  -0.344,  1.770,
        1.403,  -0.714,     0.0) * yuv;
        outColor = vec4(rgb, 1.0);
    }
    else if(u_nImgType == 4) //I420
    {
        vec3 yuv;
        yuv.x = texture(s_texture0, texCoord).r;
        yuv.y = texture(s_texture1, texCoord).r - 0.5;
        yuv.z = texture(s_texture2, texCoord).r - 0.5;
        highp vec3 rgb = mat3(1.0,       1.0,     1.0,
        0.0,  -0.344,  1.770,
        1.403,  -0.714,     0.0) * yuv;
        outColor = vec4(rgb, 1.0);
    }
    else
    {
        outColor = vec4(1.0);
    }
    return outColor;
}

void main()
{
    vec2 imgTex = v_texCoord * u_TexSize;
    float r = (u_Offset + 0.208 ) * u_TexSize.x;
    if(distance(imgTex, vec2(u_TexSize.x / 2.0, u_TexSize.y / 2.0)) < r)
    {
        outColor = sampleImage(v_texCoord);
    }
    else
    {
        outColor = vec4(1.0, 1.0, 1.0, 1.0);
    }
}

