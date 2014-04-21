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

#import "FBSTopic.h"
#import "FBSProperty.h"

@interface FBSAuthorNode : FBSTopic

@property(nonatomic)FBSProperty  * dateOfBirth;
@property(nonatomic)FBSProperty  * placeOfBirth;
@property(nonatomic)FBSProperty  * nationality;
@property(nonatomic)FBSProperty  * gender;
@property(nonatomic)FBSProperty  * profession;
@property(nonatomic)FBSProperty  * religion;
@property(nonatomic)FBSProperty  * parents;
@property(nonatomic)FBSProperty  * children;
@property(nonatomic)FBSProperty  * spouseS;
@property(nonatomic)FBSProperty  * employmentHistory;
@property(nonatomic)FBSProperty  * education;
@property(nonatomic)FBSProperty  * quotations;
@property(nonatomic)FBSProperty  * placesLived;
@property(nonatomic)FBSProperty  * languages;
@property(nonatomic)FBSProperty  * dateOfDeath;
@property(nonatomic)FBSProperty  * placeOfDeath;
@property(nonatomic)FBSProperty  * causeOfDeath;
@property(nonatomic)FBSProperty  * worksWritten;
@property(nonatomic)FBSProperty  * influencedBy;
@property(nonatomic)FBSProperty  * influenced;

@end
