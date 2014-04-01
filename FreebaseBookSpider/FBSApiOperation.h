//
//  FBSApiOperation.h
//  FreebaseBookSpider
//
//  Created by Raffaele Bua on 01/04/14.
//

#import <Foundation/Foundation.h>
#import "FBSApiActions.h"

@protocol FBSApiOperatorDelegate
- (void) responseDidReceived:(NSDictionary*)json forAction:(FBSApiAction)action ofTarget:(id)target;
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

