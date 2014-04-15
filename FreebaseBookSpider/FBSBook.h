//
//  FBSBook.h
//  FreebaseBookSpider
//
//  Created by Raffaele Bua on 10/04/14.
//  Copyright (c) 2014 Buele. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBSBook : NSObject

-(id)initWithId:(NSString* )id andName:(NSString *)name andProperties:(NSDictionary *)properties;

@property(nonatomic)NSString * id;
@property(nonatomic)NSString * name;
@property(nonatomic)NSString * alias;                   // /common/topic/alias
@property(nonatomic)NSString * description;             // /common/topic/description
@property(nonatomic)NSString * imageId;                 // /common/topic/image
@property(nonatomic)UIImage  * image;
@property(nonatomic)NSArray  * genre;                   // /book/book/genre
@property(nonatomic)NSArray  * characters;              // /book/book/characters
@property(nonatomic)NSArray  * quotations;              // /media_common/quotation_source/quotations
@property(nonatomic)NSArray  * author;                  // /book/written_work/author
@property(nonatomic)NSDate   * dateWritten;             // /book/written_work/date_written
@property(nonatomic)NSDate   * copyrightDate;           // /book/written_work/copyright_date
@property(nonatomic)NSDate   * dateOfFirstPubblication; // /book/written_work/date_of_first_pubblication
@property(nonatomic)NSArray  * subjects;                // /book/written_work/subjects
@property(nonatomic)NSArray  * originalLanguage;        // /book/written_work/original_language
@property(nonatomic)NSArray  * previousInSeries;        // /book/written_work/previous_in_series
@property(nonatomic)NSArray  * isfdbId;                 // /book/written_work/isfdb_id
@property(nonatomic)NSArray  * nextInSeries;            // /book/written_work/next_in_series
@property(nonatomic)NSArray  * influencedBy;            // /influence/influence_node/influenced_by
@property(nonatomic)NSArray  * influenced;              // /influence/influence_node/influenced

@end
