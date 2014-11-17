//
//  GameObject.m
//  MetalFramework
//
//  Created by Tran Thien Khiem on 11/17/14.
//  Copyright (c) 2014 Tran Thien Khiem. All rights reserved.
//

#import "GameObject.h"
#include "Common.h"

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
    
}

// update the object
- (void) update
{
    
}

@end
