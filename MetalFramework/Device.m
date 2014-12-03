//
//  Device.m
//  MetalFramework
//
//  Created by Tran Thien Khiem on 12/2/14.
//  Copyright (c) 2014 Tran Thien Khiem. All rights reserved.
//


#import "Device.h"
#import <QuartzCore/CAMetalLayer.h>

@interface Device()
{
    CAMetalLayer *metalLayer;
    id<CAMetalDrawable> drawable;
}

@end

@implementation Device

// initialize a device
- (instancetype)init
{
    self = [super init];
    
    if (self) {
        _device = MTLCreateSystemDefaultDevice();
        _commandQueue = [_device newCommandQueue];
    }
    
    return self;
}

// Initialize a layer with a view
- (void)initLayer:(UIView *)view
{
    metalLayer = [[CAMetalLayer alloc] init];
    
    // set contents scale for retina display
    metalLayer.contentsScale = [UIScreen mainScreen].nativeScale;
    
    // set layer frame
    metalLayer.frame = view.frame;
    
    // set drawable size (size of output buffer)
    CGSize drawableSize = view.bounds.size;
    
    // multiply by content scale
    drawableSize.width *= metalLayer.contentsScale;
    drawableSize.height *= metalLayer.contentsScale;
    
    // add to main view
    [view.layer addSublayer:metalLayer];
}

// Create a new buffer
- (id<MTLBuffer>)createBufferWithData:(void *)data andSize:(UInt32)size
{
    return [_device newBufferWithBytes:data length:size options:MTLResourceOptionCPUCacheModeDefault];
}

- (void) startDrawing
{
    // get next drawable
    drawable = metalLayer.nextDrawable;
    
    // create the render descriptor
    _renderPassDescriptor = [[MTLRenderPassDescriptor alloc] init];
    
    MTLRenderPassColorAttachmentDescriptor *colorAttachment = [_renderPassDescriptor.colorAttachments objectAtIndexedSubscript:0];
    
    // set texture for first color attachment
    colorAttachment.texture = [drawable texture];
    colorAttachment.loadAction = MTLLoadActionClear;
    colorAttachment.clearColor = MTLClearColorMake(0.0, 0.0, 0.0, 1.0);
}

// get the command buffer
- (id<MTLCommandBuffer>) commandBuffer
{
    return [self.commandQueue commandBuffer];
}


// get the static instance
+ (Device *) instance
{
    static Device *instance = NULL;
    
    if (instance == NULL)
    {
        instance = [[Device alloc] init];
    }
    
    return instance;
}

@end
