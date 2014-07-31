// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGWellDetails.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGWellDetailsAttributes {
	__unsafe_unretained NSString *condyIndicator;
	__unsafe_unretained NSString *condyOutlook;
	__unsafe_unretained NSString *condyPlanned;
	__unsafe_unretained NSString *dataTimeKey;
	__unsafe_unretained NSString *gasIndicator;
	__unsafe_unretained NSString *gasOutlook;
	__unsafe_unretained NSString *gasPlanned;
	__unsafe_unretained NSString *oilIndicator;
	__unsafe_unretained NSString *oilOutlook;
	__unsafe_unretained NSString *oilPlanned;
	__unsafe_unretained NSString *rtbdIndicator;
	__unsafe_unretained NSString *rtbdOutlook;
	__unsafe_unretained NSString *rtbdPlanned;
	__unsafe_unretained NSString *sort;
	__unsafe_unretained NSString *wellName;
} ETGWellDetailsAttributes;

extern const struct ETGWellDetailsRelationships {
	__unsafe_unretained NSString *facility;
} ETGWellDetailsRelationships;

extern const struct ETGWellDetailsFetchedProperties {
} ETGWellDetailsFetchedProperties;

@class ETGFacility;

















@interface ETGWellDetailsID : NSManagedObjectID {}
@end

@interface _ETGWellDetails : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGWellDetailsID*)objectID;




@property (nonatomic, strong) NSString* condyIndicator;


//- (BOOL)validateCondyIndicator:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* condyOutlook;


@property double condyOutlookValue;
- (double)condyOutlookValue;
- (void)setCondyOutlookValue:(double)value_;

//- (BOOL)validateCondyOutlook:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* condyPlanned;


@property double condyPlannedValue;
- (double)condyPlannedValue;
- (void)setCondyPlannedValue:(double)value_;

//- (BOOL)validateCondyPlanned:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* dataTimeKey;


//- (BOOL)validateDataTimeKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* gasIndicator;


//- (BOOL)validateGasIndicator:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* gasOutlook;


@property double gasOutlookValue;
- (double)gasOutlookValue;
- (void)setGasOutlookValue:(double)value_;

//- (BOOL)validateGasOutlook:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* gasPlanned;


@property double gasPlannedValue;
- (double)gasPlannedValue;
- (void)setGasPlannedValue:(double)value_;

//- (BOOL)validateGasPlanned:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* oilIndicator;


//- (BOOL)validateOilIndicator:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* oilOutlook;


@property double oilOutlookValue;
- (double)oilOutlookValue;
- (void)setOilOutlookValue:(double)value_;

//- (BOOL)validateOilOutlook:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* oilPlanned;


@property double oilPlannedValue;
- (double)oilPlannedValue;
- (void)setOilPlannedValue:(double)value_;

//- (BOOL)validateOilPlanned:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* rtbdIndicator;


//- (BOOL)validateRtbdIndicator:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* rtbdOutlook;


@property double rtbdOutlookValue;
- (double)rtbdOutlookValue;
- (void)setRtbdOutlookValue:(double)value_;

//- (BOOL)validateRtbdOutlook:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* rtbdPlanned;


@property double rtbdPlannedValue;
- (double)rtbdPlannedValue;
- (void)setRtbdPlannedValue:(double)value_;

//- (BOOL)validateRtbdPlanned:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* sort;


@property int32_t sortValue;
- (int32_t)sortValue;
- (void)setSortValue:(int32_t)value_;

//- (BOOL)validateSort:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* wellName;


//- (BOOL)validateWellName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) ETGFacility* facility;

//- (BOOL)validateFacility:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGWellDetails (CoreDataGeneratedAccessors)

@end

@interface _ETGWellDetails (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveCondyIndicator;
- (void)setPrimitiveCondyIndicator:(NSString*)value;




- (NSNumber*)primitiveCondyOutlook;
- (void)setPrimitiveCondyOutlook:(NSNumber*)value;

- (double)primitiveCondyOutlookValue;
- (void)setPrimitiveCondyOutlookValue:(double)value_;




- (NSNumber*)primitiveCondyPlanned;
- (void)setPrimitiveCondyPlanned:(NSNumber*)value;

- (double)primitiveCondyPlannedValue;
- (void)setPrimitiveCondyPlannedValue:(double)value_;




- (NSString*)primitiveDataTimeKey;
- (void)setPrimitiveDataTimeKey:(NSString*)value;




- (NSString*)primitiveGasIndicator;
- (void)setPrimitiveGasIndicator:(NSString*)value;




- (NSNumber*)primitiveGasOutlook;
- (void)setPrimitiveGasOutlook:(NSNumber*)value;

- (double)primitiveGasOutlookValue;
- (void)setPrimitiveGasOutlookValue:(double)value_;




- (NSNumber*)primitiveGasPlanned;
- (void)setPrimitiveGasPlanned:(NSNumber*)value;

- (double)primitiveGasPlannedValue;
- (void)setPrimitiveGasPlannedValue:(double)value_;




- (NSString*)primitiveOilIndicator;
- (void)setPrimitiveOilIndicator:(NSString*)value;




- (NSNumber*)primitiveOilOutlook;
- (void)setPrimitiveOilOutlook:(NSNumber*)value;

- (double)primitiveOilOutlookValue;
- (void)setPrimitiveOilOutlookValue:(double)value_;




- (NSNumber*)primitiveOilPlanned;
- (void)setPrimitiveOilPlanned:(NSNumber*)value;

- (double)primitiveOilPlannedValue;
- (void)setPrimitiveOilPlannedValue:(double)value_;




- (NSString*)primitiveRtbdIndicator;
- (void)setPrimitiveRtbdIndicator:(NSString*)value;




- (NSNumber*)primitiveRtbdOutlook;
- (void)setPrimitiveRtbdOutlook:(NSNumber*)value;

- (double)primitiveRtbdOutlookValue;
- (void)setPrimitiveRtbdOutlookValue:(double)value_;




- (NSNumber*)primitiveRtbdPlanned;
- (void)setPrimitiveRtbdPlanned:(NSNumber*)value;

- (double)primitiveRtbdPlannedValue;
- (void)setPrimitiveRtbdPlannedValue:(double)value_;




- (NSNumber*)primitiveSort;
- (void)setPrimitiveSort:(NSNumber*)value;

- (int32_t)primitiveSortValue;
- (void)setPrimitiveSortValue:(int32_t)value_;




- (NSString*)primitiveWellName;
- (void)setPrimitiveWellName:(NSString*)value;





- (ETGFacility*)primitiveFacility;
- (void)setPrimitiveFacility:(ETGFacility*)value;


@end
