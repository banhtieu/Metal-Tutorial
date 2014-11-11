//
//  RedTriangle.metal
//  MetalFramework
//
//  Created by Tran Thien Khiem on 11/5/14.
//  Copyright (c) 2014 Tran Thien Khiem. All rights reserved.
//

#include <metal_stdlib>
#include <simd/simd.h>
#include "BufferIndex.h"

using namespace metal;

// the vertex input structure
// we need to declare it to match with the input data
struct VertexInput {
    packed_float3 position;
};

// the vertex output - data to be send from vertex processing stage
// to rasterization stage and to fragment processing stage later
// position is required.
struct VertexOutput {
    float4 position [[position]];
};

// the structure of fragment uniform data
struct FragmentUniformData {
    float4 color;
};

// we take the whole buffer
// and we need to calculate the output data for this stats
vertex VertexOutput RedTriangleVertex(
                                      const device VertexInput* vertexArray[[buffer(VERTEX_BUFFER)]],                                      unsigned int vertexId [[vertex_id]]
                                      ) {
    VertexOutput output;
    output.position = float4(vertexArray[vertexId].position, 1.0);
    return output;
}

// we take the rasterized data from
// rasterization stage and
// calculate the output color for the fragment,
// in this case we just return RED
fragment half4 RedTriangleFragment(VertexOutput vertexOutput [[stage_in]],
                                constant FragmentUniformData& uniform [[buffer(FRAGMENT_UNIFORM_BUFFER)]]
                                   ) {
    return half4(uniform.color);
}
