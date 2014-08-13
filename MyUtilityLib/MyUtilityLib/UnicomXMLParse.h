//
//  XMLParse.h
//  UniPayDemo
//
//  Created by Dana lu on 13-8-17.
//  Copyright (c) 2013年 Dana. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 *  xml parse completion callback.
 */
typedef void(^XMLParseCompletedBlock)(id obj, NSError *error);


@interface UnicomXMLParse : NSObject<NSXMLParserDelegate>

- (void)parseValueWithData:(NSData *)pData keys:(NSArray *)pKeys completion:(XMLParseCompletedBlock)pXMLParseCompleted;

@end
