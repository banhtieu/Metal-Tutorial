//
//  simdmath.h
//  MetalFramework
//
//  Created by Tran Thien Khiem on 11/11/14.
//  Copyright (c) 2014 Tran Thien Khiem. All rights reserved.
//

#ifndef __MetalFramework__simdmath__
#define __MetalFramework__simdmath__

#include <stdio.h>

class packed_float2
{
public:
    float x;
    float y;
    
    packed_float2(float _x, float _y);
    packed_float2();
    
    packed_float2 operator+(const packed_float2 &v) const;
    packed_float2 operator-(const packed_float2 &v) const;
    packed_float2 operator*(float d) const;
    float Dot(const packed_float2 &v) const;
};

// typedef float 2 to packed_float2
typedef packed_float2 float2;

// packed float 3 definition
class packed_float3
{
public:
    union {
        struct {
            float x;
            float y;
            float z;
        };
        struct {
            float r;
            float g;
            float b;
        };
    };
    
    packed_float3(float _x = 0.0f, float _y = 0.0f, float _z = 0.0f);
    packed_float3(const packed_float2 &v, float z = 0.0f);
    
    packed_float3 operator+(const packed_float3 &v) const;
    packed_float3 operator-(const packed_float3 &v) const;
    packed_float3 operator*(const packed_float3 &v) const;
    packed_float3 operator*(float d) const;
    float Dot(const packed_float3 &v) const;
};


class packed_float4:public packed_float3
{
public:
    union {
        float w;
        float a;
    };
    
    packed_float4();
    packed_float4(float _x, float _y, float _z, float _w);
    packed_float4(const packed_float2 &v, float z = 0.0f, float w = 0.0f);
    packed_float4(const packed_float3 &v, float w = 0.0f);
    
    packed_float4 operator+(const packed_float4 &v) const;
    packed_float4 operator-(const packed_float4 &v) const;
    packed_float4 operator*(float d) const;
    float Dot(const packed_float4 &v) const;
    
};

typedef packed_float4 float3;
typedef packed_float4 float4;


// matrix 4x4
class float4x4 {
public:
    union {
        float m[4][4];
        struct {
            float4 columns[4];
        };
    };
    
    float4x4(float c0x = 0.0f, float c0y = 0.0f, float c0z = 0.0f, float c0w = 0.0f,
        float c1x = 0.0f, float c1y = 0.0f, float c1z = 0.0f, float c1w = 0.0f,
             float c2x = 0.0f, float c2y = 0.0f, float c2z = 0.0f, float c2w = 0.0f,
             float c3x = 0.0f, float c3y = 0.0f, float c3z = 0.0f, float c3w = 0.0f);
    float4x4(const float4 columns[4]);
    float4x4(const float4 &column0, const float4 &column1, const float4 &column2, const float4 &column3);
    
    float4x4 operator*(const float4x4 &m);
    float3 operator*(const float3 &v);
    static float4x4 MakeRotationX(float alpha);
    static float4x4 MakeRotationY(float alpha);
    static float4x4 MakeRotationZ(float alpha);
    static float4x4 MakeTranslation(float3 v);
    static float4x4 MakeScale(float3 v);
};

#endif /* defined(__MetalFramework__simdmath__) */
