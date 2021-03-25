//
//  DataBuffer.m
//  ObjectiveApp
//
//  Created by Orlando Chen on 2021/3/25.
//

#import "DataBuffer.h"
#import "Converter.h"


@interface DataBuffer()
@property unsigned char* buffer;
@property NSMutableArray* tokens;
@property NSInteger header;
@property NSInteger capacity;
@end


@implementation DataBuffer


- (id)init
{
    if (self = [super init]) {
        [self realloc: 1024];
    }
    
    return self;
};


- (id)initWithCapacity: (NSInteger)capacity
{
    if (self = [super init]) {
        [self realloc: capacity];
    }
    
    return self;
};


- (void)dealloc
{
    if (self.buffer != nil) {
        free(self.buffer);
        self.buffer = nil;
    }
};


- (void)realloc: (NSInteger) capacity
{
    if (self.buffer == nil) {
        self.buffer = malloc(capacity);
        self.header = 0; // 创建新的空间时，自动指向0
        
    } else {
        unsigned char* temp = calloc(capacity, sizeof(unsigned char));
        
        // copy buffer to temp
        memcpy(temp, self.buffer, self.header);
        
        // free buffer
        free(self.buffer);
        
        // point buffer ptr to temp
        self.buffer = temp;
    }
    
    if (self.tokens == nil) {
        self.tokens = [[NSMutableArray alloc] init];
    }
    
    self.capacity = capacity;
};


- (NSInteger)getOptimizedSize: (NSInteger)size
{
    float remainder = size;
    NSInteger exponential = 0;
    
    while(remainder > 1.f) {
        remainder = (float)remainder / 2.0f;
        exponential += 1;
    }
    
    double final = pow(2, exponential);
    return (NSInteger) final;
};


- (NSInteger)writeToBuffer: (NSData*)data
{
    NSInteger size = 0;
    NSInteger reset = self.capacity - self.header;
    
    // get bytes from nsdata
    unsigned char* bytes = [Converter cvtDataToCBytes:data length:&size];
    
    if (size >= 0 && reset > size) { // 正常情况
        
        // 写入数据
        memcpy(self.buffer + self.header, bytes, size);
        self.header += size;
        
    } else { // 需要写入的数据大于了可以存储的空间
        
        // 重新创建一个合适的数据空间
        NSInteger newCap = [self getOptimizedSize: self.header + size];
        [self realloc: newCap];
        
        // 写入数据
        memcpy(self.buffer + self.header, bytes, size);
        self.header += size;
    }
    
    // 返回成功写入的字节数
    return size;
}


- (NSInteger)getRestSize
{
    return self.capacity - self.header;
};


- (NSData*)getBuffer {
    return [Converter cvtCBytesToData:self.buffer length:self.header];
};


- (NSInteger)getBufferSize {
    return self.capacity;
};


- (void)appendData: (NSData*)data
{
    // 将数据写入缓冲
    [self writeToBuffer:data];
    
    
};

@end
