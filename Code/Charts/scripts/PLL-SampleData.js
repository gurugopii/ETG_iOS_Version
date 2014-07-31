var lessonsCountData = JSON.parse(
    '{"pllReviews": ['+
    '   {"avoidLessons2": 24,"pllReview2": "PLL 00 - Engineering","pllReviewKey2": 39,"replicateLessons2": 56},'+
    '   {"avoidLessons": 14,"pllReview": "PLL 01 - Industrial","pllReviewKey": 39,"replicateLessons": 26},'+
    '   {"avoidLessons": 4,"pllReview": "PLL 02 - Engineering","pllReviewKey": 39,"replicateLessons": 66},'+
    '   {"avoidLessons": 4,"pllReview": "PLL 03 - Engineering","pllReviewKey": 39,"replicateLessons": 57},'+
    '   {"avoidLessons": 6,"pllReview": "PLL 04 - Engineering","pllReviewKey": 39,"replicateLessons": 58},'+
    '   {"avoidLessons": 12,"pllReview": "PLL 05 - Engineering","pllReviewKey": 39,"replicateLessons": 53},'+
    '   {"avoidLessons": 46,"pllReview": "PLL 06 - Engineering","pllReviewKey": 39,"replicateLessons": 52},'+
    '   {"avoidLessons": 7,"pllReview": "PLL 07 - Engineering","pllReviewKey": 39,"replicateLessons": 55}'+
    '],'+
    '"projects": ['+
    '   {"avoidLessons2": 20,"projectKey2": 80,"projectName": "Project 81","replicateLessons2": 45},'+
    '   {"avoidLessons": 10,"projectKey": 81,"projectName": "Project 82","replicateLessons": 65},'+
    '   {"avoidLessons": 6,"projectKey": 82,"projectName": "Project 83","replicateLessons": 23},'+
    '   {"avoidLessons": 7,"projectKey": 83,"projectName": "Project 84","replicateLessons": 25},'+
    '   {"avoidLessons": 9,"projectKey": 84,"projectName": "Project 85","replicateLessons": 21},'+
    '   {"avoidLessons": 3,"projectKey": 85,"projectName": "Project 86","replicateLessons": 62},'+
    '   {"avoidLessons": 4,"projectKey": 86,"projectName": "Project 87","replicateLessons": 88},'+
    '   {"avoidLessons": 6,"projectKey": 87,"projectName": "Project 88","replicateLessons": 26}'+
    
    ']}'
);  
    
var pllResultsData = JSON.parse(
    '{  "searchBarContent":"Drilling",'+
    '    "searchResults": ['+
    '    {   "impactDesc2": "Drilling has to extend main deck to accommodate hase manifold",'+
    '        "lessonDesc2": "Production group extended lower deck, obstructing drilling HP hose during drilling activities",'+
    '        "potentialValueConverted2": 10000, "projectLessonDetailKey2": 1, "projectName": "Project A",'+
    '        "recommendationDesc2": "1. Improve communication\\n2. Consult drilling group before any platform modification",'+
    '        "replicateInd": "Y", "bookmarkInd":"N" },'+
    '    {   "impactDesc": "Drilling has to extend main deck to accommodate hase manifold",'+
    '        "lessonDesc": "Production group extended lower deck, obstructing drilling HP hose during drilling activities",'+
    '        "potentialValueConverted": 50000, "projectLessonDetailKey": 3, "projectName": "Project 1",'+
    '        "recommendationDesc": "1. Improve communication\\n2. Consult drilling group before any platform modification",'+
    '        "replicateInd": "Y", "bookmarkInd":"N" },'+
    '    {   "impactDesc": "Drilling has to extend main deck to accommodate hase manifold",'+
    '        "lessonDesc": "Production group extended lower deck, obstructing drilling HP hose during drilling activities",'+
    '        "potentialValueConverted": 65656, "projectLessonDetailKey": 34, "projectName": "Project A",'+
    '        "recommendationDesc": "1. Improve communication\\n2. Consult drilling group before any platform modification",'+
    '        "replicateInd": "Y", "bookmarkInd":"Y" },'+
    '    {   "impactDesc": "Drilling has to extend main deck to accommodate hase manifold",'+
    '        "lessonDesc": "Production group extended lower deck, obstructing drilling HP hose during drilling activities",'+
    '        "potentialValueConverted": 12341234, "projectLessonDetailKey": 55, "projectName": "Project A",'+
    '        "recommendationDesc": "1. Improve communication\\n2. Consult drilling group before any platform modification",'+
    '        "replicateInd": "Y", "bookmarkInd":"N" },'+
    '    {   "impactDesc": "Drilling has to extend main deck to accommodate hase manifold",'+
    '        "lessonDesc": "Production group extended lower deck, obstructing drilling HP hose during drilling activities",'+
    '        "potentialValueConverted": 498999, "projectLessonDetailKey": 12, "projectName": "Project DS",'+
    '        "recommendationDesc": "1. Improve communication\\n2. Consult drilling group before any platform modification",'+
    '        "replicateInd": "Y", "bookmarkInd":"N" },'+
    '    {   "impactDesc": "Drilling has to extend main deck to accommodate hase manifold",'+
    '        "lessonDesc": "Production group extended lower deck, obstructing drilling HP hose during drilling activities",'+
    '        "potentialValueConverted": 70000, "projectLessonDetailKey": 56, "projectName": "Project 7",'+
    '        "recommendationDesc": "1. Improve communication\\n2. Consult drilling group before any platform modification",'+
    '        "replicateInd": "Y", "bookmarkInd":"N" },'+
    '    {   "impactDesc": "Drilling has to extend main deck to accommodate hase manifold",'+
    '        "lessonDesc": "Production group extended lower deck, obstructing drilling HP hose during drilling activities",'+
    '        "potentialValueConverted": 3333, "projectLessonDetailKey": 87, "projectName": "Project 5",'+
    '        "recommendationDesc": "1. Improve communication\\n2. Consult drilling group before any platform modification",'+
    '        "replicateInd": "Y", "bookmarkInd":"Y" },'+
    '    {   "impactDesc": "Drilling has to extend main deck to accommodate hase manifold",'+
    '        "lessonDesc": "Production group extended lower deck, obstructing drilling HP hose during drilling activities",'+
    '        "potentialValueConverted": 70000, "projectLessonDetailKey": 45, "projectName": "Project 54",'+
    '        "recommendationDesc": "1. Improve communication\\n2. Consult drilling group before any platform modification",'+
    '        "replicateInd": "N", "bookmarkInd":"N" },'+
    '    {   "impactDesc": "Drilling has to extend main deck to accommodate hase manifold",'+
    '        "lessonDesc": "Production group extended lower deck, obstructing drilling HP hose during drilling activities",'+
    '        "potentialValueConverted": 34000, "projectLessonDetailKey": 34, "projectName": "Project 12",'+
    '        "recommendationDesc": "1. Improve communication\\n2. Consult drilling group before any platform modification",'+
    '        "replicateInd": "N", "bookmarkInd":"N" },'+
    '    {   "impactDesc": "Drilling has to extend main deck to accommodate hase manifold",'+
    '        "lessonDesc": "Production group extended lower deck, obstructing drilling HP hose during drilling activities",'+
    '        "potentialValueConverted": 340004, "projectLessonDetailKey": 2, "projectName": "Project C",'+
    '        "recommendationDesc": "1. Improve communication\\n2. Consult drilling group before any platform modification",'+
    '        "replicateInd": "N", "bookmarkInd":"Y" }'+
    '],'+
	'"pageFunction":"search",' +
	'"sortListForReplicate":[1,0],' +
	'"sortListForAvoid":[1,0]' +
	'}'
);

var pllDetailData = JSON.parse(
    '{'+
    '   "USDRate": 51.0986, "activity": "Detailed Engineering", "approvalStatus": null, "areaName": "Operations",'+
    '   "baselineDesc": "FID Approval supposed to be in March 2012",'+
    '   "causeDesc": "FID sitting postponed due to numerous HSE issues at that point of time ",'+
    '   "createDttm": "2013-07-16 10:19", "createUserId": "luvainraj.silvarajah", "currencyName": "USD",'+
    '   "disciplineName": null, "impactDesc": "FID approval was obtain via syndication",'+
    '   "lessonDesc": "FID perform offline on 24th April 2012",'+
    '   "potentialValue": 46090232, "potentialValueBasis": "Not Applicable", "potentialValueConverted": 23123123123,'+
    '   "projectLessonDetailKey": 210, "projectLessonImpactNm": "Organisational", "projectLessonRatingNm": "High",'+
    '   "projectName": "PROJECT DEMO 03",'+
    '   "recommendationDesc": "To build in buffer in project schedule minimum 2 months due to sitting is once a month",'+
    '   "replicateInd": "N", "reviewItemName": "PLL 00 - Engineering", "riskCategoryName": "Stakeholder Approval",'+
    '   "totalLikeNo": null, "updateDttm": "2013-07-16 11:21", "updateUserId": "laiyee.yap", "bookmarkInd":"N"'+
    '}'
);

