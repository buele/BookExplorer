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

@interface FBSAuthor : FBSTopic

@property(nonatomic, retain)FBSProperty  * dateOfBirth;
@property(nonatomic, retain)FBSProperty  * placeOfBirth;
@property(nonatomic, retain)FBSProperty  * nationality;
@property(nonatomic, retain)FBSProperty  * gender;
@property(nonatomic, retain)FBSProperty  * profession;
@property(nonatomic, retain)FBSProperty  * religion;
@property(nonatomic, retain)FBSProperty  * parents;
@property(nonatomic, retain)FBSProperty  * children;
@property(nonatomic, retain)FBSProperty  * spouseS;
@property(nonatomic, retain)FBSProperty  * employmentHistory;
@property(nonatomic, retain)FBSProperty  * education;
@property(nonatomic, retain)FBSProperty  * quotations;
@property(nonatomic, retain)FBSProperty  * placesLived;
@property(nonatomic, retain)FBSProperty  * languages;
@property(nonatomic, retain)FBSProperty  * dateOfDeath;
@property(nonatomic, retain)FBSProperty  * placeOfDeath;
@property(nonatomic, retain)FBSProperty  * causeOfDeath;
@property(nonatomic, retain)FBSProperty  * worksWritten;
@property(nonatomic, retain)FBSProperty  * influencedBy;
@property(nonatomic, retain)FBSProperty  * influenced;

@end
