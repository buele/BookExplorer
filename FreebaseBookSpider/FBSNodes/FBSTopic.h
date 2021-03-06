//
//  FBSNode.h
//  FreebaseBookSpider
//
//  Created by Raffaele Bua on 11/04/14.

/*****************************************************************************
 The MIT License (MIT)
 
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 *****************************************************************************/

#import <Foundation/Foundation.h>
#import "FBSNodeTypes.h"
#import "FBSProperty.h"
#import "FBSNode.h"

extern NSString * const FB_DESCRIPTION_KEY;
extern NSString * const FB_DESCRIPTION_LABEL;
extern NSString * const FB_QUOTATIONS_KEY;
extern NSString * const FB_QUOTATIONS_LABEL;
extern NSString * const FB_INFLUENCED_BY_KEY;
extern NSString * const FB_INFLUENCED_BY_LABEL;
extern NSString * const FB_INFLUENCED_KEY;
extern NSString * const FB_INFLUENCED_LABEL;

@interface FBSTopic : FBSNode
{
    @protected
    NSMutableDictionary * properties;
}
@property(nonatomic, retain)FBSProperty * alias;
@property(nonatomic, retain)FBSProperty * description;
@property(nonatomic, retain)UIImage     * image;
@property(nonatomic)FBSNodeTypes  type;


-(id)initWithAlias:(FBSProperty *)anAlias description:(FBSProperty *)aDescription image:(UIImage *)anImage type:(FBSNodeTypes) aType;
-(id)initWithFBSNode:(FBSNode *)aNode;
-(id)initWithFBSNode:(FBSNode *)aNode properties:(NSDictionary *)properties;
-(id)initWithFBSNode:(FBSNode *)aNode type:(FBSNodeTypes)aType description:(FBSProperty *)aDescription;
-(NSDictionary *)properties;

@end
