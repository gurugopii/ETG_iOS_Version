//
//  ETGPllLessonModel.h
//  ETG
//
//  Created by Tan Aik Keong on 1/2/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import "JSONModel.h"
#import "ETGPllLessons.h"

@interface ETGPllLessonModel : JSONModel
@property (nonatomic, strong) NSString *usdRate;
@property (nonatomic, strong) NSString *activity;
@property (nonatomic, strong) NSString *approvalStatus;
@property (nonatomic, strong) NSString *areaName;
@property (nonatomic, strong) NSString *baselineDesc;
@property (nonatomic, strong) NSString *causeDesc;
@property (nonatomic, strong) NSDate *createDttm;
@property (nonatomic, strong) NSString *createUserId;
@property (nonatomic, strong) NSString *currencyName;
@property (nonatomic, strong) NSString *disciplineName;
@property (nonatomic, strong) NSString *impactDesc;
@property (nonatomic, strong) NSString *lessonDesc;
@property (nonatomic) double potentialValue;
@property (nonatomic, strong) NSString *potentialValueBasis;
@property (nonatomic) double potentialValueConverted;
@property (nonatomic) int  projectLessonDetailKey;
@property (nonatomic, strong) NSString *projectLessonImpactNm;
@property (nonatomic, strong) NSString *projectLessonRatingNm;
@property (nonatomic, strong) NSString *projectName;
@property (nonatomic, strong) NSString *recommendationDesc;
@property (nonatomic, strong) NSString *replicateInd;
@property (nonatomic, strong) NSString *reviewItemName;
@property (nonatomic, strong) NSString *riskCategoryName;
@property (nonatomic) int totalLikeNo;
@property (nonatomic, strong) NSDate *updateDttm;
@property (nonatomic, strong) NSString *updateUserId;
@property (nonatomic, strong) NSString *bookmarkInd;

+(id)pllLessonFromJson:(NSDictionary *)json;
+(id)pllLessonFromCoreData:(ETGPllLessons *)coreDataModel;
-(ETGPllLessons *)updateCoreDataModel:(ETGPllLessons *)coreDataModel;
-(NSString *)getJsonString;
@end
