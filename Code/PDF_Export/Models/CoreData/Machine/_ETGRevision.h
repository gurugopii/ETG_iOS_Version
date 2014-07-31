// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGRevision.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGRevisionAttributes {
	__unsafe_unretained NSString *number;
} ETGRevisionAttributes;

extern const struct ETGRevisionRelationships {
	__unsafe_unretained NSString *baselinetype;
	__unsafe_unretained NSString *keyMilestones;
} ETGRevisionRelationships;

extern const struct ETGRevisionFetchedProperties {
} ETGRevisionFetchedProperties;

@class ETGBaselineType;
@class ETGKeyMilestone;



@interface ETGRevisionID : NSManagedObjectID {}
@end

@interface _ETGRevision : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGRevisionID*)objectID;




@property (nonatomic, strong) NSNumber* number;


@property int32_t numberValue;
- (int32_t)numberValue;
- (void)setNumberValue:(int32_t)value_;

//- (BOOL)validateNumber:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) ETGBaselineType* baselinetype;

//- (BOOL)validateBaselinetype:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet* keyMilestones;

- (NSMutableSet*)keyMilestonesSet;





@end

@interface _ETGRevision (CoreDataGeneratedAccessors)

- (void)addKeyMilestones:(NSSet*)value_;
- (void)removeKeyMilestones:(NSSet*)value_;
- (void)addKeyMilestonesObject:(ETGKeyMilestone*)value_;
- (void)removeKeyMilestonesObject:(ETGKeyMilestone*)value_;

@end

@interface _ETGRevision (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveNumber;
- (void)setPrimitiveNumber:(NSNumber*)value;

- (int32_t)primitiveNumberValue;
- (void)setPrimitiveNumberValue:(int32_t)value_;





- (ETGBaselineType*)primitiveBaselinetype;
- (void)setPrimitiveBaselinetype:(ETGBaselineType*)value;



- (NSMutableSet*)primitiveKeyMilestones;
- (void)setPrimitiveKeyMilestones:(NSMutableSet*)value;


@end
