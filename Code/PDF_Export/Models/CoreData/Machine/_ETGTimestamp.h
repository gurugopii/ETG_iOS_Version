// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGTimestamp.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGTimestampAttributes {
	__unsafe_unretained NSString *moduleName;
	__unsafe_unretained NSString *timeStamp;
} ETGTimestampAttributes;

extern const struct ETGTimestampRelationships {
	__unsafe_unretained NSString *reportingMonth;
} ETGTimestampRelationships;

extern const struct ETGTimestampFetchedProperties {
} ETGTimestampFetchedProperties;

@class ETGReportingMonth;




@interface ETGTimestampID : NSManagedObjectID {}
@end

@interface _ETGTimestamp : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGTimestampID*)objectID;




@property (nonatomic, strong) NSString* moduleName;


//- (BOOL)validateModuleName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDate* timeStamp;


//- (BOOL)validateTimeStamp:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) ETGReportingMonth* reportingMonth;

//- (BOOL)validateReportingMonth:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGTimestamp (CoreDataGeneratedAccessors)

@end

@interface _ETGTimestamp (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveModuleName;
- (void)setPrimitiveModuleName:(NSString*)value;




- (NSDate*)primitiveTimeStamp;
- (void)setPrimitiveTimeStamp:(NSDate*)value;





- (ETGReportingMonth*)primitiveReportingMonth;
- (void)setPrimitiveReportingMonth:(ETGReportingMonth*)value;


@end
