//
//  Model.m
//  MetalFramework
//
//  Created by Tran Thien Khiem on 11/17/14.
//  Copyright (c) 2014 Tran Thien Khiem. All rights reserved.
//

#import "Model.h"
#import "Device.h"
#include <stdio.h>

@implementation Model

// load a model from a file
- (void) load:(NSString *)path
{
    NSBundle *bundle = [NSBundle mainBundle];
    path = [bundle pathForResource:path ofType:@"nfg"];
    FILE *file = fopen([path UTF8String], "r");
    
    VertexData *verticesData = NULL;
    UInt16 *indices = NULL;
    
    if (file)
    {
        fscanf(file, "NrVertices: %u\n", &_numberOfVertices);
        
        verticesData = new VertexData;
        for (int i = 0; i < _numberOfVertices; i++)
        {
            fscanf(file, "%*d. pos:[%f, %f, %f]; norm:[%f, %f, %f]; binorm:[%f, %f, %f]; tgt:[%f, %f, %f]; uv:[%f, %f];\n",
                   &verticesData[i].position.x, &verticesData[i].position.y, &verticesData[i].position.y,
                   &verticesData[i].normal.x, &verticesData[i].normal.y, &verticesData[i].normal.y,
                   &verticesData[i].biNormal.x, &verticesData[i].biNormal.y, &verticesData[i].biNormal.y,
                   &verticesData[i].tangent.x, &verticesData[i].tangent.y, &verticesData[i].tangent.y,
                   &verticesData[i].uv.x, &verticesData[i].uv.y
                   );
        }
        
        fscanf(file, "NrIndices: %u\n", &_numberOfIndices);
        
        indices = new UInt16[_numberOfIndices];
        
        for (int i = 0; i < _numberOfIndices / 3; i++) {
            fscanf(file, "  %*d.   %hd,   %hd,   %hd\n", &indices[i * 3], &indices[i * 3 + 1], &indices[i * 3 + 2]);
        }
        
        fclose(file);
        
        Device *device = [Device instance];
        // load
        _vertexBuffer = [device createBufferWithData:verticesData andSize:sizeof(VertexData) * _numberOfVertices];
        _indexBuffer = [device createBufferWithData:indices andSize:sizeof(UInt16) * _numberOfIndices];
    }
    else
    {
        assert(false);
    }
}

@end
