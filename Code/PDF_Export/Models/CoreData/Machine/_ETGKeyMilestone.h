// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGKeyMilestone.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGKeyMilestoneAttributes {
	__unsafe_unretained NSString *actualDate;
	__unsafe_unretained NSString *baselineNum;
	__unsafe_unretained NSString *indicator;
	__unsafe_unretained NSString *mileStone;
	__unsafe_unretained NSString *plannedDate;
} ETGKeyMilestoneAttributes;

extern const struct ETGKeyMilestoneRelationships {
	__unsafe_unretained NSString *revisions;
} ETGKeyMilestoneRelationships;

extern const struct ETGKeyMilestoneFetchedProperties {
} ETGKeyMilestoneFetchedProperties;

@class ETGRevision;







@interface ETGKeyMilestoneID : NSManagedObjectID {}
@end

@interface _ETGKeyMilestone : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGKeyMilestoneID*)objectID;




@property (nonatomic, strong) NSDate* actualDate;


//- (BOOL)validateActualDate:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* baselineNum;


@property int32_t baselineNumValue;
- (int32_t)baselineNumValue;
- (void)setBaselineNumValue:(int32_t)value_;

//- (BOOL)validateBaselineNum:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* indicator;


//- (BOOL)validateIndicator:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* mileStone;


//- (BOOL)validateMileStone:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDate* plannedDate;


//- (BOOL)validatePlannedDate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) ETGRevision* revisions;

//- (BOOL)validateRevisions:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGKeyMilestone (CoreDataGeneratedAccessors)

@end

@interface _ETGKeyMilestone (CoreDataGeneratedPrimitiveAccessors)


- (NSDate*)primitiveActualDate;
- (void)setPrimitiveActualDate:(NSDate*)value;




- (NSNumber*)primitiveBaselineNum;
- (void)setPrimitiveBaselineNum:(NSNumber*)value;

- (int32_t)primitiveBaselineNumValue;
- (void)setPrimitiveBaselineNumValue:(int32_t)value_;




- (NSString*)primitiveIndicator;
- (void)setPrimitiveIndicator:(NSString*)value;




- (NSString*)primitiveMileStone;
- (void)setPrimitiveMileStone:(NSString*)value;




- (NSDate*)primitivePlannedDate;
- (void)setPrimitivePlannedDate:(NSDate*)value;





- (ETGRevision*)primitiveRevisions;
- (void)setPrimitiveRevisions:(ETGRevision*)value;


@end
