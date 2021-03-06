//
//  Device.h
//  MetalFramework
//
//  Created by Tran Thien Khiem on 12/2/14.
//  Copyright (c) 2014 Tran Thien Khiem. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <Metal/Metal.h>

@interface Device : NSObject

@property (nonatomic, retain, readonly) id<MTLDevice> device;
@property (nonatomic, retain, readonly) MTLRenderPassDescriptor *renderPassDescriptor;
@property (nonatomic, retain, readonly) id<MTLCommandQueue> commandQueue;
@property (nonatomic, retain, readonly) id<MTLCommandBuffer> commandBuffer;

- (id) init;
- (void) initLayer:(UIView *) view;
- (id<MTLBuffer>) createBufferWithData:(void *) data andSize: (UInt32) size;
- (void) startDrawing;


+ (Device *) instance;
@end
