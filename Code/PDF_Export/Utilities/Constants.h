//
//  Constants.h
//  PDF_Export
//
//  Created by Mendoza, Christine D. on 9/11/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

//test
//#define kBaseURL @"https://pcsb-elevatetogo-test.petronas.com.my:8088"
//#define kPortfolioService @"/TestElevateToGoWebService/PortfolioPerformance.svc"
//#define kProjectService @"/TestElevateToGoWebService/ProjectPerformance.svc"
//#define kPllService @"/TestElevateToGoWebService/Pll.svc"
//#define kMapService @"/TestElevateToGoWebService/Map.svc"
//#define kEccrService @"/TestElevateToGoWebService/ECCR.svc"
//#define kMasterService @"/TestElevateToGoWebService/Master.svc"
//#define kManPowerService @"/TestElevateToGoWebService/Manpower.svc"

//pilot
#define kBaseURL @"https://pcsb-elevatetogo-pilot.petronas.com.my:8088"
#define kPortfolioService @"/ElevateToGoWebService/PortfolioPerformance.svc"
#define kProjectService @"/ElevateToGoWebService/ProjectPerformance.svc"
#define kPllService @"/ElevateToGoWebService/Pll.svc"
#define kMapService @"/ElevateToGoWebService/Map.svc"
#define kEccrService @"/ElevateToGoWebService/ECCR.svc"
#define kMasterService @"/ElevateToGoWebService/Master.svc"
#define kManPowerService @"/ElevateToGoWebService/Manpower.svc"

//manpower
//#define kBaseURL @"https://pcsb-elevatetogo-test.petronas.com.my:8088"
//#define kPortfolioService @"/PilotElevateToGoWebService/PortfolioPerformance.svc"
//#define kProjectService @"/PilotElevateToGoWebService/ProjectPerformance.svc"
//#define kPllService @"/PilotElevateToGoWebService/Pll.svc"
//#define kMapService @"/PilotElevateToGoWebService/Map.svc"
//#define kEccrService @"/PilotElevateToGoWebService/ECCR.svc"
//#define kMasterService @"/PilotElevateToGoWebService/Master.svc"
//#define kManPowerService @"/PilotElevateToGoWebService/Manpower.svc"

//NEW Web methods
#define kAuthenticateEtgUser @"/Authenticate"
#define kGetETGDashboard @"/Dashboard"
#define kFilters @"/Filter"
#define kWelcomeImages @"/WelcomeScreen"

#define ETG_PORTFOLIO_APC_PATH @"/APC"
#define ETG_PORTFOLIO_CPB_PATH @"/CPB"
#define ETG_PORTFOLIO_HSE_PATH @"/HSE"
#define ETG_PORTFOLIO_ML_PATH @"/ML"
#define ETG_PORTFOLIO_HYDROCARBON_PATH @"/FirstHydrocarbon"
#define ETG_PORTFOLIO_PRODUCTIONRTBD_PATH @"/ProductionRTBD"
#define ETG_PORTFOLIO_WPB_PATH @"/WPBABRGovernance"
#define ETG_PORTFOLIO_PATH @"/PortDash_FirstHydrocarbon"

#define ETG_DOWNLOAD_MCDECK_PATH @"/LibraryDownload"
#define ETG_MCDECK_METADATA_PATH @"/LibrarySummary"
#define ETG_BASIC_FILLERS_PATH @"/LibraryListByCategoryAndMonth"

#define ETG_PROJECT_PATH @"/AllProject"

#define ETG_PLL_LESSONS_COUNT @"/PLLLessonsCount"
#define ETG_PLL_LESSON @"/PLLLesson"
#define ETG_PLL_SEARCH_AND_FILTER @"/PLLSearchandFilter"
#define ETG_PLL_BASE_FILTERS @"/PLLBaseFilters"

#define ETG_MANPOWER_FILTER @"/Filter"
#define ETG_MANPOWER_AVERAGE_HEAD_COUNT @"/AHC"
#define ETG_MANPOWER_HEADCOUNT_REQUIRED @"/PNECHCR"
#define ETG_MANPOWER_LOADING_REQUIRED @"/PLR"

#define ETG_MAP_PGD_PEM @"/MapsPGDandPEM"
#define ETG_MAP_KEY_MILESTONE_BATCH @"/KeyMileStoneBatch"
#define ETG_MASTER_ALL_MASTER_DATA @"/AllMasterData"

#define ETG_ECCR_FILTER @"/Filter"
#define ETG_ECCR_ABR @"/ABR"
#define ETG_ECCR_CPB @"/CPBOverall"
#define ETG_ECCR_CPS @"/CPS"

#define ETG_MANPOWER_FILTER @"/Filter"
#define ETG_MANPOWER_AHC @"/AHC"
#define ETG_MANPOWER_PNECHCR @"/PNECHCR"
#define ETG_MANPOWER_PLR @"/PLR"

#define ETG_SCORECARD_KEY_HIGHLIGHTS_PATH @"/PSCKeyHighLights"
#define ETG_SCORECARD_PROJECT_BACKGROUND_PATH @"/ScoreCardAboutProject"
#define ETG_SCORECARD_COST_PCSB_PATH @"/ScoreCardCostPCSB"
#define ETG_SCORECARD_COST_PMU_PATH @"/ScoreCardCostPMU"
#define ETG_SCORECARD_HSE_PATH @"/ScoreCardHSE"
#define ETG_SCORECARD_PRODUCTION_PATH @"/ScoreCardProduction"
#define ETG_SCORECARD_SCHEDULE_PATH @"/ScoreCardSchedule"
#define ETG_SCORECARD_TABLE_SUMMARY_PATH @"/ScoreCardBatchSummary"


//Input Keys
#define kInputReportingMonth @"inpReportingMonth"
// Project
#define kInputPllSearchString @"inpSearchString"
#define kInputPllCountryKey @"inpCountryKey"
#define kInputPllRegionKey @"inpRegionKey"
#define kInputPllClusterKey @"inpClusterKey"
#define kInputPllProjectTypeKey @"inpProjectTypeKey"
#define kInputPllProjectNatureKey @"inpProjectNatureKey"
#define kInputPllComplexityKey @"inpComplexityKey"
#define kInputPllProjectKey @"inpProjectKey"
// MAP/ECCR
#define kInputPageSize @"inpPageSize"
#define kInputPageNumber @"inpPageNumber"
// Lesson learnt
#define kInputProjectLessonDetailKey @"inpProjectLessonDetailKey"
#define kInputPllReviewItemKey @"inpReviewItemKey"
#define kInputPllProjectLessonImpactKey @"inpProjectLessonImpactKey"
#define kInputPllRiskCategoryKey @"inpRiskCategoryKey"
#define kInputPllProjectLessonRatingKey @"inpProjectLessonRatingKey"
#define kInputPllAreaKey @"inpAreaKey"
#define kInputPllDisciplineKey @"inpDisciplineKey"
#define kInputPllLessonValueKey @"inpLessonValueKey"
#define kInputPllActivityKey @"inpActivityKey"
// ECCR
#define kInputPEccrDivisionKey @"inpBudgetHolderKey"
#define kInputEccrProjectKeys @"inpProjectKeys"

//ManPower Filter Root Key (To be used in the ETGfilterModelController, ETGManpowerViewController and for all the manpower filter)
#define kInputReportType @"inpReportType"
#define kInputRequestType @"inpRequestType"
#define kManpowerFilterAHCRootKey @"filterAverageHeadCount"
#define kManpowerFilterHCRRootKey @"filterHeadCountRequired"
#define kManpowerFilterLRRootKey @"filterLoadingRequired"
#define kInputManpowerYears @"inpYears"
#define kInputManpowerDepartmentKeys @"inpDepartmentKeys"
#define kInputManpowerSectionKeys @"inpSectionKeys"
#define kInputManpowerRegionKeys @"inpRegionKeys"
#define kInputManpowerClusterKeys @"inpClusterKeys"
#define kInputManpowerProjectKeys @"inpProjectKeys"
#define kInputManpowerProjectPositionKeys @"inpProjectPositionKeys"

#pragma mark - Constant Alert Messages
// Error Constant
#define coreDataToJSONError @"Failed to convert core data to JSON"
#define fetchError @"Fetch error: %@"
#define serializationError @"Serialization error: %@"
#define persistentStoreError @"Error in saving to persistent store"
#define webServiceFetchError @"Error in web service, trying to fetch cached data..."
#define fetchedDataPersistentError @"Fetched data will not be persistent"
#define saveCoreDataError @"Unable to save changes to core data"
#define updateCoreDataError @"Changes to core data was not saved"
#define fetchProjectError @"Fetch Project error: %@"
#define connectionFailedError @"Connection failed: %@"
#define fileDeleteError @"File deletion failed."
#define genericError @"ERROR: %@"
#define requestFailedError @"Request Failed with Error: %@, %@"
#define saveEntityError @"Could not save entity: %@"
#define gotError @"Got an error: %@"
#define newFieldOrFieldNameChangedError @"New field or field name changed error from web service: %@"
#define noDataFoundError @"No Data found."
#define pdfFeatureError @"Library: %@"

// Warn Constant
#define incorrectDataType @"Web service passed incorrect data type for variable"
#define serverCannotBeReachedWarn @"There's no internet connection"


// Info Constant
#define etgLaunchLog @"ElevateToGo did finish launch."
#define filePathLog @"FilePath: %@"
#define tokenLog @"Token: %@"
#define successDownloadLog @"Successfully downloaded file to %@"
#define jsonLog @"JSONSTRING: %@"
#define showSignLog @"Show sign in screen"

// Prefix Constant
#define apcPrefix @"APC"
#define cpbPrefix @"CPB"
#define hsePrefix @"HSE"
#define hcPrefix @"Hydrocarbon"
#define rtbdPrefix @"Production RTBD"
#define wpbPrefix @"WPB"
#define projectModulePrefix @"Project Module"
#define logInfoPrefix @"[INFO] "
#define logWarnPrefix @"[WARN] "
#define logErrorPrefix @"[ERROR] "

// Alert Constant
#define scoreCardNoDataAlert @"Scorecard: No data found."
#define portfolioNoDataAlert @"Portfolio: There are items which don't have available data."
#define projectNoDataAlert @"Project: There are items which don't have available data."
#define noTokenAlert @"Unable to get token. There's no internet connection available or the server is down."
#define pdfFeatureAlert  @"Library: "
#define deckOfflineAvailableAlert @"Deck indicated is available offline."
#define deckOfflineNotAvailableAlert @"Deck indicated is not available offline."
#define expiredTokenAlert @"Token has expired. Requesting new token."
#define portfolioAlert @"Porfolio: %@"
#define chartNoAvailableDataAlert @"There are charts which don't have available data."
#define itemNoAvailableDataAlert @"There are items which don't have available data."
#define scoreCardAlert @"Scorecard: %@"
#define projectAlert @"Project: %@"
#define keyHighlightsAlert @"Key Highlights: "
#define projectBackgroundAlert @"Project Background: "
#define serverCannotBeReachedAlert @"Server cannot be reached."


//Left menu
#define kLeftViewController @"LeftViewController"
#define kPortfolioViewController @"PortfolioViewController"
#define kProjectViewController @"ProjectViewController"
#define kMAPViewController @"MAPViewController"
#define kPLLViewController @"PLLViewController"
#define kCostControlViewController @"CostControlViewController"
#define kManpowerViewController @"ManpowerViewController"
#define kLibraryViewController @"LibraryViewController"
#define kHomeViewController @"HomeViewController"
#define kHelpViewController @"HelpViewController"
#define kLoginViewController @"LoginViewController"

//Color
#define kPetronasGreenColor [UIColor colorWithRed:2/255.0 green:174/255.0 blue:155/255.0 alpha:1.0]
#define kFilterSubSectionColor [UIColor colorWithRed:225/255.0 green:255/255.0 blue:247/255.0 alpha:1.0]
#define kBottomToolbarColor [UIColor colorWithRed:0.9725 green:0.9725 blue:0.9725 alpha:1.0]
#define kLightGrayCellBackgroundColor [UIColor colorWithRed:(245.0/255.0) green:(245.0/255.0) blue:(245.0/255.0) alpha:1]

//Default filter values
#define kDefaultOperatorshipKey @1  //Operatorship = COB (Malaysia)
#define kDefaultProjectPhaseKey @1  //Phase = Execution
#define kDefaultProjectStatusKey @1 //Project status = Open
#define kDefaultBudgetHolderKey @1  //Budget holder = Project & Engineering
//Reporting Month:  latest
//Region:           Select all
//Project:          Select all
//Baseline type:    latest
//Revision No.:     latest

#define kSelectedReportingMonth @"kSelectedReportingMonth"
#define kSelectedOperatorship @"kSelectedOperatorship"
#define kSelectedPhase @"kSelectedPhase"
#define kSelectedProjects @"kSelectedProjects"
#define kSelectedBudgetHolder @"kSelectedBudgetHolder"
#define kSelectedCostCategory @"kSelectedCostCategory"
#define kSelectedKeyMilestone @"kSelectedKeyMilestone"
#define kSelectedSpeeds @"kSelectedSpeed"
#define kSelectedDurations @"kSelectedDurations"
#define kSelectedYear @"kSelectedYear"
#define kSelectedSection @"kSelectedSection"
#define kSelectedDepartment @"kSelectedDepartment"
#define kSelectedRegion @"kSelectedRegion"
#define kSelectedCluster @"kSelectedCluster"
#define kSelectedProject @"kSelectedProject"
#define kSelectedProjectPosition @"kSelectedProjectPosition"

//UAC left menu module keys
#define kPortfolioModuleKeys  @[@2,@1006]
#define kProjectModuleKeys    @[@1, @1007]
#define kMapModuleKeys        @[@4504]
#define kPllModuleKeys        @[@4]
#define kCostModuleKeys       @[@2017, @2075 ,@2081]
//#define kCostModuleKeys       @[@5]
#define kMPSModuleKeys        @[@5005,@5007,@5009]
#define kResourcesModuleKeys  @[@6]
#define kLibraryModuleKeys    @[@1041]

#define kModuleKey @"key"
#define kEnableModuleReports @"subModule"

//Future implementation - handle the popup/detailed tables keys and logic later for Portfolio and Project

//UAC Portfolio module report keys
#define kHydrocarbonReportKeys                      @[@1016,@1035]
#define kProductionRtbdReportPortfolioModuleKeys    @[@1017,@1036]
#define kWpbReportKeys                              @[@1018]
#define kHseReportPortfolioModuleKeys               @[@1019,@1037]
#define kCostPerfReportKeys                         @[@1020,@1038] //Cost Performance refers to CPB and APC reports

//UAC Project module report keys
#define kKeyMilestoneReportKeys                     @[@1108,@1029]
#define kScheduleSCurveReportKeys                   @[@1009,@1030]
#define kbudgetReportKeys                           @[@1010]
#define kAfeReportKeys                              @[@1011]
#define kProductionRtbdReportProjectModuleKeys      @[@1012,@1031]
#define kRiskOpportunityReportKeys                  @[@1013,@1032]
#define kHseReportProjectModuleKeys                 @[@1014,@1033]
#define kPpmsReportKeys                             @[@1015,@1034]

// UAC ECCR module report keys
#define kEccrCostPerformanceSummaryKey 2017
#define kEccrCpbWaterfallChartKey 2075
#define kEccrAbrMonitoringKey 2081

// UAC MANPOWER module report keys
#define kManpowerAverageHeadcountRequiredKey 5005
#define kManpowerHeadcountRequiredKey 5007
#define kManpowerLoadingRequiredKey 5009

// UAC MANPOWER module report keys
#define kManpowerProjectPerformanceRequiredKey 4037
#define kManpowerPortfolioPerformanceRequiredKey 4036

#define kNumberOfExpiryDaysCoreData 15

//Notification names
#define kDownloadFilterDataForGivenReportingMonthCompleted @"kDownloadFilterDataForGivenReportingMonthCompleted"
#define kDownloadFilterDataForGivenReportingMonthFailed @"kDownloadFilterDataForGivenReportingMonthFailed"
#define kDownloadProjectCompleted @"kDownloadProjectCompleted"
#define kDownloadFilterDataForGivenReportingMonthNoError @"kDownloadFilterDataForGivenReportingMonthNoError"
#define kDownloadMapFilterDataForGivenReportingMonthCompleted @"kDownloadMapFilterDataForGivenReportingMonthCompleted"
#define kDownloadMapFilterDataForGivenReportingMonthFailed @"kDownloadMapFilterDataForGivenReportingMonthFailed"
#define kDownloadEccrFilterDataForGivenReportingMonthFailed @"kDownloadEccrFilterDataForGivenReportingMonthFailed"
#define kDownloadManpowerFilterDataForGivenReportingMonthFailed @"kDownloadManpowerFilterDataForGivenReportingMonthFailed"
#define kDownloadFilterDataForPllCompleted @"kDownloadFilterDataForPllCompleted"
#define kDownloadFilterDataForMapCompleted @"kDownloadFilterDataForMapCompleted"
#define kDownloadFilterDataForEccrCompleted @"kDownloadFilterDataForEccrCompleted"
#define kDownloadFilterDataForManpowerStarting @"kDownloadFilterDataForManpowerStarting"
#define kDownloadFilterDataForManpowerCompleted @"kDownloadFilterDataForManpowerCompleted"
#define kDownloadFilterDataForPllFailed @"kDownloadFilterDataForPllFailed"
#define kDownloadFilterDataForMapFailed @"kDownloadFilterDataForMapFailed"
#define kDownloadFilterDataForEccrFailed @"kDownloadFilterDataForEccrFailed"
#define kDownloadMapShouldAutoRefresh @"kDownloadMapShouldAutoRefresh"
#define kDownloadEccrShouldAutoRefresh @"kDownloadEccrShouldAutoRefresh"
#define kDownloadManPowerShouldAutoRefresh @"kDownloadManPowerShouldAutoRefresh"
#define kDownloadPllShouldAutoRefresh @"kDownloadPllShouldAutoRefresh"
#define kDownloadManpowerShouldAutoRefresh @"kDownloadManpowerShouldAutoRefresh"
#define kUserChanged @"kUserChanged"
#define kDifferentUserLoggedIn @"kDifferentUserLoggedIn"

//KeyChain
#define kETGToken @"kETGToken"
#define kETGUsername @"kETGUsername"
#define kETGPassword @"kETGPassword"

#define kNoConnectionErrorCode -1009

//Scorecard
#define kPageSize 5

//Project Chart
#define kDefaultPageID @"id=0"

//String Literal to be Passed to HTML
#define literalTrue @"true"
#define literalFalse @"false"

//Automatic Data Download
#define kTimestampDateDifference 15

