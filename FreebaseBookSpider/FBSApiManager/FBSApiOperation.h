//
//  FBSApiOperation.h
//  FreebaseBookSpider
//
//  Created by Raffaele Bua on 01/04/14.
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
#import "FBSApiActions.h"

@protocol FBSApiOperatorDelegate
//- (void) responseDidReceived:(NSDictionary*)json forAction:(FBSApiAction)action ofTarget:(id)target;
- (void) responseDidReceived:(NSData*)response forAction:(FBSApiAction)action ofTarget:(id)target;
@end

@interface FBSApiOperation : NSOperation
{
    BOOL executing;
    BOOL finished;
    NSMutableData * buffer;
    NSURLConnection * _connection;
    FBSApiAction _action;
    id<FBSApiOperatorDelegate>_delegate;
    id _target;
}

-(id)initWithUrl:(NSURL * )url andDelegate:(id)_delegate forAction:(FBSApiAction)action andTarget:(id)target;


@end

