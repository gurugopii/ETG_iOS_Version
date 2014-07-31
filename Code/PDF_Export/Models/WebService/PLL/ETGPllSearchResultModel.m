//
//  ETGPllSearchResultModel.m
//  ETG
//
//  Created by Tan Aik Keong on 1/3/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import "ETGPllSearchResultModel.h"
#import "ETGPllModelController.h"

@implementation ETGPllSearchResultModel

+(id)searchResultModelFromJson:(NSDictionary *)json
{
    ETGPllSearchResultModel *model = [ETGPllSearchResultModel new];
    
    for(NSString *key in json)
    {
        if([key isEqualToString:@"potentialValueConverted"] || [key isEqualToString:@"projectLessonDetailKey"] || [key isEqualToString:@"projectLessonDetailID"])
        {
            [model setValue:[self resetToZeroIfRequire:json[key]] forKey:key];
        }
        else
        {
            [model setValue:[self resetToEmptyStringIfRequire:json[key]] forKey:key];
        }
    }
    
    model.bookmarkInd = [ETGPllModelController getBookmarkInd:model.projectLessonDetailKey];
    
    return model;
}

+(NSNumber *)resetToZeroIfRequire:(id)input
{
    if(input == (id)[NSNull null])
    {
        return @(0);
    }
    else
    {
        return input;
    }
}

+(NSString *)resetToEmptyStringIfRequire:(id)input
{
    if(input == (id)[NSNull null])
    {
        input = @"";
    }
    return input;
}

-(void)updateBookmarkStatusIfRequired
{
    self.bookmarkInd = [ETGPllModelController getBookmarkInd:self.projectLessonDetailKey];
}

+(id)searchResultModelFromCoreDataModel:(ETGPllLessons *)coreDataModel
{
    ETGPllSearchResultModel *model = [ETGPllSearchResultModel new];
    model.impactDesc = [ETGPllSearchResultModel truncateString:coreDataModel.impactDesc];
    model.lessonDesc = [ETGPllSearchResultModel truncateString:coreDataModel.lessonDesc];
    model.potentialValueConverted = [coreDataModel.potentialValueConverted doubleValue];
    model.projectLessonDetailKey = [coreDataModel.projectLessonDetailKey integerValue];
    model.projectName = coreDataModel.projectName;
    model.recommendationDesc = [ETGPllSearchResultModel truncateString:coreDataModel.recommendationDesc];
    model.replicateInd = coreDataModel.replicateInd;
    model.bookmarkInd = [ETGPllModelController getBookmarkInd:model.projectLessonDetailKey];
    return model;
}

+(NSString *)truncateString:(NSString *)input
{
    // define the range you're interested in
    NSRange stringRange = {0, MIN([input length], 100)};
    
    // adjust the range to include dependent chars
    stringRange = [input rangeOfComposedCharacterSequencesForRange:stringRange];
    
    // Now you can create the short string
    return [input substringWithRange:stringRange];
}

@end
