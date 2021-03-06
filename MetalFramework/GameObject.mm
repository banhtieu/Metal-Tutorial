//
//  GameObject.m
//  MetalFramework
//
//  Created by Tran Thien Khiem on 11/17/14.
//  Copyright (c) 2014 Tran Thien Khiem. All rights reserved.
//

#import "GameObject.h"
#import "Common.h"
#import "Device.h"

@interface GameObject()
{
    BOOL _worldMatrixChanged;
    VertexUniformData vertexUniformData;
    FragmentUniformData fragmentUniformData;
}
@end

@implementation GameObject

// set scale
- (void) setScale:(float3) scale
{
    _scale = scale;
    _worldMatrixChanged = true;
}

- (void) setRotation:(float3) rotation
{
    _rotation = rotation;
    _worldMatrixChanged = true;
}

// set the position
- (void) setPosition:(float3) position
{
    _position = position;
    _worldMatrixChanged = true;
}

// get world matrix
- (float4x4) worldMatrix
{
    // if _worldMatrixChanged then update world matrix
    if (_worldMatrixChanged)
    {
        float4x4 translationMatrix = math::translate(self.position);
        float4x4 rotationXMatrix = math::rotate(self.rotation.x, 1.0f, 0.0f, 0.0f);
        float4x4 rotationYMatrix = math::rotate(self.rotation.y, 0.0f, 1.0f, 0.0f);
        float4x4 rotationZMatrix = math::rotate(self.rotation.z, 0.0f, 0.0f, 1.0f);
        float4x4 scaleMatrix = math::scale(self.scale);
        
        _worldMatrix = translationMatrix * rotationYMatrix * rotationXMatrix * rotationZMatrix * scaleMatrix;
    }
    
    return _worldMatrix;
}

// render this object
- (void) render
{
    // If model and effect is not null
    if (self.model && self.effect) {
        // create command encoder
        Device *device = [Device instance];
        id<MTLRenderCommandEncoder> commandEncoder = [device.commandBuffer renderCommandEncoderWithDescriptor:device.renderPassDescriptor];
        
        // start drawing
        [commandEncoder setVertexBuffer:self.model.vertexBuffer offset:0 atIndex:VERTEX_BUFFER];
        [commandEncoder drawIndexedPrimitives:MTLPrimitiveTypeTriangle indexCount:self.model.numberOfIndices indexType:MTLIndexTypeUInt16 indexBuffer:self.model.indexBuffer indexBufferOffset:0];
        [commandEncoder endEncoding];
    }
}

// update the object
- (void) update
{
    
}

@end
