jQuery(function ($) {
  //swiper
  var elem = document.getElementById('swiper');

  //controlling the nav icons active and inactive state
  var bullets = document.getElementById('pagination').getElementsByTagName('em');
  window.swiper = new Swipe(elem, {
      speed : 400,
      continuous : false,
      callback : function (pos) {
        var i = bullets.length; //Gets the number of items in the var bullets.
        while (i--) {
          bullets[i].innerHTML = '<span class="empty">&#8226;</span>'; //Sets the inactive position indicators.
        }
        bullets[pos].innerHTML = '<span class="filled">&#8226;</span>'; //Applies styling of .on to active position indicator.
      }
    });


}); //end ready

// populateAllChartsAtLevel1(sampleDataNoData);
// populateAllChartsAtLevel1(sampleData);
// populateAllChartsAtLevel1(latestJSON);
// populateAllChartsAtLevel1(json1220);

function populateAllChartsAtLevel1(contentJSONStr) {
  //getting all data for all charts
  var contentJSONObj = contentJSONStr;
  console.log(contentJSONObj);
  
  var reportingMonthForKeyMilestone = (contentJSONObj.projectDetails === undefined || contentJSONObj.projectDetails.reportingMonth === undefined ? 'null' : contentJSONObj.projectDetails.reportingMonth);
  
  var phaseForBudget = contentJSONObj.projectDetails === undefined ||
	contentJSONObj.projectDetails.phase === undefined ? 'null' 
	: contentJSONObj.projectDetails.phase;
	
  populateTitleForProject((contentJSONObj.projectDetails === undefined ? 'no data' : contentJSONObj.projectDetails));
  
  /*
  counter for charts that could be included in a page, max of 4
  if page count reaches 4, the next chart to be displayed will be appended to the next page
   */
  var firstPageCount = 0,
  secondPageCount = 0,
  thirdPageCount = 0;

  var firstPage = $('#first-page');
  var secondPage = $('#second-page');
  var thirdPage = $('#third-page');

  var module = 'project';
  var level = 2;
  var id = 0;
  firstPage.empty();
  secondPage.empty();
  thirdPage.empty();
  var keymilestoneData = contentJSONObj.keymilestone === undefined ? 'no data' : contentJSONObj.keymilestone,
  contentKeyMilestone = '<div id="mainKeyMilestoneContainer" class="div chart-dimension">' +
    '<div id="milestone-left-container">' +
    '<div id="hydro-container" class="milestone-chart-div fixed-table-container"> </div>' +
    '</div>' +
    '<div id="keyMilestoneChart" class="milestone-chart-div"></div>' +
    '</div>',
  scheduleData = contentJSONObj.schedule === undefined ? 'no data' : contentJSONObj.schedule,
  contentSchedule = '<div id="scheduleChart" class="chart-div"></div>',
  budgetData = contentJSONObj.budget === undefined ? 'no data' : contentJSONObj.budget,
  contentBudget = '<div id="budgetChart" class="chart-div"></div>',
  afeData = contentJSONObj.afe === undefined ? 'no data' : contentJSONObj.afe,
  contentAFE = '<div id="afeMainChartContainer" class="chart-div">' +
    '<div id="afe-title"></div>' +
    '<div id="chartAFEContainer"></div>' +
	'<div id="AFELegend"><p>AFE : Authorised for Expenditure</p><p>ITD : Inception to Date</p><p>AFC : Anticipated Final Cost</p></div>' +
    '</div>',
  rtbdData = contentJSONObj.rtbd === undefined ? 'no data' : contentJSONObj.rtbd,
  contentRTBD = '<div id="RTBDChart" class="chart-div"></div>',
  riskAndOpData = contentJSONObj.riskOpportunity === undefined ? 'no data' : contentJSONObj.riskOpportunity,
  contentRiskAndOp = '<div id="riskAndOpChartContainer" class="chart-div">' +
    '<div id="riskAndOpMainTitle" class="div riskAndOp-title"></div>' +
    '<div id="chartRiskContainer"></div>' +
    '<div id="chartOpportunityContainer"></div>' +
    '</div>',
  hseData = contentJSONObj.hse === undefined ? 'no data' : contentJSONObj.hse,
  contentHSE = '<div id="HSEChart" class="chart-div"></div>',
  ppmsData = contentJSONObj.ppms === undefined ? 'no data' : contentJSONObj.ppms,
  contentPPMS = '<div id="ppmsTableContainer" class="chart-div">' +
    '<div id="ppms-title" class="div"></div>' +
    '<div id="tablePPMSContainer"></div>' +
    '</div>',
  mpsData = contentJSONObj.mps === undefined ? 'no data' : contentJSONObj.mps,
  contentMPS = '<div id="mpsChart" class="chart-div"></div>';

  if (keymilestoneData == 'disabled') {}
  else if (keymilestoneData == 'no data') {
    firstPage.append(contentKeyMilestone);
    firstPageCount += 2;
    var keyMilestoneNoData = JSON.parse('{"chartdata":' +
        '{' +
        '"chartTitle":"Key Milestone", "chartSubtitle":" ",' +
        '"chartContents":[' +
        '{"name":"Actual Progress","data":[]},' +
        '{"name":"Original Baseline","data":[]},' +
        '{"name":"Plan","data":[]}' +
        ']},' +
        '"firstHydrocarbon":' +
        '[' +
        '],' +
        '"tabledata":' +
        '[' +
        ']' +
        '}');
    populateKeyMilestoneChart(keyMilestoneNoData, 1, reportingMonthForKeyMilestone, id);
	id++;
  } else {
    firstPage.append(contentKeyMilestone);
    firstPageCount += 2;
    populateKeyMilestoneChart(keymilestoneData, 1, reportingMonthForKeyMilestone, id);
    id++;
  }

  if (scheduleData == 'disabled') {}
  else if (scheduleData == 'no data') {
    firstPage.append(contentSchedule);
    firstPageCount += 1;

    var scheduleNoData = JSON.parse('{"chartdata":' +
        '[' +
        '{"name":"Actual Progress","data":[]},' +
        '{"name":"Original Baseline","data":[]},' +
        '{"name":"Plan","data":[]}],"coreinfo":{"plan": "0", "actual": "0", "variance":"0"},' +
        ' "tabledata":' +
        '[' +
        ']' +
        '}');
    populateScheduleChart(scheduleNoData, 1, id);
	id++;
  } else {

    firstPage.append(contentSchedule);
    firstPageCount += 1;
    populateScheduleChart(scheduleData, 1, id);
    id++;
  }

  if (budgetData == 'disabled') {}
  else if (budgetData == 'no data') {
    firstPage.append(contentBudget);
    firstPageCount += 1;

    var budgetNoData = JSON.parse('{"chartdata":[{"coreinfo":{"FDP":"N/A", "Cum VOWD":"N/A","YTD Actual":"0"},' +
        '"series":[' +
        ']}], "tabledata":' +
        '[{"coreinfo":{"FDP":"0", "Cum VOWD":"0","YTD Actual":"0"},' +
        '"series":[' +
        ']}]' +
        '}');

    populateBudgetChart(budgetNoData, 1, id, phaseForBudget);
	id++;
  } else {
    firstPage.append(contentBudget);
    firstPageCount += 1;
	var validatedBudgetData = validateBudgetData(budgetData);
    populateBudgetChart(validatedBudgetData, 1, id, phaseForBudget);
    id++;
  }

  if (afeData == 'disabled') {}
  else if (afeData == 'no data') {
    if (firstPageCount < 4) {
      firstPageCount++;
      firstPage.append(contentAFE);
    } else {
      secondPageCount++;
      secondPage.append(contentAFE);
    }
    

    var afeNoData = JSON.parse('{"chartdata":[' +
        '],' +
        '"tabledata":[' +
        ']}');

    populateAFEChart(afeNoData, 1, id);
	id++;
  } else {
    if (firstPageCount < 4) {
      firstPageCount++;
      firstPage.append(contentAFE);
    } else {
      secondPageCount++;
      secondPage.append(contentAFE);
    }
    populateAFEChart(afeData, 1, id);
    id++;
  }

  if (rtbdData == 'disabled') {}
  else if (rtbdData == 'no data') {
    if (firstPageCount < 4) {
      firstPageCount++;
      firstPage.append(contentRTBD);
    } else {
      secondPageCount++;
      secondPage.append(contentRTBD);
    }
    

    var rtbdNoData = JSON.parse('{' +
        '"chartdata":{' +
        '"newproduction":[' +
        '{"name":"YEP", "data":[0, 0, 0, 0]},' +
        '{"name":"CPB", "data":[0, 0, 0, 0]}' +
        '],' +
        '"rtbd":[' +
        '{"name":"YEP", "data":[0, 0, 0, 0]},' +
        '{"name":"CPB", "data":[0, 0, 0, 0]}' +
        ']' +
        '},' +
        '"tabledata":[' +
        ']' +
        '}');

    populateRTBDChart(rtbdNoData, 1, id);
	id++;
  } else {
    if (firstPageCount < 4) {
      firstPageCount++;
      firstPage.append(contentRTBD);
    } else {
      secondPageCount++;
      secondPage.append(contentRTBD);
    }
    populateRTBDChart(rtbdData, 1, id);
    id++;
  }

  if (riskAndOpData == 'disabled') {}
  else if (riskAndOpData == 'no data') {
    if (firstPageCount < 4) {
      firstPageCount++;
      firstPage.append(contentRiskAndOp);
    } else {
      secondPageCount++;
      secondPage.append(contentRiskAndOp);
    }
    

    var riskAndOpNoData = JSON.parse('{"tabledata":{' +
        '"risk":' +
        '[' +
        '],' +
        '"opportunity":' +
        '[' +
        ']' +
        '},' +
        '"chartdata":{"risk":[' +
        '],' +
        '"opportunity":[' +
        ']' +
        '}}');

    populateRiskAndOpportunityChart(riskAndOpNoData, 1, id);
	id++;

  } else {
    if (firstPageCount < 4) {
      firstPageCount++;
      firstPage.append(contentRiskAndOp);
    } else {
      secondPageCount++;
      secondPage.append(contentRiskAndOp);
    }
    populateRiskAndOpportunityChart(riskAndOpData, 1, id);
    id++;

  }

  if (hseData == 'disabled') {}
  else if (hseData == 'no data') {
    if (firstPageCount < 4) {
      firstPageCount++;
      firstPage.append(contentHSE);
    } else {
      secondPageCount++;
      secondPage.append(contentHSE);
    }
    
    var hseNoData = JSON.parse('{"chartdata":' +
        '[' +
        '{"fatalityCount": "0",' +
        '	"categories": [],' +
        '	"kpi": [],'+
        '	"totalManHour": "n/a"}' +
        '],' +
        '"tabledata":[' +
        ']}');
    populateHSEChart(hseNoData, 1, id);
	id++;
  } else {

    if (firstPageCount < 4) {
      firstPageCount++;
      firstPage.append(contentHSE);
    } else {
      secondPageCount++;
      secondPage.append(contentHSE);
    }
    populateHSEChart(hseData, 1, id);
    id++;
  }

  if (ppmsData == 'disabled') {}
  else if (ppmsData == 'no data') {
    if (firstPageCount < 4) {
      firstPageCount++;
      firstPage.append(contentPPMS);
    } else if (secondPageCount < 4) {
      secondPageCount++;
      secondPage.append(contentPPMS);
      thirdPage.remove();
    } else {
      thirdPageCount++;
      thirdPage.append(contentPPMS);
    }

    var ppmsNoData = JSON.parse('{"ppms":[]}');
    populatePPMSReviewTable(ppmsNoData.ppms, 1, id);
    id++;
  } else {

    if (firstPageCount < 4) {
      firstPageCount++;
      firstPage.append(contentPPMS);
    } else if (secondPageCount < 4) {
      secondPageCount++;
      secondPage.append(contentPPMS);
      thirdPage.remove();
    } else {
      thirdPageCount++;
      thirdPage.append(contentPPMS);
    }
    populatePPMSReviewTable(ppmsData, 1, id);
    id++;
  }

  if (mpsData == 'disabled'){}
  else if (mpsData == 'no data'){
    if (firstPageCount < 4) {
      firstPageCount++;
      firstPage.append(contentMPS);
    } else if (secondPageCount < 4) {
      secondPageCount++;
      secondPage.append(contentMPS);
      thirdPage.remove();
    } else {
      thirdPageCount++;
      thirdPage.append(contentMPS);
    }

    var mpsNoData = {
      tabledata : [],
      chartdata : {
        categories : [],
        series: [
                { name : "Filled", data : null },
                { name : "Vacant", data : null }
      ]
    } };
    populateMPSChart(mpsNoData, 1, id);
  }else{
    if (firstPageCount < 4) {
      firstPageCount++;
      firstPage.append(contentMPS);
    } else if (secondPageCount < 4) {
      secondPageCount++;
      secondPage.append(contentMPS);
      thirdPage.remove();
    } else {
      thirdPageCount++;
      thirdPage.append(contentMPS);
    }
    populateMPSChart(mpsData, 1, id);
  }

    
  
  //adding the nav icons
    //First page : 3    4   4   4   4   4
    //Second page: 0    3   4   2   0   4
    //Third page : 0    0   0   0   0   1
  $('#pagination').empty();
    if (thirdPageCount>0) {
        //Add the paging indicators for 3 pages
        $('#pagination').append('<em><span class="filled">&#8226;</span></em> <em><span class="empty">&#8226;</span></em> <em><span class="empty">&#8226;</span></em>');
    } else if (secondPageCount>0) {
        //Add the paging indicators for 2 pages and remove the third page from the DOM
        thirdPage.remove();
        $('#pagination').append('<em><span class="filled">&#8226;</span></em> <em><span class="empty">&#8226;</span></em>');
    } else {
        //Add the paging indicator for 1 page and remove the second and third page from the DOM
        secondPage.remove();
        thirdPage.remove();
        $('#pagination').append('<em><span class="filled">&#8226;</span></em>');
    }
    
}
