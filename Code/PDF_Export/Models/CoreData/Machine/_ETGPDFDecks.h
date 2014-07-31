// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGPDFDecks.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGPDFDecksAttributes {
	__unsafe_unretained NSString *category;
	__unsafe_unretained NSString *dateAddedToServer;
	__unsafe_unretained NSString *fileId;
	__unsafe_unretained NSString *fileName;
	__unsafe_unretained NSString *identification;
	__unsafe_unretained NSString *isOffline;
	__unsafe_unretained NSString *reportingMonth;
	__unsafe_unretained NSString *subCategory;
	__unsafe_unretained NSString *tags;
} ETGPDFDecksAttributes;

extern const struct ETGPDFDecksRelationships {
} ETGPDFDecksRelationships;

extern const struct ETGPDFDecksFetchedProperties {
} ETGPDFDecksFetchedProperties;












@interface ETGPDFDecksID : NSManagedObjectID {}
@end

@interface _ETGPDFDecks : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGPDFDecksID*)objectID;




@property (nonatomic, strong) NSString* category;


//- (BOOL)validateCategory:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDate* dateAddedToServer;


//- (BOOL)validateDateAddedToServer:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* fileId;


//- (BOOL)validateFileId:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* fileName;


//- (BOOL)validateFileName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* identification;


//- (BOOL)validateIdentification:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* isOffline;


@property BOOL isOfflineValue;
- (BOOL)isOfflineValue;
- (void)setIsOfflineValue:(BOOL)value_;

//- (BOOL)validateIsOffline:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* reportingMonth;


//- (BOOL)validateReportingMonth:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* subCategory;


//- (BOOL)validateSubCategory:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* tags;


//- (BOOL)validateTags:(id*)value_ error:(NSError**)error_;






@end

@interface _ETGPDFDecks (CoreDataGeneratedAccessors)

@end

@interface _ETGPDFDecks (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveCategory;
- (void)setPrimitiveCategory:(NSString*)value;




- (NSDate*)primitiveDateAddedToServer;
- (void)setPrimitiveDateAddedToServer:(NSDate*)value;




- (NSString*)primitiveFileId;
- (void)setPrimitiveFileId:(NSString*)value;




- (NSString*)primitiveFileName;
- (void)setPrimitiveFileName:(NSString*)value;




- (NSString*)primitiveIdentification;
- (void)setPrimitiveIdentification:(NSString*)value;




- (NSNumber*)primitiveIsOffline;
- (void)setPrimitiveIsOffline:(NSNumber*)value;

- (BOOL)primitiveIsOfflineValue;
- (void)setPrimitiveIsOfflineValue:(BOOL)value_;




- (NSString*)primitiveReportingMonth;
- (void)setPrimitiveReportingMonth:(NSString*)value;




- (NSString*)primitiveSubCategory;
- (void)setPrimitiveSubCategory:(NSString*)value;




- (NSString*)primitiveTags;
- (void)setPrimitiveTags:(NSString*)value;




@end
