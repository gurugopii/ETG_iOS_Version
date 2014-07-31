// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGPDFMonths.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGPDFMonthsAttributes {
	__unsafe_unretained NSString *month;
	__unsafe_unretained NSString *monthId;
} ETGPDFMonthsAttributes;

extern const struct ETGPDFMonthsRelationships {
} ETGPDFMonthsRelationships;

extern const struct ETGPDFMonthsFetchedProperties {
} ETGPDFMonthsFetchedProperties;





@interface ETGPDFMonthsID : NSManagedObjectID {}
@end

@interface _ETGPDFMonths : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGPDFMonthsID*)objectID;




@property (nonatomic, strong) NSString* month;


//- (BOOL)validateMonth:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* monthId;


//- (BOOL)validateMonthId:(id*)value_ error:(NSError**)error_;






@end

@interface _ETGPDFMonths (CoreDataGeneratedAccessors)

@end

@interface _ETGPDFMonths (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveMonth;
- (void)setPrimitiveMonth:(NSString*)value;




- (NSString*)primitiveMonthId;
- (void)setPrimitiveMonthId:(NSString*)value;




@end
