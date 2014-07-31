//
//  ETGPllLessonModel.m
//  ETG
//
//  Created by Tan Aik Keong on 1/2/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import "ETGPllLessonModel.h"
#import "ETGPllModelController.h"
#import "ETGJsonHelper.h"
#import "Constants.h"

@implementation ETGPllLessonModel
+(id)pllLessonFromJson:(NSDictionary *)json
{
    ETGPllLessonModel *model = [ETGPllLessonModel new];

    @try
    {
        for(NSString *key in json)
        {
            if([key isEqualToString:@"USDRate"])
            {
                model.usdRate = [ETGJsonHelper resetToEmptyStringIfRequired:json[key]];
            }
            else if([key isEqualToString:@"currencyName"])
            {
                [model setValue:[ETGJsonHelper resetToEmptyStringIfRequired:json[key]] forKey:key];
            }
            else if([key isEqualToString:@"approvalStatus"])
            {
                [model setValue:[ETGJsonHelper resetToNaIfRequired:json[key]] forKey:key];
            }
            else if([key isEqualToString:@"totalLikeNo"])
            {
                if(json[key] == (id)[NSNull null])
                {
                    model.totalLikeNo = 0;
                }
                else
                {
                    model.totalLikeNo = [json[key] integerValue];
                }
            }
            else if([key isEqualToString:@"potentialValue"])
            {
                if(json[key] == (id)[NSNull null])
                {
                    model.potentialValue = 0;
                }
                else
                {
                    model.potentialValue = [json[key] doubleValue];
                }
            }
            else if([key isEqualToString:@"potentialValueConverted"])
            {
                if(json[key] == (id)[NSNull null])
                {
                    model.potentialValueConverted = 0;
                }
                else
                {
                    model.potentialValueConverted = [json[key] doubleValue];
                }
            }
            else if([key isEqualToString:@"createDttm"] || [key isEqualToString:@"updateDttm"])
            {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX."]];
                [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                [formatter setTimeZone:[NSTimeZone systemTimeZone]];
                NSDate *date = [formatter dateFromString:json[key]];
                [model setValue:date forKey:key];
            }
            else
            {
                [model setValue:[ETGJsonHelper resetToNilIfRequired:json[key]] forKey:key];
            }
        }
    }
    @catch (NSException *exception)
    {
        DDLogError(@"%@%@", newFieldOrFieldNameChangedError, exception.reason);
    }
    
    if([ETGPllModelController isBookmark:model.projectLessonDetailKey])
    {
        model.bookmarkInd = @"Y";
    }
    else
    {
        model.bookmarkInd = @"N";
    }
    
    return model;
}

+(id)pllLessonFromCoreData:(ETGPllLessons *)coreDataModel
{
    ETGPllLessonModel *model = [ETGPllLessonModel new];
    model.usdRate = coreDataModel.usdRate;
    model.activity = coreDataModel.activity;
    model.approvalStatus = coreDataModel.approvalStatus;
    model.areaName = coreDataModel.areaName;
    model.baselineDesc = coreDataModel.baselineDesc;
    model.causeDesc = coreDataModel.causeDesc;
    model.createDttm = coreDataModel.createDttm;
    model.createUserId = coreDataModel.createUserId;
    model.currencyName = coreDataModel.currencyName;
    model.disciplineName = coreDataModel.disciplineName;
    model.impactDesc = coreDataModel.impactDesc;
    model.lessonDesc = coreDataModel.lessonDesc;
    model.potentialValue = [coreDataModel.potentialValue doubleValue];
    model.potentialValueConverted = [coreDataModel.potentialValueConverted doubleValue];
    model.potentialValueBasis = coreDataModel.potentialValueBasis;
    model.projectLessonDetailKey = [coreDataModel.projectLessonDetailKey integerValue];
    model.projectLessonImpactNm = coreDataModel.projectLessonImpactNm;
    model.projectLessonRatingNm = coreDataModel.projectLessonRatingNm;
    model.projectName = coreDataModel.projectName;
    model.recommendationDesc = coreDataModel.recommendationDesc;
    model.replicateInd = coreDataModel.replicateInd;
    model.reviewItemName = coreDataModel.reviewItemName;
    model.riskCategoryName = coreDataModel.riskCategoryName;
    model.totalLikeNo = [coreDataModel.totalLikeNo integerValue];
    model.updateDttm = coreDataModel.updateDttm;
    model.updateUserId = coreDataModel.updateUserId;
    model.bookmarkInd = [ETGPllModelController getBookmarkInd:model.projectLessonDetailKey];
    return model;
}

-(ETGPllLessons *)updateCoreDataModel:(ETGPllLessons *)coreDataModel
{
    if([self.usdRate isKindOfClass:[NSNumber class]])
    {
        NSNumber *num = (NSNumber *)self.usdRate;
        coreDataModel.usdRate = [num stringValue];
    }
    else
    {
        coreDataModel.usdRate = self.usdRate;
    }
    
    coreDataModel.approvalStatus = self.approvalStatus;
    coreDataModel.activity = self.activity;
    coreDataModel.areaName = self.areaName;
    coreDataModel.baselineDesc = self.baselineDesc;
    coreDataModel.causeDesc = self.causeDesc;
    coreDataModel.createDttm = self.createDttm;
    coreDataModel.createUserId = self.createUserId;
    coreDataModel.currencyName = self.currencyName;
    coreDataModel.disciplineName = self.disciplineName;
    coreDataModel.impactDesc = self.impactDesc;
    coreDataModel.lessonDesc = self.lessonDesc;
    coreDataModel.potentialValue = [NSNumber numberWithDouble:self.potentialValue];
    coreDataModel.potentialValueConverted = [NSNumber numberWithDouble:self.potentialValueConverted];
    coreDataModel.potentialValueBasis = self.potentialValueBasis;
    coreDataModel.projectLessonDetailKey = [NSNumber numberWithInt:self.projectLessonDetailKey];
    coreDataModel.projectLessonImpactNm = self.projectLessonImpactNm;
    coreDataModel.projectLessonRatingNm = self.projectLessonRatingNm;
    coreDataModel.projectName = self.projectName;
    coreDataModel.recommendationDesc = self.recommendationDesc;
    coreDataModel.replicateInd = self.replicateInd;
    coreDataModel.reviewItemName = self.reviewItemName;
    coreDataModel.riskCategoryName = self.riskCategoryName;
    coreDataModel.totalLikeNo = [NSNumber numberWithInt:self.totalLikeNo];
    coreDataModel.updateDttm = self.updateDttm;
    coreDataModel.updateUserId = self.updateUserId;
    return coreDataModel;
}

-(NSString *)getJsonString
{
    NSMutableDictionary *dictionary = [[self toDictionary] mutableCopy];
    //NSDateFormatter *formatter = [NSDateFormatter new];
    //[formatter setDateFormat:@"yyyy-MM-dd hh:mm a"];
    //dictionary[@"createDttm"]  = [formatter stringFromDate:self.createDttm];
    //dictionary[@"updateDttm"] = [formatter stringFromDate:self.updateDttm];
    //NSString *potentialValue = [NSString stringWithFormat:@"%.2f", self.potentialValue];
    //dictionary[@"potentialValue"] = potentialValue;
    dictionary[@"createDttm"]  = @([self.createDttm timeIntervalSince1970]);
    dictionary[@"updateDttm"] = @([self.updateDttm timeIntervalSince1970]);
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

@end
