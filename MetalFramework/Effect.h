//
//  Shader.h
//  MetalFramework
//
//  Created by Tran Thien Khiem on 12/2/14.
//  Copyright (c) 2014 Tran Thien Khiem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Metal/Metal.h>

@interface Effect : NSObject

@property(nonatomic, retain, readonly) id<MTLRenderPipelineState> renderPipelineState;

- (void) loadVertexShader:(NSString*) vertexFunction andFragmentShader:(NSString*) fragmentFunction;

@end
