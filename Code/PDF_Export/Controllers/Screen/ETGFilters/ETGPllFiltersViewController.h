//
//  ETGPllFiltersViewViewController.h
//  ETG
//
//  Created by Tan Aik Keong on 1/2/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import "ETGFiltersViewController.h"

enum section {
    kCOUNTRY,
    kREGION,
    kCLUSTER,
    kPROJECTTYPE,
    kPROJECTNATURE,
    kCOMPLEXITY,
    KPROJECT,
};

enum lessonLearnSection {
    kREVIEW,
    kIMPACTLEVELS,
    kPRAELEMENTS,
    kLESSONRATING,
    kPPMSACTIVITY,
    kAREA,
    kDISCIPLINE,
    kLESSONVALUE,
};

@class ETGPllFiltersViewController;

@protocol ETGPllFitersViewControllerDelegate
- (void)filtersviewControllerDidDismiss:(NSArray *)selectedRowsInProjectFilter lessonLearnFilter:(NSArray *)selectedRowsInLessonLearntFilter;
- (void)filtersViewControllerDidFinishWithProjectSectionInfo:(NSArray *)projectSectionInfo andLessonLearnSessionInfo:(NSArray *)lessonLearntSessionInfo filterViewController:(ETGPllFiltersViewController *)filterViewController;
@end

@interface ETGPllFiltersViewController : ETGFiltersViewController
@property (weak, nonatomic) id<ETGFiltersViewControllerDelegate, ETGPllFitersViewControllerDelegate> delegate;
@property (nonatomic) NSArray *selectedRowsInProjectFilter;
@property (nonatomic) NSArray *selectedRowsInLessonLearntFilter;
@property (nonatomic, strong) NSString *selectedProjectKey;
@property (nonatomic, strong) NSString *selectedPllReviewKey;

+(NSArray *)getSelectedRowsFromSectionInfo:(ETGSectionInfo *)inputSectionInfo;
-(NSArray *)getDisciplineSelectedRowsFromSectionInfo:(ETGSectionInfo *)inputSectionInfo;
@end
