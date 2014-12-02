//
//  Model.h
//  MetalFramework
//
//  Created by Tran Thien Khiem on 11/17/14.
//  Copyright (c) 2014 Tran Thien Khiem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Metal/Metal.h>

struct packed_vector3
{
    float x;
    float y;
    float z;
};

struct packed_vector2
{
    float x;
    float y;
};

struct VertexData
{
    packed_vector3 position;
    packed_vector3 normal;
    packed_vector3 biNormal;
    packed_vector3 tangent;
    packed_vector2 uv;
};

@interface Model : NSObject

// vertex buffer
@property(nonatomic, retain, readonly) id<MTLBuffer> vertexBuffer;

// fragment buffer
@property(nonatomic, retain, readonly) id<MTLBuffer> indexBuffer;

// get number of indices
@property(nonatomic, readonly) UInt32 numberOfIndices;

// get number of vertices
@property(nonatomic, readonly) UInt32 numberOfVertices;

// load the model from a path
- (void) load:(NSString *) path;
@end
