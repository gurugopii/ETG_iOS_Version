// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGHseScorecard.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGHseScorecardAttributes {
	__unsafe_unretained NSString *indicator;
	__unsafe_unretained NSString *ytdCriteria;
	__unsafe_unretained NSString *ytdCriteriaValue;
} ETGHseScorecardAttributes;

extern const struct ETGHseScorecardRelationships {
	__unsafe_unretained NSString *scorecard;
} ETGHseScorecardRelationships;

extern const struct ETGHseScorecardFetchedProperties {
} ETGHseScorecardFetchedProperties;

@class ;





@interface ETGHseScorecardID : NSManagedObjectID {}
@end

@interface _ETGHseScorecard : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGHseScorecardID*)objectID;





@property (nonatomic, strong) NSString* indicator;



//- (BOOL)validateIndicator:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* ytdCriteria;



//- (BOOL)validateYtdCriteria:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* ytdCriteriaValue;



//- (BOOL)validateYtdCriteriaValue:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong)  *scorecard;

//- (BOOL)validateScorecard:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGHseScorecard (CoreDataGeneratedAccessors)

@end

@interface _ETGHseScorecard (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveIndicator;
- (void)setPrimitiveIndicator:(NSString*)value;




- (NSString*)primitiveYtdCriteria;
- (void)setPrimitiveYtdCriteria:(NSString*)value;




- (NSString*)primitiveYtdCriteriaValue;
- (void)setPrimitiveYtdCriteriaValue:(NSString*)value;





- (*)primitiveScorecard;
- (void)setPrimitiveScorecard:(*)value;


@end
