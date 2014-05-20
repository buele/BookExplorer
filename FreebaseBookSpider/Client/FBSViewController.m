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
#import "BETopicViewController.h"


@implementation FBSViewController
@synthesize searchResults;
@synthesize enableSelectTopic;

- (id)init {
    self = [super init];
    if (self) {
        enableSelectTopic = YES;
        //table view
        searchResultTableView = [[UITableView alloc] init];
        [searchResultTableView setDelegate:self];
        [searchResultTableView setDataSource:self];
        [searchResultTableView setHidden:YES];
        [searchResultTableView setSeparatorInset:UIEdgeInsetsZero];
        
        // manage view
        bookSpider = [[FreebaseBookSpider alloc] initWithDelegate:self];
		view = [[FBSView alloc] init];
        [view setDelegate:self];
        [view setSearchResultTableView:searchResultTableView];
        [view addSubview:searchResultTableView];
        [view setSearchResultTableViewFrame];
        
        // manage rotation
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        [[NSNotificationCenter defaultCenter]
         addObserver:self selector:@selector(orientationChanged:)
         name:UIDeviceOrientationDidChangeNotification
         object:[UIDevice currentDevice]];
        
        // indicator
        indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        indicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
        indicator.center = self.view.center;
        [self.view addSubview:indicator];
        [indicator bringSubviewToFront:self.view];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
        
        // searchResult
        searchResults = nil;
    }
    
    return self;
}


#pragma  mark FreebaseBookSpiderDelegate protocol
-(void)nodesDidGenerated:(NSArray *)theNodes forKeyword:(NSString *)keyword
{
    [indicator stopAnimating];
    NSLog(@"log");
    if(theNodes != nil && [theNodes count]>0){
        [view expandSearchBox];
        self.searchResults = theNodes;
    }else{
        NSString * alertMessage = [NSString stringWithFormat:@"No results for '%@' entry.",keyword];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:alertMessage
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}

-(void)topicDidGenerated:(FBSTopic *)theTopic
{
    [indicator stopAnimating];
    BETopicViewController * topicViewController = [[BETopicViewController alloc]initWithTopic:theTopic] ;
    [self.navigationController setToolbarHidden:YES animated:NO];
	[self.navigationController pushViewController:topicViewController animated:YES];
	[topicViewController release];
    self.enableSelectTopic = YES;
}

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

- (BOOL)prefersStatusBarHidden {
    return YES;
}
#pragma mark view protocol
-(void)searchBoxDidCollapsed
{
    self.searchResults = @[];
    self.enableSelectTopic = YES;
}

-(void)searchBoxDidExpanded
{
    [searchResultTableView reloadData];
}

#pragma mark TableView protocol

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(enableSelectTopic){
        self.enableSelectTopic = NO;
        NSLog(@"Element selected");
        FBSNode * node =[searchResults objectAtIndex:indexPath.row];
        NSLog(@"element selected: id:%@, name:%@, notableId: %@, notableName: %@",node.nodeId, node.name,node.notableId,node.notableName);
        [bookSpider getTopicById:node.nodeId name:node.name forDelegate:self];
        [indicator startAnimating];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [searchResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier] autorelease];
    FBSNode * node =[searchResults objectAtIndex:indexPath.row];
	[cell.textLabel setText:node.name];
    [cell.detailTextLabel setText:node.notableName];
    
    return cell;
}


#pragma mark FBSearchBoxDelegate

-(void)searchNodesByKeyword:(NSString *)aKeyword
{
    NSLog(@"searchNodesByKeysord: %@",aKeyword);
    [bookSpider getNodesByKeyword:aKeyword forDelegate:self];
    [indicator startAnimating];
}


#pragma mark dealloc
- (void)dealloc {
    [bookSpider release];
	[view release];
    [indicator release];
    [searchResults release];
    [searchResultTableView release];
    [super dealloc];
}
@end
