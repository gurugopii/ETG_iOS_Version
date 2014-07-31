// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGWpb.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGWpbAttributes {
	__unsafe_unretained NSString *abrApproved;
	__unsafe_unretained NSString *abrSubmitted;
	__unsafe_unretained NSString *indicator;
	__unsafe_unretained NSString *reportingDate;
} ETGWpbAttributes;

extern const struct ETGWpbRelationships {
	__unsafe_unretained NSString *portfolio;
} ETGWpbRelationships;

extern const struct ETGWpbFetchedProperties {
} ETGWpbFetchedProperties;

@class ETGPortfolio;






@interface ETGWpbID : NSManagedObjectID {}
@end

@interface _ETGWpb : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGWpbID*)objectID;




@property (nonatomic, strong) NSDecimalNumber* abrApproved;


//- (BOOL)validateAbrApproved:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* abrSubmitted;


//- (BOOL)validateAbrSubmitted:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* indicator;


//- (BOOL)validateIndicator:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDate* reportingDate;


//- (BOOL)validateReportingDate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) ETGPortfolio* portfolio;

//- (BOOL)validatePortfolio:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGWpb (CoreDataGeneratedAccessors)

@end

@interface _ETGWpb (CoreDataGeneratedPrimitiveAccessors)


- (NSDecimalNumber*)primitiveAbrApproved;
- (void)setPrimitiveAbrApproved:(NSDecimalNumber*)value;




- (NSDecimalNumber*)primitiveAbrSubmitted;
- (void)setPrimitiveAbrSubmitted:(NSDecimalNumber*)value;




- (NSString*)primitiveIndicator;
- (void)setPrimitiveIndicator:(NSString*)value;




- (NSDate*)primitiveReportingDate;
- (void)setPrimitiveReportingDate:(NSDate*)value;





- (ETGPortfolio*)primitivePortfolio;
- (void)setPrimitivePortfolio:(ETGPortfolio*)value;


@end
