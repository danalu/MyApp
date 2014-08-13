//
//  ByteProcess.h
//  UniPayDemo
//
//  Created by Dana on 8/15/13.
//
//

#import <Foundation/Foundation.h>

/**
 * 字节数据处理器类
 * @ClassName: ByteProcess
 * @Description: 字节数据处理器
 */

@interface UnicomByteProcess : NSObject

/* 从一个字节数组中创建一个子字节数组
* Returns a byte array from another byte array
*
* @param byteArray
*            Byte array to parse
* @param offset_START
*            Starting location
* @param offset_END
*            Ending location
*/
+ (Byte *)getSubByteArray:(Byte[])byteArray offsetStart:(int)start offsetEnd:(int)end;

/**
 * 将字节数组转换为字符
 * Creates a Char from a byte array
 *
 * @param byteArray
 *            Array of bytes to convert
 */
+ (char)byteArrayToChar:(Byte [])byteArray;

/* 将字节数组转换为字符数组
* Creates a Char array from a byte array
*
* @param byteArray
*            Array of bytes to convert
*/
+ (char *)byteArrayToCharArray:(Byte[])byteArray;

/**
 * byteArrayToShort
 * @Description: 将字节数组转换为短整型
 * @param byteArray
 * @param offset
 * @return
 */
+ (int)byteArrayToInt:(Byte [])byteArray offset:(int)offset;

/**
 * 将字节数组转换为字符串
 * Creates a String from a byte array
 *
 * @param byteArray
 *            Byte array to convert
 */
+ (NSString *)byteArrayToString:(Byte [])byteArray;


/**
 * 将字节数组转换为字节
 * Creates a String from a byte
 *
 * @param byteArray
 *            Byte array to convert
 */
+ (Byte)byteArrayToByte:(Byte [])byteArray;

@end
