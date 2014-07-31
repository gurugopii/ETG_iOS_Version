//
//  ETGPDFModelController.h
//  PDF_Export
//
//  Created by macmini01.sf.dev on 10/8/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETGPDFModelController : NSObject

#pragma mark - Model Controller Class methods
+ (instancetype)sharedModel;

@property (nonatomic, strong) NSMutableArray *uniqueCategories;
@property (nonatomic, strong) NSArray *decks;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) NSString *pdfFilePathInUse;
@property (nonatomic) BOOL isDownloadingDecks;
@property (nonatomic) BOOL isDownloadingCategories;

#pragma mark - Web service accessors
- (void) getDecksWebServiceData;
- (void) getCategoriesServiceData;

#pragma mark - Core Data Accessors

-(NSArray *) findSubCategoryWithIndexPathSection:(NSInteger)section;
-(NSArray *) findDecksWithCategory: (NSString *)category
                    andSubCategory: (NSString *)subCategory;
-(NSArray *) findDecksWithReportingMonth:(NSString *)reportingMonth;

-(void) getCategories;
-(NSMutableArray *) getMonths;
-(NSArray *) getDecks;
-(NSArray *) getRecentDecks;


-(NSString *) checkIfFileExistsWithDecks:(NSArray *)decks
                                      andArrayIndex:(int)index;
-(NSString *) getFilePathInDocumentsPDFDirectory:(NSArray *)decks andArrayIndex:(int)index;
-(NSString *) getFilePathInCacheDirectory:(NSArray *)decks andArrayIndex:(int)index;
-(NSString *) getFilePathInCacheTempDirectory:(NSArray *)decks andArrayIndex:(int)index;
-(NSString *) getFilePathForReadInCacheTempDirectory;

-(NSString *) checkDestPathWithOriginPath:(NSString *)originPath;
-(BOOL) isFileAvailableOffline:(NSString *)filePath;

-(NSMutableArray *) loadRecentlyViewedImagesThroughRecentDecks:(NSArray *)recentDecks;

-(void) downloadPdfFileWithIndexPath:(NSIndexPath *)indexPath decksArray:(NSArray *)decks andFilePath:(NSString *)filePath;
-(void)downloadPdfFileWithIndexPath:(NSIndexPath *)indexPath
                          decksArray:(NSArray *)decks
                         andFilePath:(NSString *)filePath
                             success:(void (^)(bool done))success
                             failure:(void (^)(NSError *error))failure;

-(NSMutableArray *) displaySlidePerDeckWithIndexPath:(NSIndexPath *) indexPath
                                          decksArray:(NSArray *) decks
                                         andFilePath:(NSString *)filePath;

-(void) updateDecksForOfflineUseWithFileId:(NSString *)fileId;
-(UIImage *) checkDownloadButtonImageWithDecksArray:(NSArray *)decks andArrayIndex:(int)index;

-(NSArray *) searchCategoriesForPDFFilesWithSearchParameters:(NSString *)searchBarText;


-(NSString *) getCategoryForLongTapGestureWithRecentDecks:(NSArray *)recentDecks
                                            andArrayIndex:(int)index;

@end
