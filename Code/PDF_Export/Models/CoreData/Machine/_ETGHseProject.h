// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGHseProject.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGHseProjectAttributes {
	__unsafe_unretained NSString *totalManHour;
} ETGHseProjectAttributes;

extern const struct ETGHseProjectRelationships {
	__unsafe_unretained NSString *projectSummary;
} ETGHseProjectRelationships;

extern const struct ETGHseProjectFetchedProperties {
} ETGHseProjectFetchedProperties;

@class ETGProjectSummary;



@interface ETGHseProjectID : NSManagedObjectID {}
@end

@interface _ETGHseProject : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGHseProjectID*)objectID;




@property (nonatomic, strong) NSNumber* totalManHour;


@property int32_t totalManHourValue;
- (int32_t)totalManHourValue;
- (void)setTotalManHourValue:(int32_t)value_;

//- (BOOL)validateTotalManHour:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) ETGProjectSummary* projectSummary;

//- (BOOL)validateProjectSummary:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGHseProject (CoreDataGeneratedAccessors)

@end

@interface _ETGHseProject (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveTotalManHour;
- (void)setPrimitiveTotalManHour:(NSNumber*)value;

- (int32_t)primitiveTotalManHourValue;
- (void)setPrimitiveTotalManHourValue:(int32_t)value_;





- (ETGProjectSummary*)primitiveProjectSummary;
- (void)setPrimitiveProjectSummary:(ETGProjectSummary*)value;


@end
