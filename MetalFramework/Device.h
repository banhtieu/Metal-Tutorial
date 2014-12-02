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

- (id) init;
- (void) initLayer:(UIView *) view;

@end
