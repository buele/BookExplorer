//
//  FBSViewController.m
//
//  Created by Raffaele Bua on 04/05/14.

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

#import "FBSButton.h"
#import "FBSView.h"
#import "FBSViewController.h"

@implementation FBSViewController

- (id)init {
    self = [super init];
    if (self) {
        // manage view
        bookSpider = [[FreebaseBookSpider alloc] initWithDelegate:self];
		view = [[FBSView alloc] init];
		[view setDelegate:self];
        
        // manage rotation
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        [[NSNotificationCenter defaultCenter]
         addObserver:self selector:@selector(orientationChanged:)
         name:UIDeviceOrientationDidChangeNotification
         object:[UIDevice currentDevice]];
    }
    
    return self;
}

-(void)pushButtonDidPressed
{
	FBSViewController * viewController = [[FBSViewController alloc]init] ;
	[self.navigationController pushViewController:viewController animated:YES];
	[viewController release];
	
}
-(void)testRequestButtonDidPressed
{
    [bookSpider getTopicById:@"/m/034bs" name:@"Orwell" forDelegate:self];
}

// ----- //
-(void)nodesDidGenerated:(NSArray *)theNodes forKeyword:(NSString *)keyword
{
    //  [freebaseBookSpider getTopicByNode:[theNodes objectAtIndex:0] forDelegate:self];
    NSLog(@"log");
}

-(void)topicDidGenerated:(FBSTopic *)theTopic
{
    // NSLog(@"name: %@", theTopic.name);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Author name"
                                                    message:theTopic.name
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
    
}

// ----- //


- (void)loadView {
	[super loadView];
	[self.view setFrame:[[UIScreen mainScreen] bounds]];
	[self.view addSubview:view];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)orientationChanged:(NSNotification *)notification
{
}

- (void)dealloc {
    [bookSpider release];
	[view release];
    [super dealloc];
}

@end
