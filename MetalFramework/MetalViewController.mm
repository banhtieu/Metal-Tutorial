//
//  ViewController.m
//  MetalFramework
//
//  Created by Tran Thien Khiem on 11/5/14.
//  Copyright (c) 2014 Tran Thien Khiem. All rights reserved.
//

#import "MetalViewController.h"
#import "BufferIndex.h"

// import metal
// @import will automatically add linked library to the project
#import <Metal/Metal.h>
#import <QuartzCore/CAMetalLayer.h>

//#include "simdmath.h"
#include "Common.h"
#include "Transform.h"
#include "Device.h"
#include "Model.h"

@interface MetalViewController ()
{   
    // the command queue
    id<MTLCommandQueue> commandQueue;
    
    // vertex buffer
    id<MTLBuffer> vertexBuffer;
    
    // rotate angle
    float rotateAngle;
    
    // vertex Uniform buffer
    id<MTLBuffer> vertexUniformBuffer;
    
    // fragment Uniform Buffer
    id<MTLBuffer> fragmentUniformBuffer;
    
    // render pipeline state
    id<MTLRenderPipelineState> renderPipelineState;
    
    // the metal layer
    CAMetalLayer *metalLayer;
    
    // drawable
    id<CAMetalDrawable> drawable;
    
    CADisplayLink *timer;
    
    Model *model;
    Device *device;
}

@end

@implementation MetalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // initialize the graphics device
    [self initDevice];
    
    // create the CAMetalLayer
    [self initMetalLayer];
    
    // create a command queue to manage all commands sent to GPU
    // all commands will be encoded using command encoders
    // then added to a command buffer
    // and finally sent to command queue for execution
    [self createCommandQueue];
    
    // initialize resources.
    [self createRenderResources];
    
    // setup the game loop
    [self setUpGameLoop];
    
    model = [[Model alloc] init];
    
    [model load:@"res/Models/Bila"];
    
}

// intialize the graphics device
- (void) initDevice {
    device = [[Device alloc] init];
}

// initialize a layer and attach to uiview layer
- (void) initMetalLayer {
    [device initLayer:self.view];
}

// create the command queue
- (void) createCommandQueue {
    commandQueue = [device newCommandQueue];
}

// in this step we need to initialize all resources
// vertex buffers
// pipeline states
// rendering states
- (void) createRenderResources {
    
    // create the vertex buffer
    [self createVertexBuffer];
    
    // create uniform buffer
    [self createUniformsBuffer];
    
    // create the render pipeline state
    [self createRenderPipelineState];
    
}

// create
- (void) createVertexBuffer {
    // describe the object
    struct Position {
        float x;
        float y;
        float z;
    };
    
    // declare the data
    struct Position verticesData[] = {
        {0.0f, 0.5f, 0.0f},
        {-0.5f, -0.5f, 0.0f},
        {0.5f, -0.5f, 0.0f}
    };
    
    // create the buffer
    vertexBuffer = [device newBufferWithBytes:verticesData length:sizeof(verticesData) options:MTLResourceOptionCPUCacheModeDefault];
}

// create uniforms buffers
- (void) createUniformsBuffer {
    VertexUniformData vertexUniformData;
    
    vertexUniformBuffer = [device newBufferWithBytes:&vertexUniformData length:sizeof(VertexUniformData) options:MTLResourceOptionCPUCacheModeDefault];
    
    FragmentUniformData fragmentUniformData;
    fragmentUniformData.color = {1.0f, 0.0f, 1.0f, 1.0f};
    fragmentUniformBuffer = [device newBufferWithBytes:&fragmentUniformData length:sizeof(fragmentUniformData) options:MTLResourceOptionCPUCacheModeDefault];
}

// create the render pipeline state to render later
- (void) createRenderPipelineState {
    // get the default library
    id<MTLLibrary> library = [device newDefaultLibrary];
    
    // get vertex function and fragment function
    id<MTLFunction> vertexFunction = [library newFunctionWithName:@"RedTriangleVertex"];
    id<MTLFunction> fragmentFunction = [library newFunctionWithName:@"RedTriangleFragment"];
    
    // create a render pipeline descriptor
    MTLRenderPipelineDescriptor *descriptor = [[MTLRenderPipelineDescriptor alloc] init];
    
    // set fragment function
    descriptor.vertexFunction = vertexFunction;
    descriptor.fragmentFunction = fragmentFunction;
    
    // set pixel format
    [descriptor.colorAttachments objectAtIndexedSubscript:0].pixelFormat = MTLPixelFormatBGRA8Unorm;
    
    NSError *error = nil;
    renderPipelineState = [device newRenderPipelineStateWithDescriptor:descriptor error:&error];
    
    if (error) {
        NSLog(@"Error creating render pipeline state");
    }
    
    
}

// render the scene
- (void) renderScene {
    
    // setup render pass and create a command buffer
    MTLRenderPassDescriptor *renderPassDescriptor = [self createRenderPassDescriptor];
    
    // create a command buffer
    id<MTLCommandBuffer> commandBuffer = [self createCommandBuffer];
    
    // render triangle with command buffer and render pass descriptor
    [self renderTriangleWithCommandBuffer:commandBuffer andRenderPassDescriptor:renderPassDescriptor];
}

// create a render pass descriptor
- (MTLRenderPassDescriptor *) createRenderPassDescriptor{
    // get next drawable
    drawable = metalLayer.nextDrawable;
    
    // create the render descriptor
    MTLRenderPassDescriptor *descriptor = [[MTLRenderPassDescriptor alloc] init];
    
    MTLRenderPassColorAttachmentDescriptor *colorAttachment = [descriptor.colorAttachments objectAtIndexedSubscript:0];
    
    // set texture for first color attachment
    colorAttachment.texture = [drawable texture];
    colorAttachment.loadAction = MTLLoadActionClear;
    colorAttachment.clearColor = MTLClearColorMake(0.0, 0.0, 0.0, 1.0);
    
    return descriptor;
}

// create a command buffer
- (id<MTLCommandBuffer>) createCommandBuffer {
    id<MTLCommandBuffer> commandBuffer = [commandQueue commandBuffer];
    return commandBuffer;
}

// render triangle
- (void) renderTriangleWithCommandBuffer: (id<MTLCommandBuffer>) commandBuffer andRenderPassDescriptor: (MTLRenderPassDescriptor*) renderPassDescriptor {
    
    // create the command encoder
    id<MTLRenderCommandEncoder> commandEncoder = [commandBuffer renderCommandEncoderWithDescriptor:renderPassDescriptor];
    
    // set cull mode
    [commandEncoder setCullMode:MTLCullModeFront];
    
    // set vertex buffer
    [commandEncoder setVertexBuffer:vertexBuffer offset:0 atIndex:VERTEX_BUFFER];
    
    //
    VertexUniformData vertexUniformData;

    vertexUniformData.wvpMatrix = math::rotate(rotateAngle, 0.0f, 0.0f, 1.0f);
    memcpy([vertexUniformBuffer contents], &vertexUniformData, sizeof(VertexUniformData));
    
    [commandEncoder setVertexBuffer:vertexUniformBuffer offset:0 atIndex:VERTEX_UNIFORM_BUFFER];
    [commandEncoder setFragmentBuffer:fragmentUniformBuffer offset:0 atIndex:FRAGMENT_UNIFORM_BUFFER];
    
    [commandEncoder setRenderPipelineState:renderPipelineState];
    
    // draw primitives
    [commandEncoder drawPrimitives:MTLPrimitiveTypeTriangle vertexStart:0 vertexCount:3];
    
    // end encoding and add to command buffer
    [commandEncoder endEncoding];
    [commandBuffer presentDrawable:drawable];
    
    // commit to the command queue
    [commandBuffer commit];
}

// set up the game loop
- (void) setUpGameLoop {
    timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(gameLoop)];
    [timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

// update game logic here
- (void) update:(CFTimeInterval) frameTime
{
    rotateAngle += frameTime * M_PI / 2;
}

// the loop content
- (void) gameLoop {
    @autoreleasepool {
        [self update: timer.duration];
        [self renderScene];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
