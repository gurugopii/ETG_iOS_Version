var pageIndex = 0;
var currentIndex = 0;

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
      currentIndex = pos;
    }
  });


jQuery(function ($) {

  if(!isFromPortfolio || isFromPortfolio == 'N/A'){
    window.swiper.slide(location.search.split("=")[1], 100);
  }
  
  $('table').delegate('tr', 'touchend', function (e) {
    var state = $(this).hasClass('highlighted');
    $('.highlighted').removeClass('highlighted');
    if (!state) {
      $(this).addClass('highlighted');
    }
  });
}); //end ready

//variable used by nav icons to place correct active position
var fill = location.search.split("=")[1];

// populateAllChartsAtLevel2(latestJSON);
// populateAllChartsAtLevel2(sampleData, true, 'rtbd');
// populateAllChartsAtLevel2(sampleDataNoData);
// populateAllChartsAtLevel2(json1220);
// populateAllChartsAtLevel2(json1203);

function populateAllChartsAtLevel2(contentJSONStr, isFromPortfolioCharts, chartType) {
  // isFromPortfolio = isFromPortfolioCharts === undefined ? false : isFromPortfolioCharts;
    
  isFromPortfolio = validateField(isFromPortfolioCharts);

 //getting all data for all charts
  var div = $('#page');
  var contentJSONObj = contentJSONStr;

  //populateTitleForProject(contentJSONObj.projectDetails);
  var reportingMonthForKeyMilestone = (contentJSONObj.projectDetails === undefined || contentJSONObj.projectDetails.reportingMonth === undefined ? 'null' : contentJSONObj.projectDetails.reportingMonth);

  var phaseForBudget = contentJSONObj.projectDetails === undefined || 
  contentJSONObj.projectDetails.phase === undefined ? 'null'
     : contentJSONObj.projectDetails.phase;

  populateTitleForProject((contentJSONObj.projectDetails === undefined ? 'no data' : contentJSONObj.projectDetails));
  var module = 'project';
  var level = 2;
  var pageCount = 0;
  var pagePosition = ['#first', '#second', '#third', '#fourth', '#fifth', '#sixth', '#seventh', '#eighth', '#ninth'];
  var pageNumberOfReport = [0, 1, 2, 3, 4, 5, 6, 7];
  var keymilestoneData = contentJSONObj.keymilestone === undefined ? 'no data' : contentJSONObj.keymilestone,
  contentKeyMilestone = '<div id="first-page">' +
    '<div id="keyMilestoneMainContainer" class="div chart-dimension">' +
    '<div id="milestone-left-container">' +
    '<div id="hydro-container" class="milestone-chart-div fixed-table-container"></div>' +
    '</div>' +
    '<div id="keyMilestoneChart" class="milestone-chart-div"></div>' +
    '</div>' +
    '<div class="div table-dimension">' +
    '<div id="tableKeyMilestoneContainer" class="fixed-table-container">' +
    '</div>' +
    '</div>' +
    '</div>',
  keyMilestonePageNumber = 0,
  scheduleData = contentJSONObj.schedule === undefined ? 'no data' : contentJSONObj.schedule,
  contentSchedule = '<div id="second-page">' +
    '<div id="scheduleChart" class="div chart-dimension"></div>' +
    '<div class="div table-dimension">' +
    '<div id="tableScheduleContainer" class="fixed-table-container">' +
    '</div>' +
    '</div>' +
    '</div>',
  budgetData = contentJSONObj.budget === undefined ? 'no data' : contentJSONObj.budget,
  contentBudget = '<div id="third-page">' +
    '<div id="budgetChart" class="div chart-dimension"></div>' +
    '<div class="div table-dimension">' +
    '<div id="tableBudgetContainer" class="fixed-table-container"></div>' +
    '</div>' +
    '</div>',
  afeData = contentJSONObj.afe === undefined ? 'no data' : contentJSONObj.afe,
  contentAFE = '<div id="fourth-page">' +
    '<div id="afeMainChartContainer" class="div chart-dimension">' +
    '<div id="afe-title" class="div"></div>' +
    '<div id="chartAFEContainer" class="fixed-table-container-afe"></div>' +
    '<div id="AFELegend"><p>AFE : Authorised for Expenditure</p><p>ITD : Inception to Date</p><p>AFC : Anticipated Final Cost</p></div>' +
    '</div>' +
    '<div id="afeMainTableContainer" class="div table-dimension">' +
    '<div id="tableAFEContainer" class="fixed-table-container">' +
    '</div>' +
    '</div>' +
    '</div>',
  rtbdData = contentJSONObj.rtbd === undefined ? 'no data' : contentJSONObj.rtbd,
  contentRTBD = '<div id="fifth-page">' +
    '<div id="RTBDChart" class="div chart-dimension"></div>' +
    '<div class="div table-dimension">' +
    '<div id="tableRTBDContainer" class="fixed-table-container">' +
    '</div>' +
    '</div>' +
    '</div>',
  riskAndOpData = contentJSONObj.riskOpportunity === undefined ? 'no data' : contentJSONObj.riskOpportunity,
  contentRiskAndOp = '<div id="sixth-page">' +
    '<div id="riskOpChartContainer" class="div chart-dimension">' + //chartcontainer
    '<div id="riskAndOpMainTitle" class="div-risk-op riskAndOp-title"></div>' +
    '<div id="riskMainChartContainer" class="div-risk-op chart-dimension risk-op-chart">' +
    '<div id="chartRiskContainer" class="fixed-table-container-riskAndOp1"></div>' +
    '</div>' +
    '<div id="opportunityMainChartContainer" class="div-risk-op chart-dimension risk-op-chart">' +
    '<div id="chartOpportunityContainer" class="fixed-table-container-riskAndOp1"></div>' +
    '</div>' +
    '</div>' + //end chartcontainer
    '<div id="riskMainTableContainer" class="div-risk-op table-dimension risk-op-chart">' +
    '<div id="risk-table-subtitle" class="div-risk-op subtitle">Risk</div>' +
    '<div id="tableRiskContainer" class="fixed-table-container">' +
    '</div>' +
    '</div>' +
    '<div id="opMainTableContainer" class="div-risk-op table-dimension risk-op-chart">' +
    '<div id="opportunity-table-subtitle" class="div-risk-op subtitle">Opportunity</div>' +
    '<div id="tableOpportunityContainer" class="fixed-table-container">' +
    '</div>' +
    '</div>' +
    '</div>',
  hseData = contentJSONObj.hse === undefined ? 'no data' : contentJSONObj.hse,
  contentHSE = '<div id="seventh-page">' +
    '<div id="HSEChart" class="div chart-dimension">hse container</div>' +
    '<div class="div table-dimension">' +
    ' <div id="tableHSEContainer" class="fixed-table-container">' +
    '</div>' +
    '</div>' +
    ' </div>',
  ppmsData = contentJSONObj.ppms === undefined ? 'no data' : contentJSONObj.ppms,
  contentPPMS = '<div id="eighth-page">' +
    '<div id="ppmsTableContainer" class="div chart-dimension">' +
    '<div id="ppms-title" class="div"></div>' +
    '<div id="tablePPMSContainer" class="fixed-table-container"></div>' +
    '</div>' +
    ' </div>',
    mpsData = contentJSONObj.mps === undefined ? 'no data' : contentJSONObj.mps,
    contentMPS = '<div id="ninth-page">' +
    '<div id="mpsChart" class="div chart-dimension"></div>' +
    '<div class="div table-dimension">' +
    ' <div id="tableMPSContainer" class="fixed-table-container">' +
    '</div>' +
    '</div>' +
    ' </div>';

  if (keymilestoneData == 'disabled') {
    pageNumberOfReport[0] = -1;
	console.log('pageNumberOfReport');
	console.log(pageNumberOfReport);
  }
  else if (keymilestoneData == 'no data') {
    $(pagePosition[pageCount]).empty().append(contentKeyMilestone);
    //noDataAvailable(['#keyMilestoneMainContainer', '#tableKeyMilestoneContainer'], module, 'keyMilestone', level);
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
    populateKeyMilestoneChart(keyMilestoneNoData, 2, reportingMonthForKeyMilestone);
//      if (keyMilestoneNoData.tabledata != 'disabled' && keyMilestoneNoData.tabledata !== undefined) {
          populateKeyMilestoneTable(keyMilestoneNoData);
//      }
//      else { console.log("Key Milestone detailed table is disabled"); }
    pageCount++;
  } else {
    $(pagePosition[pageCount]).empty().append(contentKeyMilestone);
    pageCount++;
    populateKeyMilestoneChart(keymilestoneData, 2, reportingMonthForKeyMilestone);

    if (keymilestoneData.tabledata != 'disabled' && keymilestoneData.tabledata !== undefined) {
        populateKeyMilestoneTable(keymilestoneData);
    }
    else { console.log("Key Milestone detailed table is disabled"); }
   
    
  }

  if (scheduleData == 'disabled') {
    pageNumberOfReport[1] = -1;
	console.log('pageNumberOfReport');
	console.log(pageNumberOfReport);
  }
  else if (scheduleData == 'no data') {
    $(pagePosition[pageCount]).empty().append(contentSchedule);

    var scheduleNoData = JSON.parse('{"chartdata":' +
        '[' +
        '{"name":"Actual Progress","data":[]},' +
        '{"name":"Original Baseline","data":[]},' +
        '{"name":"Plan","data":[]}],"coreinfo":{"plan": "0", "actual": "0", "variance":"0"},' +
        ' "tabledata":' +
        '[' +
        ']' +
        '}');
    populateScheduleChart(scheduleNoData, 2);
//      if (scheduleNoData.tabledata != 'disabled' && scheduleNoData.tabledata !== undefined) {
          populateScheduleTable(scheduleNoData);
//      }
//      else { console.log("Schedule S-Curve detailed table is disabled"); }
    pageCount++;
  } else {
    $(pagePosition[pageCount]).empty().append(contentSchedule);
    pageCount++;
    populateScheduleChart(scheduleData, level);
    if (scheduleData.tabledata != 'disabled' && scheduleData.tabledata !== undefined) {
        populateScheduleTable(scheduleData);
    }
    else { console.log("Schedule S-Curve detailed table is disabled"); }
    
  }

  if (budgetData == 'disabled') {
    pageNumberOfReport[2] = -1;
	console.log('pageNumberOfReport');
	console.log(pageNumberOfReport);
  }
  else if (budgetData == 'no data') {
    $(pagePosition[pageCount]).empty().append(contentBudget);
    pageCount++;

    var budgetNoData = JSON.parse('{"chartdata":[{"coreinfo":{},' +
        '"series":[' +
        ']}], "tabledata":' +
        '[{"coreinfo":{"FDP":"N/A", "Cum VOWD":"N/A","YTD Actual":"N/A"},' +
        '"series":[' +
        ']}]' +
        '}');
    populateBudgetChart(budgetNoData, level, 0, phaseForBudget);
//      if (budgetNoData.tabledata != 'disabled' && budgetNoData.tabledata !== undefined) {
          populateBudgetTable(budgetNoData);
//      }
//      else { console.log("Budget performance detailed table is disabled"); }
  } else {
    $(pagePosition[pageCount]).empty().append(contentBudget);
    pageCount++;
	
	console.log('budgetData before');
	console.log(budgetData);
	var validatedBudgetData = validateBudgetData(budgetData);
	console.log('budgetData after');
	console.log(validatedBudgetData);
	
    // populateBudgetChart(budgetData, level, 0, phaseForBudget);
    populateBudgetChart(validatedBudgetData, level, 0, phaseForBudget);
    if (validatedBudgetData.tabledata != 'disabled' && validatedBudgetData.tabledata !== undefined) {
        populateBudgetTable(validatedBudgetData);
    }
    else { console.log("Budget performance detailed table is disabled"); }
  }

  if (afeData == 'disabled') {
    pageNumberOfReport[3] = -1;
	console.log('pageNumberOfReport');
	console.log(pageNumberOfReport);
  }
  else if (afeData == 'no data') {
    $(pagePosition[pageCount]).empty().append(contentAFE);
    pageCount++;

    var afeNoData = JSON.parse('{"chartdata":[' +
        '],' +
        '"tabledata":[' +
        ']}');

    populateAFEChart(afeNoData, level);
//      if (afeNoData.tabledata != 'disabled' && afeNoData.tabledata !== undefined) {
          populateAFETable(afeNoData);
//      }
//      else { console.log("AFE performance detailed table is disabled"); }

  } else {
    $(pagePosition[pageCount]).empty().append(contentAFE);
    pageCount++;
    populateAFEChart(afeData, level);
    if (afeData.tabledata != 'disabled' && afeData.tabledata !== undefined) {
        populateAFETable(afeData);
    }
    else { console.log("AFE performance detailed table is disabled"); }

  }

  if (rtbdData == 'disabled') {
    pageNumberOfReport[4] = -1;
	console.log('pageNumberOfReport');
	console.log(pageNumberOfReport);
  }
  else if (rtbdData == 'no data') {
    $(pagePosition[pageCount]).empty().append(contentRTBD);
    pageCount++;

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
    populateRTBDChart(rtbdNoData, level);
//      if (rtbdNoData.tabledata != 'disabled' && rtbdNoData.tabledata !== undefined) {
          populateRTBDTable(rtbdNoData);
//      }
//      else { console.log("RTBD performance detailed table is disabled"); }
  } else {
    $(pagePosition[pageCount]).empty().append(contentRTBD);
    pageCount++;
    populateRTBDChart(rtbdData, level);
    if (rtbdData.tabledata != 'disabled' && rtbdData.tabledata !== undefined) {
        populateRTBDTable(rtbdData);
    }
    else { console.log("RTBD performance detailed table is disabled"); }
    
  }

  if (riskAndOpData == 'disabled') {
    pageNumberOfReport[5] = -1;
	console.log('pageNumberOfReport');
	console.log(pageNumberOfReport);
  }
  else if (riskAndOpData == 'no data') {
    $(pagePosition[pageCount]).empty().append(contentRiskAndOp);
    pageCount++;
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

    populateRiskAndOpportunityChart(riskAndOpNoData, level);
//      if (riskAndOpNoData.tabledata != 'disabled' && riskAndOpNoData.tabledata !== undefined) {
          populateRiskAndOpportunityTable(riskAndOpNoData);
//      }
//      else { console.log("Risk and Opportunity detailed table is disabled"); }
  } else {
    $(pagePosition[pageCount]).empty().append(contentRiskAndOp);
    pageCount++;
    populateRiskAndOpportunityChart(riskAndOpData, level);
      if (riskAndOpData.tabledata != 'disabled' && riskAndOpData.tabledata !== undefined) {
          populateRiskAndOpportunityTable(riskAndOpData);
      }
      else { console.log("Risk and Opportunity detailed table is disabled"); }

    
  }

  if (hseData == 'disabled') {
    pageNumberOfReport[6] = -1;
	console.log('pageNumberOfReport');
	console.log(pageNumberOfReport);
  }
  else if (hseData == 'no data') {
    $(pagePosition[pageCount]).empty().append(contentHSE);
    pageCount++;

    var hseNoData = JSON.parse('{"chartdata":' +
        '[' +
        '{"fatalityCount": "n/a",' +
        '	"series": {' +
        '		"LTIF": null,' +
        '		"FIF": null,' +
        '		"TRCF": null' +
        '	},' +
        '	"kpi": {' +
        '		"LTIFkpi": 0,' +
        '		"TRCFkpi": 0,' +
        '		"FIFkpi": 0' +
        '	},' +
        '	"totalManHour": "n/a"}' +
        '],' +
        '"tabledata":[' +
        ']}');
    populateHSEChart(hseNoData, level);
//      if (hseNoData.tabledata != 'disabled' && hseNoData.tabledata !== undefined) {
          populateHSETable(hseNoData);
//      }
//      else { console.log("HSE detailed table is disabled"); }
    
  } else {
    $(pagePosition[pageCount]).empty().append(contentHSE);
    pageCount++;
    populateHSEChart(hseData, level);

      if (hseData.tabledata != 'disabled' && hseData.tabledata !== undefined) {
            populateHSETable(hseData);
      }
      else { console.log("HSE detailed table is disabled"); }
  }

  if (ppmsData == 'disabled') {
    pageNumberOfReport[7] = -1;
	console.log('pageNumberOfReport');
	console.log(pageNumberOfReport);
  }
  else if (ppmsData == 'no data') {
    $(pagePosition[pageCount]).empty().append(contentPPMS);
    pageCount++;
    var ppmsNoData = JSON.parse('{"ppms":[]}');
    populatePPMSReviewTable(ppmsNoData.ppms, level);
  } else {
    $(pagePosition[pageCount]).empty().append(contentPPMS);
    pageCount++;
    populatePPMSReviewTable(ppmsData, level);
  }


  // MPS Section
  if( mpsData == 'disabled') {}
  else if( mpsData == 'no data'){
    $(pagePosition[pageCount]).empty().append(contentMPS);
    pageCount++;

    var mpsNoData = {
      tabledata : [],
      chartdata : {
        categories : [],
        series: [
                { name : "Filled", data : null },
                { name : "Vacant", data : null }
      ]
    } };
    populateMPSChart(mpsNoData, level);
    populateMPSProjectTable(mpsNoData);
  }else{
    $(pagePosition[pageCount]).empty().append(contentMPS);
    pageCount++;
    populateMPSChart(mpsData, level);

      if (mpsData.tabledata != 'disabled' && mpsData.tabledata !== undefined) {
            populateMPSProjectTable(mpsData);
      }
      else { console.log("MPS detailed table is disabled"); }
  }

  //remove extra pages
  if (pageCount < 9) {
    for (var pageCountIndex = pageCount; pageCountIndex <= 9; pageCountIndex++) {
      $(pagePosition[pageCountIndex]).remove();
    }
  }

  //adding the nav icons
  var pagination = $('#pagination');
  pagination.empty();
  for (var i = 0; i < pageCount; i++) {
    if (i == fill) {
      pagination.append('<em><span class="filled">&#8226;</span></em>&nbsp;');
    } else {
      pagination.append('<em><span class="empty">&#8226;</span></em>&nbsp;');
    }
  }
  
  if (isFromPortfolioCharts && isFromPortfolioCharts !== undefined && chartType !== '') {
    chartType = validateField(chartType);
    if (chartType == 'hydro1' || chartType == 'hydro2') {
      pageIndex = checkForPageIndex(0, pageNumberOfReport)
    } else if (chartType == 'rtbd') {
      pageIndex = checkForPageIndex(4, pageNumberOfReport)
    } else if (chartType == 'cpb' || chartType == 'apc' || chartType == 'wpb') {
      pageIndex = checkForPageIndex(2, pageNumberOfReport)
    } else if (chartType == 'hse2') {
      pageIndex = checkForPageIndex(6, pageNumberOfReport)
    }
    window.swiper.slide(pageIndex, 100);
  }
    
    if(validateField(chartType) == ''){
        //adding the nav icons
        var pagination = $('#pagination');
        pagination.empty();
        for (var i = 0; i < pageCount; i++) {
            if (i == currentIndex) {
                pagination.append('<em><span class="filled">&#8226;</span></em>&nbsp;');
            } else {
                pagination.append('<em><span class="empty">&#8226;</span></em>&nbsp;');
            }
        }
    }
}

function checkForPageIndex(index, pageNumberOfReportArray) {
  if (pageNumberOfReportArray[index] == -1) {
    return 0;
  } 
  return pageNumberOfReportArray[index];
}
function populateKeyMilestoneTable(keyMilestoneData) {
  //table for key milestone
  var dataKeyMilestone = keyMilestoneData.tabledata;

  $.map(dataKeyMilestone, function (data, i) {
    data.indicator = validateField(data.indicator);
    data.milestone = validateField(data.milestone);
    data.baseline = setCorrectDateFormat(validateField(data.baseline), 'table');
//    data.outlook = validateField(data.outlook);
        data.outlook = setCorrectDateFormat(validateField(data.outlook), 'table');
        });
  var divKeyMilestone = $('#tableKeyMilestoneContainer');

  var tableKeyMilestone = '<table id="keymilestoneTable" class="petronas tablesorter">' +
    '<thead class="fixedHeader">' +
    '<tr class="tablesorter-headerRow">' +
    '<th id="milestoneHeader"><span class="th-inner">Milestone</span></th>' +
    '<th id="baselineHeader"><span class="th-inner">Baseline</span></th>' +
    '<th><span class="th-inner">Outlook</span></th>' +
    '<th><span class="th-inner">Indicator</span></th>' +
    '</tr>' +
    '</thead>' +
    '<tbody>';

  //table rows for key milestone
  if (dataKeyMilestone.length === 0) {
    tableKeyMilestone += '<tr>' +
    '<td colspan="4">No data available</td>' +
    '</tr>';
  } else {
    for (var i = 0; i < dataKeyMilestone.length; i++) {
      tableKeyMilestone += '<tr>' +
      '<td class="left">' + dataKeyMilestone[i].milestone + '</td>' +
      '<td class="left">' + dataKeyMilestone[i].baseline + '</td>' +
      '<td class="left">' + dataKeyMilestone[i].outlook + '</td>' +
      '<td><img class="imageIndicator" ' + 'alt="' + dataKeyMilestone[i].indicator + '" src="' + returnIndicatorPath(dataKeyMilestone[i].indicator) + '"/></td>' +
      '</tr>';
    }
  }

  tableKeyMilestone += '</tbody>' +
  '</table>';

  divKeyMilestone.empty();
  divKeyMilestone.append(tableKeyMilestone);
  removeTableDuplicates($('#keymilestoneTable tr'));
  setProperAlignment($('#keymilestoneTable tr'));
  if (dataKeyMilestone.length === 0) {
    noDataDisplay('#keymilestoneTable');
  }

  $('#keymilestoneTable').tablesorter({
    sortList : [[1, 0], [0, 0]],
    dateFormat : "ddmmyyyy",
    textExtraction : function (s) {
      if ($(s).find('img').length === 0)
        return $(s).text();
      return $(s).find('img').attr('alt');
    },
	headers : {
	  0 : {
	    sorter : false
	  }
	}
  });

  $('#keymilestoneTable tr th:nth-child(-n+2)').removeClass('tablesorter-headerAsc');
  setHighlightOnTouch('#keymilestoneTable');
} // end key milestone table

function populateScheduleTable(scheduleData) {

  //schedule table
  var divSchedule = $('#tableScheduleContainer');
  var dataSchedule = scheduleData.tabledata;
  var tableSchedule = '<table id="scheduleTable" class="petronas">' +
    '<thead>' +
    '<tr class="tablesorter-headerRow">' +
    '<th><span class="th-inner">Reporting Date</span></th>' +
    '<th><span class="th-inner">Original Baseline</span></th>' +
    '<th><span class="th-inner">Plan Progress</span></th>' +
    '<th><span class="th-inner">Actual Progress</span></th>' +
    '<th><span class="th-inner">Variance %</span></th>' +
    '<th><span class="th-inner">Indicator</span></th>' +
    '</tr>' +
    '</thead>' +
    '<tbody>';

  if (dataSchedule.length === 0) {
    tableSchedule += '<tr>' +
    '<td colspan="6">No data available</td>' +
    '</tr>';
  } else {
    $.map(dataSchedule, function (data, i) {
      data.originalBaseline = (data.originalBaseline === undefined || data.originalBaseline === '(null)%' || data.originalBaseline === 'N\/A' || data.originalBaseline === 'null' || data.originalBaseline === '(null)') ? 'N/A' : numberWithCommas(data.originalBaseline) + '%';
      data.planProgress = (data.planProgress === undefined || data.planProgress === '(null)%' || data.planProgress === 'N\/A' || data.planProgress === 'null' || data.planProgress === '(null)') ? 'N/A' : numberWithCommas(data.planProgress) + '%';
      data.actualProgress = (data.actualProgress === undefined || data.actualProgress === '(null)%' || data.actualProgress === 'N\/A' || data.actualProgress === 'null' || data.actualProgress === '(null)') ? 'N/A' : numberWithCommas(data.actualProgress) + '%';
      data.variance = (data.variance === undefined || data.variance === '(null)%' || data.variance === 'N\/A' || data.variance === '(null)' || data.variance === 'null' || data.variance === null) ? 'N/A' : numberWithCommas(data.variance.toString().replace(/%/, '')) + '%';
      data.indicator = (data.indicator === null || data.indicator === undefined ? "null" : data.indicator);
	  data.reportingDate = setCorrectDateFormat(validateField(data.reportingDate), 'table');
    });
    //table rows for key milestone
    for (var i = 0; i < dataSchedule.length; i++) {
      tableSchedule += '<tr>' +
      '<td class="left">' + dataSchedule[i].reportingDate + '</td>' +
      '<td class="right">' + dataSchedule[i].originalBaseline + '</td>' +
      '<td class="right">' + dataSchedule[i].planProgress + '</td>' +
      '<td class="right">' + dataSchedule[i].actualProgress + '</td>' +
      '<td class="right">' + dataSchedule[i].variance + '</td>' +
      '<td><img class="imageIndicator" src="' + returnIndicatorPath(dataSchedule[i].indicator) + '" alt="' + dataSchedule[i].indicator + '"/></td>' +
      '</tr>';
    }
  }

  tableSchedule += '</tbody>' +
  '</table>';
  divSchedule.empty();
  divSchedule.append(tableSchedule);
  setProperAlignment($('#scheduleTable tr'));
  if (dataSchedule.length === 0) {
    noDataDisplay('#scheduleTable');
  }

  removeTableDuplicates($('#scheduleTable tr'));
  
  $('#scheduleTable').tablesorter({
    sortList : [[0,0]],
    dateFormat : "ddmmyyyy",
    textExtraction : function (s) {
      if ($(s).find('img').length === 0)
        return $(s).text();
      return $(s).find('img').attr('alt');
    }
  });
  $('#scheduleTable tr th:nth-child(1)').removeClass('tablesorter-headerAsc');

  setHighlightOnTouch('#scheduleTable');
} //end schedule

function populateBudgetTable(budgetData) {

  //table for budget performance
  var divBudget = $('#tableBudgetContainer');

  //create table for budget
  var tableBudget = '<table id="budgetTable" class="petronas tablesorter">' +
    '<thead>' +
    '<tr>' +
    '<th><span class="th-inner">Plan Description</span></th>' +
    '<th><span class="th-inner">Plan Value</span></th>' +
    '<th><span class="th-inner">Forecast Description</span></th>' +
    '<th><span class="th-inner">Forecast Value</span></th>' +
    '<th><span class="th-inner">Variance %</span></th>' +
    '<th><span class="th-inner">Indicator</span></th>' +
    '</tr>' +
    '</thead>' +
    '<tbody>';

  if (budgetData.tabledata[0].series.length === 0) {
    tableBudget += '<tr>' +
    '<td colspan="6">No data available</td>' +
    '</tr>';
  } else {
    $.map(budgetData.tabledata[0].series, function (data, i) {
      // data.planvalue = numberWithCommas(data.planvalue);
      // data.forecastvalue = numberWithCommas(data.forecastvalue);
	  data.planvalue = numberWithCommasWithoutDecimal(data.planvalue);
      data.forecastvalue = numberWithCommasWithoutDecimal(data.forecastvalue);
      data.forecastvariance = (data.forecastvariance === null || data.forecastvariance === undefined || data.forecastvariance === 'N/A') ? 'N/A' : numberWithCommas(data.forecastvariance) + '%';
      data.indicator = validateField(data.indicator);
      data.forecastdescription = validateField(data.forecastdescription);
      data.plandescription = validateField(data.plandescription);
    });
    //add rows to the table
    for (var j = 0; j < budgetData.tabledata.length; j++) {
      var dataBudgetTable = budgetData.tabledata[j].series;
      for (var i = 0; i < dataBudgetTable.length; i++) {
        tableBudget += '<tr>' +
        '<td class="left">' + dataBudgetTable[i].plandescription + '</td>' +
        '<td class="right">' + dataBudgetTable[i].planvalue + '</td>' +
        '<td class="left">' + dataBudgetTable[i].forecastdescription + '</td>' +
        '<td class="right">' + dataBudgetTable[i].forecastvalue + '</td>' +
        '<td class="right">' + dataBudgetTable[i].forecastvariance + '</td>' +
        '<td><img src="' + returnIndicatorPath(dataBudgetTable[i].indicator) + '" alt="' + dataBudgetTable[i].indicator + '"/></td>' +
        '</tr>';
      }
    }
  }

  tableBudget += '</tbody>' +
  '</table>';

  divBudget.empty();
  divBudget.append(tableBudget);
  setProperAlignment($('#budgetTable tr'));
  
  if (budgetData.tabledata[0].series.length === 0) {
    noDataDisplay('#budgetTable');
  }

  $('#budgetTable').tablesorter({
    sortList : [[0, 0]],
    textExtraction : function (s) {
      if ($(s).find('img').length === 0)
        return $(s).text();
      return $(s).find('img').attr('alt');
    }
  });
  $('#budgetTable tr th:first-child').removeClass('tablesorter-headerAsc');
  setHighlightOnTouch('#budgetTable');

} //end budget

function populateAFETable(AFEData) {
  //afe detailed table
  var divAFE = $('#tableAFEContainer');
  var dataAFE = AFEData.tabledata;

  //create detailed table for afe
  var tableAFE = '<table id="AFETable" class="petronas tablesorter">' +
    '<thead>' +
    '<tr>' +
    '<th><span class="th-inner">AFE Description</span></th>' +
    '<th><span class="th-inner">Latest Approved AFE</span></th>' +
    '<th><span class="th-inner">ITD/VOWD</span></th>' +
    '<th><span class="th-inner">AFC</span></th>' +
    '<th><span class="th-inner">Variance %</span></th>' +
    '<th><span class="th-inner">Indicator</span></th>' +
    '</tr>' +
    '</thead>' +
    '<tbody>';

  if (dataAFE.length === 0) {
    tableAFE += '<tr class="tr-normal">' +
    '<td colspan="6">No data available</td>' +
    '</tr>';
  } else {
    $.map(dataAFE, function (data, i) {
	
      data.latestapprovedafe = (data.latestapprovedafe === null) ? 'N/A' : numberWithCommasWithoutDecimal(data.latestapprovedafe);
      data.AFEDescription = validateField(data.AFEDescription);
      data.itd = (data.itd === null) ? 'N/A' : numberWithCommasWithoutDecimal(data.itd);
      data.afc = (data.afc === null) ? 'N/A' : numberWithCommasWithoutDecimal(data.afc);
      data.variance = (data.variance === '(null)%' || data.variance === '(null)' || data.variance === 'null' || data.variance === null || data.variance === undefined) ? 'N/A' : numberWithCommas(data.variance * 100.00) + '%';
      data.indicator = (data.indicator === null || data.indicator === undefined ? "null" : data.indicator);
    });
    /*
    sorting data by color: Green, Yellow, Red
     */
    var dataWithGreenIndicator = JSON.parse('{"data": []}'),
    dataWithYellowIndicator = JSON.parse('{"data": []}'),
    dataWithRedIndicator = JSON.parse('{"data": []}'),
    dataWithOtherIndicator = JSON.parse('{"data": []}');

    $.each(dataAFE, function (i, row) {
      var ind = row.indicator.toLowerCase(),
      data = '{"afc":"' + row.afc + '", ' +
        '"indicator":"' + row.indicator + '",' +
        '"itd":"' + row.itd + '",' +
        '"AFEDescription":"' + row.AFEDescription + '",' +
        '"variance":"' + row.variance + '",' +
        '"latestapprovedafe":"' + row.latestapprovedafe + '"' +
        '}';
      if (ind == 'green') {
        dataWithGreenIndicator.data.push(JSON.parse(data));
      } else if (ind == 'yellow') {
        dataWithYellowIndicator.data.push(JSON.parse(data));
      } else if (ind == 'red') {
        dataWithRedIndicator.data.push(JSON.parse(data));
      } else {
        dataWithOtherIndicator.data.push(JSON.parse(data));
      }
    });

    var sortedJsonForTable = JSON.parse('{"tableData":[]}');
    sortedJsonForTable.tableData.push(dataWithGreenIndicator);
    sortedJsonForTable.tableData.push(dataWithYellowIndicator);
    sortedJsonForTable.tableData.push(dataWithRedIndicator);
    sortedJsonForTable.tableData.push(dataWithOtherIndicator);

    var sortedJsonForTableLength = sortedJsonForTable.length;

    $.each(sortedJsonForTable.tableData, function (outerIndex, outerRow) {
      $.each(outerRow.data, function (innerIndex, innerRow) {
        tableAFE += '<tr class="tr-normal">' +
        '<td class="left">' + innerRow.AFEDescription + '</td>' +
        '<td class="right">' + innerRow.latestapprovedafe + '</td>' +
        '<td class="right">' + (innerRow.itd) + '</td>' +
        '<td class="right">' + (innerRow.afc) + '</td>' +
        '<td class="right">' + innerRow.variance + '</td>' +
        '<td><img src=' + returnIndicatorPath(innerRow.indicator) + ' alt=' + innerRow.indicator + '/></td>' +
        '</tr>';
      });
    });
  }

  tableAFE += '</tbody>' +
  '</table>';

  divAFE.empty();
  divAFE.append(tableAFE);
  setProperAlignment($('#AFETable tr'));
  if (dataAFE.length === 0) {
    noDataDisplay('#AFETable');
  }

  $('#AFETable').tablesorter({
    textExtraction : function (s) {
      if ($(s).find('img').length === 0)
        return $(s).text();
      return $(s).find('img').attr('alt');
    }
  });

  setHighlightOnTouch('#AFETable');
} //end afe

function populateRTBDTable(RTBDData) {
  //table for rtbd
  var divForRTBD = $('#tableRTBDContainer');

  var data = RTBDData;

  $.map(RTBDData.tabledata, function (data, i) {
    data.indicator = (data.indicator === null || data.indicator === undefined ? "null" : data.indicator);
	data.hydrocarbonType = validateField(data.hydrocarbonType);
	data.cpb = validateField(data.cpb);
	data.category = validateField(data.category);
	data.yep = validateField(data.yep);
  });
  var tableContent = "";

  if (RTBDData.tabledata.length === 0) {
    tableContent += '<tr>' +
    '<td colspan="5">No data available</td>' +
    '</tr>';
  } else {
    $.map(data.tabledata, function (data, i) {
      data.category = validateField(data.category);
      data.hydrocarbonType = validateField(data.hydrocarbonType);
      data.indicator = validateField(data.indicator);
      data.cpb = (data.cpb === null) ? 'N/A' : numberWithCommas(data.cpb);
      data.yep = (data.yep === null) ? 'N/A' : numberWithCommas(data.yep);
    });
    /*
    sorting data by  1. Production 2. RTBD Followed By: 1. Oil 2. Gas 3. Condy
     */
    var dataForProduction = JSON.parse('{"data": []}'),
    dataForRTBD = JSON.parse('{"data": []}'),
    dataForOther = JSON.parse('{"data": []}');

    $.each(data.tabledata, function (i, row) {
      var cat = row.category.toLowerCase(),
      data = '{"category":"' + row.category + '",' +
        '"hydrocarbonType":"' + row.hydrocarbonType + '",' +
        '"cpb":"' + row.cpb + '",' +
        '"yep": "' + row.yep + '",' +
        '"indicator":"' + row.indicator + '"}';

      if (cat == 'production') {
        dataForProduction.data.push(JSON.parse(data));
      } else if (cat == 'rtbd') {
        dataForRTBD.data.push(JSON.parse(data));
      } else {
        dataForOther.data.push(JSON.parse(data));
      }
    });

    var sortedCategoryForTable = JSON.parse('{"tableData":[]}');

    var dataForProductionOil = JSON.parse('{"data": []}');
    var dataForProductionGas = JSON.parse('{"data": []}');
    var dataForProductionCondy = JSON.parse('{"data": []}');
    var dataForProductionOther = JSON.parse('{"data": []}');

    $.each(dataForProduction.data, function (i, row) {
      var type = row.hydrocarbonType.toLowerCase(),
      data = '{"category":"' + row.category + '",' +
        '"hydrocarbonType":"' + row.hydrocarbonType + '",' +
        '"cpb":"' + row.cpb + '",' +
        '"yep": "' + row.yep + '",' +
        '"indicator":"' + row.indicator + '"}';

      if (type == 'oil') {
        dataForProductionOil.data.push(JSON.parse(data));
      } else if (type == 'gas') {
        dataForProductionGas.data.push(JSON.parse(data));
      } else if (type == 'condy') {
        dataForProductionCondy.data.push(JSON.parse(data));
      } else {
        dataForProductionOther.data.push(JSON.parse(data));
      }
    });

    var dataForRTBDOil = JSON.parse('{"data": []}');
    var dataForRTBDGas = JSON.parse('{"data": []}');
    var dataForRTBDCondy = JSON.parse('{"data": []}');
    var dataForRTBDOther = JSON.parse('{"data": []}');

    $.each(dataForRTBD.data, function (i, row) {
      var type = row.hydrocarbonType.toLowerCase(),
      data = '{"category":"' + row.category + '",' +
        '"hydrocarbonType":"' + row.hydrocarbonType + '",' +
        '"cpb":"' + row.cpb + '",' +
        '"yep": "' + row.yep + '",' +
        '"indicator":"' + row.indicator + '"}';

      if (type == 'oil') {
        dataForRTBDOil.data.push(JSON.parse(data));
      } else if (type == 'gas') {
        dataForRTBDGas.data.push(JSON.parse(data));
      } else if (type == 'condy') {
        dataForRTBDCondy.data.push(JSON.parse(data));
      } else {
        dataForRTBDOther.data.push(JSON.parse(data));
      }
    });

    sortedCategoryForTable.tableData.push(dataForProductionOil);
    sortedCategoryForTable.tableData.push(dataForProductionGas);
    sortedCategoryForTable.tableData.push(dataForProductionCondy);
    sortedCategoryForTable.tableData.push(dataForProductionOther);

    sortedCategoryForTable.tableData.push(dataForRTBDOil);
    sortedCategoryForTable.tableData.push(dataForRTBDGas);
    sortedCategoryForTable.tableData.push(dataForRTBDCondy);
    sortedCategoryForTable.tableData.push(dataForRTBDOther);

    console.log('sortedCategoryForTable');
    console.log(sortedCategoryForTable);

    $.each(sortedCategoryForTable.tableData, function (outerIndex, outerRow) {
      $.each(outerRow.data, function (innerIndex, innerRow) {
        tableContent += '<tr class="tr-normal">' +
        '<td class="left">' + innerRow.category + '</td>' +
        '<td class="left">' + innerRow.hydrocarbonType + '</td>' +
        '<td class="right">' + innerRow.cpb + '</td>' +
        '<td class="right">' + innerRow.yep + '</td>' +
        '<td><img src="' + returnIndicatorPath(innerRow.indicator) + '" alt="' + innerRow.indicator + '"/></td>' +
        '</tr>';
      });
    });

  }

  //create the table
  var rtbdTable = '<table id="rtbdTable" class="petronas tablesorter">' +
    '<thead>' +
    '	<tr>' +
    '		<th><class="th-inner">Category</span></th>' +
    '		<th><span class="th-inner">Hydrocarbon Type</span></th>' +
    '		<th><span class="th-inner">Plan (CPB)</span></th>' +
    '		<th><span class="th-inner-main">Outlook (YEP)</span></th>' +
    '		<th><span class="th-inner-main">Indicator</span></th>' +
    '	</tr>' +
    '</thead>' +
    '<tbody>' +
    tableContent +
    '</tbody>' +
    '</table>';

  //append the table
  divForRTBD.empty();
  divForRTBD.append(rtbdTable);
  setProperAlignment($('#rtbdTable tr'));
  if (data.tabledata.length === 0) {
    noDataDisplay('#rtbdTable');
  }

  $('#rtbdTable').tablesorter({
    textExtraction : function (s) {
      if ($(s).find('img').length === 0)
        return $(s).text();
      return $(s).find('img').attr('alt');
    }
  });

  setHighlightOnTouch('#rtbdTable');

} //end rtbd

//function below to populate risk and opportunity page
function populateRiskAndOpportunityTable(riskAndOpportunityTableData) {

  //Risk Table Detailed
  var divRisk = $('#tableRiskContainer');

  var dataRisk = riskAndOpportunityTableData.tabledata.risk;

  $.map(dataRisk, function (data, i) {
	data.cluster = validateField(data.cluster);
	data.riskDescription = validateField(data.riskDescription);
	data.activity = validateField(data.activity);
	data.negativeImpact = validateField(data.negativeImpact);
	data.probability = validateField(data.probability);
	data.mitigationPlan = validateField(data.mitigationPlan);
	data.status = validateField(data.status);
	data.identifiedDate = setCorrectDateFormat(validateField(data.identifiedDate), 'table');
  });
  //creating the detailed risk table
  var tableRisk = '<table id="riskTable" rules="all" class="petronas tablesorter">' +
    '<thead>' +
    '<tr>' +
    '<th><span class="th-inner">Cluster</span></th>' +
    '<th><span class="th-inner">Description</span></th>' +
    '<th><span class="th-inner">Activity</span></th>' +
    '<th><span class="th-inner"">Impact</span></th>' +
    '<th><span class="th-inner">Probability</span></th>' +
    '<th><span class="th-inner">Mitigation</span></th>' +
    '<th><span class="th-inner">Status</span></th>' +
    '<th><span class="th-inner">Identified Date</span></th>' +
    '</tr>' +
    '</thead>' +
    '<tbody>';

  if (dataRisk.length === 0) {
    tableRisk += '<tr>' +
    '<td colspan="8">No data available</td>' +
    '</tr>';
  } else {
    //populating the detailed risk table
    for (var i = 0; i < dataRisk.length; i++) {
      tableRisk += '<tr>' +
      '<td class="left">' + dataRisk[i].cluster + '</td>' +
      '<td class="left">' + dataRisk[i].riskDescription + '</td>' +
      '<td class="left">' + dataRisk[i].activity + '</td>' +
      '<td class="left">' + dataRisk[i].negativeImpact + '</td>' +
      '<td class="left">' + dataRisk[i].probability + '</td>' +
      '<td class="left">' + dataRisk[i].mitigationPlan + '</td>' +
      '<td class="left">' + dataRisk[i].status + '</td>' +
      '<td class="left">' + dataRisk[i].identifiedDate + '</td>' +
      '</tr>';
    }
  }

  tableRisk += '</tbody>' +
  '</table>';

  divRisk.append(tableRisk);
  setProperAlignment($('#riskTable tr'));
  if (dataRisk.length === 0) {
    noDataDisplay('#riskTable');
  }
  //opportunity table detailed
  var divOpportunity = $('#tableOpportunityContainer');

  var dataOpportunity = riskAndOpportunityTableData.tabledata.opportunity;
  $.map(dataOpportunity, function (data, i) {
	data.cluster = validateField(data.cluster);
	data.opportunityDescription = validateField(data.opportunityDescription);
	data.activity = validateField(data.activity);
	data.negativeImpact = validateField(data.negativeImpact);
	data.probability = validateField(data.probability);
	data.mitigationPlan = validateField(data.mitigationPlan);
	data.status = validateField(data.status);
	data.identifiedDate = setCorrectDateFormat(validateField(data.identifiedDate), 'table');
  });
  //creating the detailed opportunity table
  var tableOpportunity = '<table id="opportunityTable" rules="all" class="petronas tablesorter">' +
    '<thead>' +
    '<tr>' +
    '<th><span class="th-inner">Cluster</span></th>' +
    '<th><span class="th-inner">Description</span></th>' +
    '<th><span class="th-inner">Activity</span></th>' +
    '<th><span class="th-inner">Impact</span></th>' +
    '<th><span class="th-inner">Probability</span></th>' +
    '<th><span class="th-inner">Mitigation</span></th>' +
    '<th><span class="th-inner">Status</span></th>' +
    '<th><span class="th-inner" style="left: -8px">Identified Date</span></th>' +
    '</tr>' +
    '</thead>' +
    '<tbody>';

  if (dataOpportunity.length === 0) {
    tableOpportunity += '<tr>' +
    '<td colspan="8">No data available</td>' +
    '</tr>';
  } else {
    //adding data to the detailed opportunity table
    for (var k = 0; k < dataOpportunity.length; k++) {
      tableOpportunity += '<tr class="tr-normal">' +
      '<td class="left">' + dataOpportunity[k].cluster + '</td>' +
      '<td class="left">' + dataOpportunity[k].opportunityDescription + '</td>' +
      '<td class="left">' + dataOpportunity[k].activity + '</td>' +
      '<td class="left">' + dataOpportunity[k].negativeImpact + '</td>' +
      '<td class="left">' + dataOpportunity[k].probability + '</td>' +
      '<td class="left">' + dataOpportunity[k].mitigationPlan + '</td>' +
      '<td class="left">' + dataOpportunity[k].status + '</td>' +
      '<td class="left">' + dataOpportunity[k].identifiedDate + '</td>' +
      '</tr>';
    }
  }

  tableOpportunity += '</tbody>' +
  '</table>';

  divOpportunity.empty();
  divOpportunity.append(tableOpportunity);
  setProperAlignment($('#opportunityTable tr'));
  if (dataOpportunity.length === 0) {
    noDataDisplay('#opportunityTable');
  }
  $('#opportunityTable').tablesorter({
    dateFormat : "ddmmyyyy"
  });
  $('#riskTable').tablesorter({
    dateFormat : "ddmmyyyy"
  });

  setHighlightOnTouch('#opportunityTable');
  setHighlightOnTouch('#riskTable');

}

//function below to populate hse page
function populateHSETable(HSEData) {
  //hse table
  var dataTable = HSEData.tabledata;
  var divHSE = $('#tableHSEContainer');

  //create table for hse
  var tableHSE = '<table id="HSETable" rules="all" class="petronas tablesorter">' +
    '<thead>' +
    '<tr>' +
    '<th><span class="th-inner">HSE ID</span></th>' +
    '<th><span class="th-inner">HSE Criteria</span></th>' +
    '<th><span class="th-inner">YTD Cases</span></th>' +
    '<th><span class="th-inner">YTD Frequency</span></th>' +
    '<th><span class="th-inner">KPI</span></th>' +
    '<th><span class="th-inner">Indicator</span></th>' +
    '</tr>' +
    '</thead>' +
    '<tbody>';

  if (dataTable.length === 0) {
    tableHSE += '<tr>' +
    '<td colspan="6">No data available</td>' +
    '</tr>';
  } else {
    $.map(dataTable, function (data, i) {
      data.ytdcase = (data.ytdcase === null || data.ytdcase === undefined) ? 'N/A' : numberWithCommas(data.ytdcase);
      data.ytdfrequency = (data.ytdfrequency === null || data.ytdfrequency === undefined) ? 'N/A' : numberWithCommas(data.ytdfrequency);
      data.kpi = (data.kpi === null || data.kpi === undefined) ? 'N/A' : numberWithCommas(data.kpi);
      data.indicator = (data.indicator === null || data.indicator === undefined ? "null" : data.indicator);
	  data.HSEID = validateField(data.HSEID);
	  data.hsecriteria = validateField(data.hsecriteria);
    });
    //add data to hse table
    for (var i = 0; i < dataTable.length; i++) {
      tableHSE += '<tr class="tr-normal">' +
      '<td class="left">' + dataTable[i].HSEID + '</td>' +
      '<td class="left">' + dataTable[i].hsecriteria + '</td>' +
      '<td class="right">' + (dataTable[i].ytdcase) + '</td>' +
      '<td class="right">' + dataTable[i].ytdfrequency + '</td>' +
      '<td class="right">' + (dataTable[i].kpi) + '</td>' +
      '<td class="center"><img class="imageIndicator" src="' + returnIndicatorPath(dataTable[i].indicator) + '" alt="' + dataTable[i].indicator + '"/></td>' +
      '</tr>';
    }
  }

  tableHSE += '</tbody>' +
  '</table>';

  divHSE.empty();
  divHSE.append(tableHSE);
  setProperAlignment($('#HSETable tr'));
  if (dataTable.length === 0) {
    noDataDisplay('#HSETable');
  }

  $('#HSETable').tablesorter({
    textExtraction : function (s) {
      if ($(s).find('img').length === 0)
        return $(s).text();
      return $(s).find('img').attr('alt');
    }
  });
  setHighlightOnTouch('#HSETable');
}
