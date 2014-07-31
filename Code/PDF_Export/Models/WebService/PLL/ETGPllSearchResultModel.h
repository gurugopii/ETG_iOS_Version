//
//  ETGPllSearchResultModel.h
//  ETG
//
//  Created by Tan Aik Keong on 1/3/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import "JSONModel.h"
#import "ETGPllLessons.h"

@interface ETGPllSearchResultModel : JSONModel
@property (nonatomic, strong) NSString *impactDesc;
@property (nonatomic, strong) NSString *lessonDesc;
@property (nonatomic) int potentialValueConverted;
@property (nonatomic) int projectLessonDetailKey;
@property (nonatomic) int projectLessonDetailID;
@property (nonatomic, strong) NSString *projectName;
@property (nonatomic, strong) NSString *recommendationDesc;
@property (nonatomic, strong) NSString *replicateInd;
@property (nonatomic, strong) NSString *bookmarkInd;

+(id)searchResultModelFromJson:(NSDictionary *)json;
+(id)searchResultModelFromCoreDataModel:(ETGPllLessons *)coreDataModel;
-(void)updateBookmarkStatusIfRequired;

@end
