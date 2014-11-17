//
//  GameObject.h
//  MetalFramework
//
//  Created by Tran Thien Khiem on 11/17/14.
//  Copyright (c) 2014 Tran Thien Khiem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Metal/Metal.h>

#import "Transform.h"
using namespace simd;

// Game Object
@interface GameObject : NSObject

// position of the object
@property(nonatomic) float3 position;

// rotation of the object
@property(nonatomic) float3 rotation;

// scale of the object
@property(nonatomic) float3 scale;

// world matrix for this object
@property(nonatomic) float4x4 worldMatrix;

// vertex buffer of this Game Object
@property(nonatomic, retain) id<MTLRenderPipelineState> renderPipelineState;

// array of textures
@property(nonatomic, retain) NSMutableArray *textures;

// update this object
- (void) update;

// render scene
- (void) render;
@end
