//
//  simdmath.cpp
//  MetalFramework
//
//  Created by Tran Thien Khiem on 11/11/14.
//  Copyright (c) 2014 Tran Thien Khiem. All rights reserved.
//

#include <memory.h>
#include <math.h>
#include "simdmath.h"

packed_float2::packed_float2(float _x, float _y)
{
    x = _x;
    y = _y;
}

packed_float2::packed_float2()
{
    x = 0.0f;
    y = 0.0f;
}

packed_float2 packed_float2::operator+(const packed_float2 &v) const
{
    return packed_float2(x + v.x, y + v.y);
}

// opeartor -
packed_float2 packed_float2::operator-(const packed_float2 &v) const
{
    return packed_float2(x + v.x, y + v.y);
}

packed_float2 packed_float2::operator*(float d) const
{
    return packed_float2(x * d, y * d);
}

float packed_float2::Dot(const packed_float2 &v) const
{
    return x * v.x + y * v.y;
}

packed_float3::packed_float3(float _x, float _y, float _z)
{
    x = _x;
    y = _y;
    z = _z;
}

packed_float3::packed_float3(const packed_float2 &v, float _z)
{
    x = v.x;
    y = v.y;
    z = _z;
}

packed_float3 packed_float3::operator+(const packed_float3 &v) const {
    return packed_float3(x + v.x, y + v.y, z + v.z);
}

packed_float3 packed_float3::operator-(const packed_float3 &v) const
{
    return packed_float3(x - v.x, y - v.y, z - v.z);
}

packed_float3 packed_float3::operator*(const packed_float3 &v) const
{
    return packed_float3(y * v.z - v.y * z, z * v.x - v.z * x, x * v.y - y * v.x);
}

packed_float3 packed_float3::operator*(float d) const
{
    return packed_float3(x * d, y * d, z * d);
}

float packed_float3::Dot(const packed_float3 &v) const
{
    return x * v.x + y * v.y + z * v.z;
}

// constructor float packed float 4
packed_float4::packed_float4() : packed_float3() {
    w = 0.0f;
}

packed_float4::packed_float4(float _x, float _y, float _z, float _w) : packed_float3(_x, _y, _z), w(_w)
{
}

packed_float4::packed_float4(const packed_float2 &v, float z, float w): packed_float4(v.x, v.y, z, w)
{
    
}

packed_float4::packed_float4(const packed_float3 &v, float w) : packed_float3(v), w(w)
{
    
};

packed_float4 packed_float4::operator+(const packed_float4 &v) const
{
    return packed_float4(x + v.x, y + v.y, z + v.z, w + v.w);
}

packed_float4 packed_float4::operator-(const packed_float4 &v) const
{
    return packed_float4(x - v.x, y - v.y, z - v.z, w - v.w);
}

packed_float4 packed_float4::operator*(float d) const
{
    return packed_float4(x * d, y * d, z * d, w * d);
}

float packed_float4::Dot(const packed_float4 &v) const
{
    return x * v.x + y * v.y + z * v.z + w * v.w;
}

float4x4::float4x4(const float4 columns[4])
{
    memcpy(this->columns, columns, sizeof(this->columns));
}

float4x4::float4x4(const float4 &column0, const float4 &column1, const float4 &column2, const float4 &column3)
{
    columns[0] = column0;
    columns[1] = column1;
    columns[2] = column2;
    columns[3] = column3;
}


float4x4::float4x4(float c0x, float c0y, float c0z, float c0w,
         float c1x, float c1y, float c1z, float c1w,
         float c2x, float c2y, float c2z, float c2w,
         float c3x, float c3y, float c3z, float c3w)
{
    columns[0] = float4(c0x, c0y, c0z, c0w);
    columns[1] = float4(c1x, c1y, c1z, c1w);
    columns[2] = float4(c2x, c2y, c2z, c2w);
    columns[3] = float4(c3x, c3y, c3z, c3w);
}

float4x4 float4x4::operator*(const float4x4 &m)
{
    float4x4 result;
    return result;
}

float3 float4x4::operator*(const float3 &v)
{
    float3 result;
    result.x = columns[0].x * v.x + columns[1].x * v.y + columns[2].x * v.z + columns[3].x * v.w;
    result.y = columns[0].x * v.x + columns[1].x * v.y + columns[2].x * v.z + columns[3].x * v.w;
    result.z = columns[0].x * v.x + columns[1].x * v.y + columns[2].x * v.z + columns[3].x * v.w;
    result.w = columns[0].x * v.x + columns[1].x * v.y + columns[2].x * v.z + columns[3].x * v.w;

    return result;
}

float4x4 float4x4::MakeRotationX(float alpha)
{
    float4x4 result(1.0f, 0.0f, 0.0f, 0.0f,
                    0.0f, cosf(alpha), sinf(alpha), 0.0f,
                    0.0f, -sinf(alpha), cosf(alpha), 0.0f,
                    0.0f, 0.0f, 0.0f, 1.0f);
    return result;
}

float4x4 float4x4::MakeRotationY(float alpha)
{
    float4x4 result(cosf(alpha), 0.0f, sinf(alpha), 0.0f,
                    0.0f, 1.0f, 0.0f, 0.0f,
                    -sinf(alpha), 0.0f, cosf(alpha), 0.0f,
                    0.0f, 0.0f, 0.0f, 1.0f);
    return result;
}

float4x4 float4x4::MakeRotationZ(float alpha)
{
    float4x4 result(cosf(alpha), sinf(alpha), 0.0f, 0.0f,
                    -sinf(alpha), cosf(alpha), 0.0f, 0.0f,
                    0.0f, 0.0f, 1.0f, 0.0f,
                    0.0f, 0.0f, 0.0f, 1.0f);
    return result;
}

float4x4 float4x4::MakeTranslation(float3 v)
{
    float4x4 result(1.0f, 0.0f, 0.0f, 0.0f,
                    0.0f, 1.0f, 0.0f, 0.0f,
                    0.0f, 0.0f, 1.0f, 0.0f,
                    v.x, v.y, v.z, 1.0f);
    return result;
}

float4x4 float4x4::MakeScale(float3 v)
{
    float4x4 result(v.x, 0.0f, 0.0f, 0.0f,
                    0.0f, v.y, 0.0f, 0.0f,
                    0.0f, 0.0f, v.z, 0.0f,
                    0.0f, 0.0f, 0.0f, 1.0f);
    return result;
}
