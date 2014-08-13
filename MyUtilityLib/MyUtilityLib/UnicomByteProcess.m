//
//  ByteProcess.m
//  UniPayDemo
//
//  Created by Dana on 8/15/13.
//
//

#import "UnicomByteProcess.h"

@implementation UnicomByteProcess

+ (Byte *)getSubByteArray:(Byte[])byteArray offsetStart:(int)start offsetEnd:(int)end {
    Byte *byteBuffer = malloc(end - start + 1);
    
    for (int i = start; i < end; i++) {
        byteBuffer[i - start] = byteArray[i];
    }

    byteBuffer[end - start] = '\0';
    
    return byteBuffer;
}

+ (char)byteArrayToChar:(Byte [])byteArray {
    return (char) ((0xff & byteArray[0]) << 8 | (0xff & byteArray[1]) << 0);
}

+ (char *)byteArrayToCharArray:(Byte[])byteArray {
    int size = strlen((const char *)byteArray) / 2;
    char * charArray = malloc(size);
    
    for (int s = 0 ; s < size; s++) {
        Byte *tmpArray = [UnicomByteProcess getSubByteArray:byteArray offsetStart:s * 2 offsetEnd:(s + 1) * 2];
        charArray[s] = [UnicomByteProcess byteArrayToChar:tmpArray];
        
        free(tmpArray);
    }
    
    return charArray;
}

+ (int)byteArrayToInt:(Byte [])byteArray offset:(int)offset {
    return (0xff & byteArray[offset]) << 24 | (0xff & byteArray[offset + 1]) << 16
    | (0xff & byteArray[offset + 2]) << 8 | (0xff & byteArray[offset + 3]) << 0;
}

+ (NSString *)byteArrayToString:(Byte [])byteArray {
    return [NSString stringWithCString:(const char *)byteArray encoding:NSUTF8StringEncoding];
}

+ (Byte)byteArrayToByte:(Byte [])byteArray {
    
    return byteArray[0];
}

@end
