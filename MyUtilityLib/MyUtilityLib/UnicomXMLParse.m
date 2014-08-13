//
//  XMLParse.m
//  UniPayDemo
//
//  Created by Dana lu on 13-8-17.
//  Copyright (c) 2013年 Dana. All rights reserved.
//

#import "UnicomXMLParse.h"

@interface UnicomXMLParse () {
    NSXMLParser *_xmlParse;
    NSMutableDictionary *_nodeArray;
    NSMutableString *_value;
    
    NSString *_currentKey;
}

@property (nonatomic, retain) NSArray *keyArray;
@property (nonatomic, copy) XMLParseCompletedBlock xmlParseCompletedBlock;

@end

@implementation UnicomXMLParse
@synthesize keyArray;
@synthesize xmlParseCompletedBlock;

- (id)init {
    self = [super init];
    if (self) {
        _nodeArray  = [[NSMutableDictionary alloc] initWithCapacity:0];
        _value = [[NSMutableString alloc] initWithCapacity:0];
    }
    return self;
}

- (void)dealloc {
    _xmlParse.delegate = nil;
   
    self.keyArray = nil;
    self.xmlParseCompletedBlock = nil;
}

- (void)parseValueWithData:(NSData *)pData keys:(NSArray *)pKeys completion:(XMLParseCompletedBlock)pXMLParseCompleted {
    self.keyArray = pKeys;
    self.xmlParseCompletedBlock = pXMLParseCompleted;
    _xmlParse = [[NSXMLParser alloc] initWithData:pData];
    [_xmlParse setDelegate:self];
	[_xmlParse setShouldProcessNamespaces:NO];
	[_xmlParse setShouldReportNamespacePrefixes:NO];
	[_xmlParse setShouldResolveExternalEntities:NO];	
	if([_xmlParse parse]) {
        self.xmlParseCompletedBlock(_nodeArray, nil);
    } else {
        self.xmlParseCompletedBlock(nil, _xmlParse.parserError);
    }
}

#pragma mark -
#pragma mark NSXMLParseDelegate methods
#pragma mark NSXMLParserDelegateEventAdditions methods
/*
 *  找到节点开始符, 定位指定的key 
 *  <key>
 */
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
     NSString *name = [elementName lowercaseString];
    
    NSInteger keyIndex = [self.keyArray indexOfObject:name];
    if (keyIndex != NSNotFound) {
        _currentKey = name;
    }
}

/*
 *  解析的是中间的值,解析节点值
 *  value
 */
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    [_value appendString:string];
}

/*
 *  找到节点结束符, 此时一个节点值结束，把我们解析出来的数据存入NSDictionary或是NSArray中去了
 *  </key>
 */
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    NSString *name = [elementName lowercaseString];
    
    if (_currentKey && [_currentKey isEqualToString:name]) {
        NSString *value = [_value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [_nodeArray setValue:value forKey:_currentKey];
    }
    
    //ret key and value.
    _currentKey = nil;
    [_value deleteCharactersInRange:NSMakeRange(0, [_value length])];
}

@end
