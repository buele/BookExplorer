//
//  FBSAuthorNode.h
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

#import "FBSNode.h"

@interface FBSAuthorNode : FBSNode

@property(nonatomic)NSDate   * dateOfBirth;
@property(nonatomic)NSString * placeOfBirth;
@property(nonatomic)NSArray  * nationality;
@property(nonatomic)NSString * gender;
@property(nonatomic)NSArray  * profession;
@property(nonatomic)NSArray  * religion;
@property(nonatomic)NSArray  * parents;
@property(nonatomic)NSArray  * children;
@property(nonatomic)NSArray  * spouseS;
@property(nonatomic)NSArray  * employmentHistory;
@property(nonatomic)NSArray  * education;
@property(nonatomic)NSArray  * quotations;
@property(nonatomic)NSArray  * placesLived;
@property(nonatomic)NSArray  * languages;
@property(nonatomic)NSDate   * dateOfDeath;
@property(nonatomic)NSString * placeOfDeath;
@property(nonatomic)NSString * causeOfDeath;
@property(nonatomic)NSArray  * worksWritten;
@property(nonatomic)NSArray  * influencedBy;
@property(nonatomic)NSArray  * influenced;

@end
