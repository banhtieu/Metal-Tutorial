//
//  Shader.m
//  MetalFramework
//
//  Created by Tran Thien Khiem on 12/2/14.
//  Copyright (c) 2014 Tran Thien Khiem. All rights reserved.
//

#import "Device.h"
#import "Effect.h"

@implementation Effect

- (void)loadVertexShader:(NSString *)vertexFunctionName andFragmentShader:(NSString *)fragmentFunctionName
{
    id<MTLDevice> device = [[Device instance] device];
    
    // get the default library
    id<MTLLibrary> library = [device newDefaultLibrary];
    
    // get vertex function and fragment function
    id<MTLFunction> vertexFunction = [library newFunctionWithName:vertexFunctionName];
    id<MTLFunction> fragmentFunction = [library newFunctionWithName:fragmentFunctionName];
    
    // create a render pipeline descriptor
    MTLRenderPipelineDescriptor *descriptor = [[MTLRenderPipelineDescriptor alloc] init];
    
    // set fragment function
    descriptor.vertexFunction = vertexFunction;
    descriptor.fragmentFunction = fragmentFunction;
    
    // set pixel format
    [descriptor.colorAttachments objectAtIndexedSubscript:0].pixelFormat = MTLPixelFormatBGRA8Unorm;
    
    NSError *error = nil;
    _renderPipelineState = [device newRenderPipelineStateWithDescriptor:descriptor error:&error];
    
    if (error) {
        NSLog(@"Error creating render pipeline state");
    }

}

@end
