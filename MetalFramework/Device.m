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
}

@end

@implementation Device

// initialize a device
- (instancetype)init
{
    self = [super init];
    if (self) {
        _device = MTLCreateSystemDefaultDevice();
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
