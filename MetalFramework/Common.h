//
//  Buffer.h
//  MetalFramework
//
//  Created by Tran Thien Khiem on 11/11/14.
//  Copyright (c) 2014 Tran Thien Khiem. All rights reserved.
//

#ifndef MetalFramework_Common_h
#define MetalFramework_Common_h

#include <simd/simd.h>

using namespace simd;

// uniform data for matrix
struct VertexUniformData {
    float4x4 wvpMatrix;
};

// the data we want to pass to fragment shader
struct FragmentUniformData{
    float4 color;
};

#endif
