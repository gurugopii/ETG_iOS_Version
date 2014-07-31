// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGPlatform.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGPlatformAttributes {
	__unsafe_unretained NSString *actualDt;
	__unsafe_unretained NSString *indicator;
	__unsafe_unretained NSString *plannedDt;
	__unsafe_unretained NSString *platform;
} ETGPlatformAttributes;

extern const struct ETGPlatformRelationships {
	__unsafe_unretained NSString *scorecard;
} ETGPlatformRelationships;

extern const struct ETGPlatformFetchedProperties {
} ETGPlatformFetchedProperties;

@class ETGScorecard;






@interface ETGPlatformID : NSManagedObjectID {}
@end

@interface _ETGPlatform : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGPlatformID*)objectID;




@property (nonatomic, strong) NSDate* actualDt;


//- (BOOL)validateActualDt:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* indicator;


//- (BOOL)validateIndicator:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDate* plannedDt;


//- (BOOL)validatePlannedDt:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* platform;


//- (BOOL)validatePlatform:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) ETGScorecard* scorecard;

//- (BOOL)validateScorecard:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGPlatform (CoreDataGeneratedAccessors)

@end

@interface _ETGPlatform (CoreDataGeneratedPrimitiveAccessors)


- (NSDate*)primitiveActualDt;
- (void)setPrimitiveActualDt:(NSDate*)value;




- (NSString*)primitiveIndicator;
- (void)setPrimitiveIndicator:(NSString*)value;




- (NSDate*)primitivePlannedDt;
- (void)setPrimitivePlannedDt:(NSDate*)value;




- (NSString*)primitivePlatform;
- (void)setPrimitivePlatform:(NSString*)value;





- (ETGScorecard*)primitiveScorecard;
- (void)setPrimitiveScorecard:(ETGScorecard*)value;


@end
