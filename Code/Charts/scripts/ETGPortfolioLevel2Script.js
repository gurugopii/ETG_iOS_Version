jQuery(function ($) {
  //for swiping feature
  var elem = document.getElementById('swiper');

  //controlling the nav icons active and inactive state
  var bullets = document.getElementById('pagination').getElementsByTagName('em');
  window.swiper = new Swipe(elem, {
      speed : 400,
      continuous : false,
      callback : function (pos) {
        var i = bullets.length; //Gets the number of items in the var bullets.
        while (i--) {
          // bullets[i].className = 'off'; //Sets the inactive position indicators.
          bullets[i].innerHTML = '<span class="empty">&#8226;</span>'; //Sets the inactive position indicators.
        }
        // bullets[pos].className = 'on'; //Applies styling of .on to active position indicator.
        bullets[pos].innerHTML = '<span class="filled">&#8226;</span>'; //Applies styling of .on to active position indicator.
      }
    });
	
  window.swiper.slide(location.search.split("=")[1], 100);
  $('.back').on('touchend', function (e) {
    document.location = "ETGPortfolioLevel1.html";
  });
  

});

//variable used by nav icons to place correct active position
var fill = location.search.split("=")[1];

// populateAllChartsAtLevel2(sampleData);
// populateAllChartsAtLevel2(sampleData2);
// populateAllChartsAtLevel2(json1203);
// populateAllChartsAtLevel2(sample);
// populateAllChartsAtLevel2(json1215);

function populateAllChartsAtLevel2(contentJSONStr) {

  var contentJSONObj = JSON.parse(contentJSONStr);

  populateTitleForPortfolio(contentJSONObj.projectDetails === undefined ? 'no data' : contentJSONObj.projectDetails);
   var isProjectEnabled = validateField(contentJSONObj.projectDetails === undefined ? '{"isProjectEnabled":"no"}' : validateField(contentJSONObj.projectDetails.isProjectEnabled));
  var pageCounter = 0; //counter used to detect which page should the chart be appended
  //pages present in html
  var pagePosition = ['#first', '#second', '#third', '#fourth', '#fifth', '#sixth', '#seventh'];

  var module = 'portfolio';
  var hydroData = contentJSONObj.hydro === undefined ? 'no data' : contentJSONObj.hydro,
  contentHydro = '<div id="first-page">' +
    '<div id="hydro-title" class="title div"></div>' +
    '<div id="hydroMainContainer" class="div table-dimension">' +
    '<div id="tableHydroContainer" class="fixed-table-container">' +
    '</div>' +
    '</div>' +
    '<div id="hydro_legend_container" class="div">' +
    '<div id="hydro_legend">' +
    '<span><img class="indicator" src="images/bluediamond.png" alt="blue"/></span><span>&nbsp;Plan</span>' +
    '<span><img class="indicator" src="images/greentriangle.png" alt="red"/></span><span>Actual/Forecast earlier than Plan&nbsp;&nbsp;</span>' +
    '<span><img class="indicator" src="images/redtriangle.png" alt="green"/></span><span>Actual/Forecast later than Plan</span>' +
    '</div>' +
    '</div>' +
    '</div>';

  if (hydroData == 'disabled') {}
  else if (hydroData == 'no data') {
    $(pagePosition[pageCounter]).append(contentHydro);
    pageCounter++;

    var hydroNoData = JSON.parse('{"hydro":' +
        '[' +
        ']}');
    populateHydroTable(hydroNoData.hydro, 2);
    var hydroMainContainer = $('#hydroMainContainer');
  } else {
    $(pagePosition[pageCounter]).append(contentHydro);
    pageCounter++;
    populateHydroTable(hydroData, 2);
  }

  var rtbdData = contentJSONObj.rtbd === undefined ? 'no data' : contentJSONObj.rtbd,
  contentRTBD = '<div id="second-page">' +
    '<div id="RTBDChart" class="div chart-dimension"></div>' +
    '<div class="div table-dimension">' +
    '<div id="tableRTBDContainer" class="fixed-table-container">' +
    '</div>' +
    '</div>' +
    '</div>';
  if (rtbdData == 'disabled') {}
  else if (rtbdData == 'no data') {
    $(pagePosition[pageCounter]).append(contentRTBD);
    pageCounter++;

    var rtbdNoData = JSON.parse('{' +
        '"chartdata":{' +
        '"newproduction":[' +
        '{"name":"YEP", "data":[0, 0, 0, 0]},' +
        '{"name":"CPB", "data":[0, 0, 0, 0]}' +
        '],' +
        '"rtbd":[' +
        '{"name":"YEP", "data":[0, 0, 0]},' +
        '{"name":"CPB", "data":[0, 0, 0]}' +
        ']' +
        '},' +
        '"tabledata":[' +
        ']' +
        '}');
    populateRTBDChart(rtbdNoData, 2);
    populateRTBDTable(rtbdNoData);
  } else {
    $(pagePosition[pageCounter]).append(contentRTBD);
    pageCounter++;
    populateRTBDChart(rtbdData, 2);
      if (rtbdData.tabledata != 'disabled' && rtbdData.tabledata !== undefined) {
          populateRTBDTable(rtbdData);
      }
          else { console.log("RTBD detailed table is disabled"); }
    }

  var cpbData = contentJSONObj.cpb === undefined ? 'no data' : contentJSONObj.cpb,
  contentCPB = '<div id="third-page">' +
    '<div id="cpbChart" class="div chart-dimension"></div>' +
    '<div class="div table-dimension">' +
    '<div id="tableCPBContainer" class="fixed-table-container">' +
    '</div>' +
    '</div>' +
    '</div>';
  if (cpbData == 'disabled') {}
  else if (cpbData === 'no data') {
    $(pagePosition[pageCounter]).append(contentCPB);
    pageCounter++;
    var cpbNoData = JSON.parse('{' +
        '"tabledata":' +
        '[' +
        '],' +
        '"chartdata":' +
        '[{"name":"FY YTD Actual Equity","data":[]},{"name":"Approved CPB Equity","data":[]},{"name":"FY YEP Equity",	"data":[]}]' +
        '}');
    populateCPBChart(cpbNoData, 2);
    populateCPBTable(cpbNoData);
  } else {
    $(pagePosition[pageCounter]).append(contentCPB);
    pageCounter++;
    populateCPBChart(cpbData, 2);
    if (cpbData.tabledata != 'disabled' && cpbData.tabledata !== undefined) {
        populateCPBTable(cpbData);
    }
          else { console.log("CPB detailed table is disabled"); }
  }

  var apcData = contentJSONObj.apc === undefined ? 'no data' : contentJSONObj.apc,
  contentAPC = '<div id="fourth-page">' +
    '<div id="apcChart" class="div chart-dimension"></div>' +
    '<div class="div table-dimension">' +
    '<div id="tableAPCContainer" class="fixed-table-container">' +
    '</div>' +
    '</div>' +
    '</div>';
  if (apcData == 'disabled') {}
  else if (apcData === 'no data') {
    $(pagePosition[pageCounter]).append(contentAPC);
    pageCounter++;

    var apcNoData = JSON.parse('{' +
        '"tabledata":' +
        '[' +
        '],' +
        '"chartdata":[{"data":[0,0,0,0,0]}]' +
        '}');
    populateAPCChart(apcNoData, 2);
    populateAPCTable(apcNoData);
  } else {
    $(pagePosition[pageCounter]).append(contentAPC);
    pageCounter++;
    populateAPCChart(apcData, 2);
    if (apcData.tabledata != 'disabled' && apcData.tabledata !== undefined) {
        populateAPCTable(apcData);
    }
          else { console.log("APC detailed table is disabled"); }
  }

  var hseData = contentJSONObj.hse === undefined ? 'no data' : contentJSONObj.hse,
  contentHSE = '<div id="fifth-page">' +
    '<div id="hseChart" class="div chart-dimension"></div>' +
    '<div class="div table-dimension">' +
    '<div id="tableHSEContainer" class="fixed-table-container">' +
    '</div>' +
    '</div>' +
    '</div>';
  if (hseData == 'disabled') {}
  else if (hseData === 'no data') {
    $(pagePosition[pageCounter]).append(contentHSE);
    pageCounter++;

    var hseNoData = JSON.parse('{' +
        '"tabledata":' +
        '[' +
        '],' +
        '"chartdata":[{"name":"LTI","data":[null, null, null, null]}]' +
        '}');
    populateHSEChart(hseNoData, 2);
    populateHSETable(hseNoData);
  } else {
    $(pagePosition[pageCounter]).append(contentHSE);
    pageCounter++;
    populateHSEChart(hseData, 2);
    if (hseData.tabledata != 'disabled' && hseData.tabledata !== undefined) {
      populateHSETable(hseData);
    }
          else { console.log("HSE detailed table is disabled"); }
  }

  var wpbData = contentJSONObj.wpb === undefined ? 'no data' : contentJSONObj.wpb,
  contentWPB = '<div id="sixth-page">' +
    '<div id="wpbChart" class="div chart-dimension"></div>' +
    '<div class="div table-dimension">' +
    '<div id="tableWPBContainer" class="fixed-table-container">' +
    '</div>' +
    '</div>' +
    '</div>';
  if (wpbData == 'disabled') {}
  else if (wpbData === 'no data') {
    $(pagePosition[pageCounter]).append(contentWPB);
    pageCounter++;

    var wpbNoData = JSON.parse('{' +
        '"tabledata":' +
        '[' +
        '],' +
        '"chartdata":' +
        '[{"name":"ABRApproved","data":[null, null, null,null,null,null, null, null,null,null,null,null]},{"name":"ABRSubmitted","data":[null, null, null,null,null,null, null, null,null,null,null,null]}]' +
        '}');
    populateWPBChart(wpbNoData, 2);
    populateWPBTable(wpbNoData);
  } else {
    $(pagePosition[pageCounter]).append(contentWPB);
    pageCounter++;
    populateWPBChart(wpbData, 2);
    if (wpbData.tabledata != 'disabled' && wpbData.tabledata !== undefined) {
      populateWPBTable(wpbData);
    }
    else { console.log("WPB detailed table is disabled"); }
  }

  var mpsData = contentJSONObj.mps === undefined ? 'no data' : contentJSONObj.mps,
  contentMPS = '<div id="seventh-page">' +
    '<div id="mpsChart" class="div chart-dimension"></div>' +
    '<div class="div table-dimension">' +
    '<div id="tableMPSContainer" class="fixed-table-container">' +
    '</div>' +
    '</div>' +
    '</div>';
  if ( mpsData == 'disabled') {}
  else if( mpsData === 'no data' ){
    $(pagePosition[pageCounter]).append(contentMPS);
    pageCounter++;

    var mpsNoData = {
      tabledata : [],
      chartdata : {
        categories : [],
        series: [
                { name : "Filled", data : null },
                { name : "Vacant", data : null }
      ]
    } };
    populateMPSChart(mpsNoData, 2);
    populateMPSPortfolioTable(mpsNoData);
  }
  else{
    $(pagePosition[pageCounter]).append(contentMPS);
    pageCounter++;
    populateMPSChart(mpsData, 2);
    if( mpsData.tableData != 'disabled' && mpsData.tabledata !== undefined ){
      populateMPSPortfolioTable(mpsData);
    }
    else{ console.log('MPS detailed table is disabled'); }
  }

  if (pageCounter < 7) {
    for (var pageCountIndex = pageCounter; pageCountIndex <= 7; pageCountIndex++) {
      $(pagePosition[pageCountIndex]).remove();
    }
  }

  //adding the nav icons
  var pagination = $('#pagination');
  pagination.empty();
  for (var i = 0; i < pageCounter; i++) {
    if (i == fill) {
      pagination.append('<em><span class="filled">&#8226;</span></em>&nbsp;');
    } else {
      pagination.append('<em><span class="empty">&#8226;</span></em>&nbsp;');
    }
  }
  if(validateField(isProjectEnabled).toLowerCase() == 'no' || validateField(isProjectEnabled).toLowerCase() == 'n/a'){
    $('.project').css({'text-decoration': 'none', 'color': '#000'});
  } else {
    setEventListenerToProjectName(2);
  }
  
  
}//end populate function

//function below to populate RTBD Table
function populateRTBDTable(RTBDData) {
  //table for rtbd
  var divForRTBD = $('#tableRTBDContainer');

  var data = RTBDData;
  var tableContent = "";

  if (data.tabledata.length === 0) {
    tableContent += '<tr>' +
    '<td colspan="14">No data available</td>' +
    '</tr>';
  } else {
    $.map(data.tabledata, function (data, i) {
      // data.productionoil.plan = (data.productionoil.plan === null) ? 'N/A' : numberWithCommas(data.productionoil.plan);
      // data.productionoil.outlook = (data.productionoil.outlook === null) ? 'N/A' : numberWithCommas(data.productionoil.outlook);
	  // data.productionoil.indicator = (data.productionoil.indicator == null || data.productionoil.indicator === undefined ? "null" : data.productionoil.indicator);
	  
      // data.productiongas.plan = (data.productiongas.plan === null) ? 'N/A' : numberWithCommas(data.productiongas.plan);
      // data.productiongas.outlook = (data.productiongas.outlook === null) ? 'N/A' : numberWithCommas(data.productiongas.outlook);
	  // data.productiongas.indicator = (data.productiongas.indicator == null || data.productiongas.indicator === undefined ? "null" : data.productiongas.indicator);
	  
      // data.condy.plan = (data.condy.plan === null) ? 'N/A' : numberWithCommas(data.condy.plan);
      // data.condy.outlook = (data.condy.outlook === null) ? 'N/A' : numberWithCommas(data.condy.outlook);
	  // data.condy.indicator = (data.condy.indicator == null || data.condy.indicator === undefined ? "null" : data.condy.indicator);
	  
      // data.rtbd.plan = (data.rtbd.plan === null) ? 'N/A' : numberWithCommas(data.rtbd.plan);
      // data.rtbd.outlook = (data.rtbd.outlook === null) ? 'N/A' : numberWithCommas(data.rtbd.outlook);
	  // data.rtbd.indicator = (data.rtbd.indicator == null || data.rtbd.indicator === undefined ? "null" : data.rtbd.indicator);
	  // data.region = validateField(data.region);
	  // data.name = validateField(data.name);
	  
	  if(data.productionoil === undefined){
		data.productionoil = JSON.parse('{}');
	  } 
	  if(data.productiongas === undefined){
		data.productiongas = JSON.parse('{}');
	  }
	  if(data.condy === undefined){
		data.condy = JSON.parse('{}');
	  }
	  if(data.rtbd === undefined){
		data.rtbd = JSON.parse('{}');
	  }
	  data.productionoil.plan = numberWithCommas(data.productionoil.plan);
      data.productionoil.outlook = numberWithCommas(data.productionoil.outlook);
	  data.productionoil.indicator = validateField(data.productionoil.indicator);
	  
      data.productiongas.plan = numberWithCommas(data.productiongas.plan);
      data.productiongas.outlook = numberWithCommas(data.productiongas.outlook);
	  data.productiongas.indicator = validateField(data.productiongas.indicator);
	  
      data.condy.plan = numberWithCommas(data.condy.plan);
      data.condy.outlook = numberWithCommas(data.condy.outlook);
	  data.condy.indicator = validateField(data.condy.indicator);
	  
      data.rtbd.plan = numberWithCommas(data.rtbd.plan);
      data.rtbd.outlook = numberWithCommas(data.rtbd.outlook);
	  data.rtbd.indicator = validateField(data.rtbd.indicator);
	  data.region = validateField(data.region);
	  data.name = validateField(data.name);
    });
    //add content to the table
    $.each(data.tabledata, function (i, row) {
      tableContent += '<tr>' +
      '<td class="left rtbd-region-data">' + row.region + '</td>' +
      '<td class="left project rtbd-project-data" data-type="rtbd" data-projectname="' + row.name + '" data-projectkey="' + validateField(row.projectKey) +'">' + row.name + '</td>' +
      '<td class="right rtbd-data">' + row.productionoil.plan + '</td>' +
      '<td class="right rtbd-data">' + row.productionoil.outlook + '</td>' +
      '<td class="rtbd-data"><img src="' + returnIndicatorPath(row.productionoil.indicator) + '" alt="' + row.productionoil.indicator + '"/></td>' +
      '<td class="right rtbd-data">' + row.productiongas.plan + '</td>' +
      '<td class="right rtbd-data">' + (row.productiongas.outlook) + '</td>' +
      '<td class="rtbd-data"><img src="' + returnIndicatorPath(row.productiongas.indicator) + '" alt="' + row.productiongas.indicator + '"/></td>' +
      '<td class="right rtbd-data">' + (row.condy.plan) + '</td>' +
      '<td class="right rtbd-data">' + (row.condy.outlook) + '</td>' +
      '<td class="rtbd-data"><img src="' + returnIndicatorPath(row.condy.indicator) + '" alt="' + row.condy.indicator + '"/></td>' +
      '<td class="right rtbd-data">' + (row.rtbd.plan) + '</td>' +
      '<td class="right rtbd-data">' + (row.rtbd.outlook) + '</td>' +
      '<td class="rtbd-data"><img src="' + returnIndicatorPath(row.rtbd.indicator) + '" alt="' + row.rtbd.indicator + '"/></td>' +
      '</tr>';
    });
  }

  //create the table
  var rtbdTable = '<table id="rtbdTable" class="petronas zebra">' +
    '<thead>' +
    '	<tr>' +
    '		<th id="rtbd-region-header" rowspan="2"><span class="th-inner">Region</span></th>' +
    '		<th id="rtbd-project-header" rowspan="2"><span class="th-inner">Project</span></th>' +
    '		<th colspan="3" id="oil"><span class="th-inner">Oil&nbsp;</span></th>' +
    '		<th colspan="3" id="gas"><span class="th-inner">Gas&nbsp;</span></th>' +
    '		<th colspan="3" id="condy"><span class="th-inner">Condy&nbsp;</span></th>' +
    '		<th colspan="3" id="rtbd"><span class="th-inner">RTBD&nbsp;</span></th>' +
    '	</tr>' +
    '	<tr>' +
	'		<th class="rtbd-data"><span class="th-inner">Plan</span><span>&nbsp;</span></th>' +
    '		<th class="rtbd-data"><span class="th-inner">Outlook</span><span>&nbsp;</span></th>' +
    '		<th class="rtbd-data"><span class="th-inner">Indicator</span><span>&nbsp;</span></th>' +
    '		<th class="rtbd-data"><span class="th-inner">Plan</span><span>&nbsp;</span></th>' +
    '		<th class="rtbd-data"><span class="th-inner">Outlook</span><span>&nbsp;</span></th>' +
    '		<th class="rtbd-data"><span class="th-inner">Indicator</span><span>&nbsp;</span></th>' +
    '		<th class="rtbd-data"><span class="th-inner">Plan</span><span>&nbsp;</span></th>' +
    '		<th class="rtbd-data"><span class="th-inner">Outlook</span><span>&nbsp;</span></th>' +
    '		<th class="rtbd-data"><span class="th-inner">Indicator</span><span>&nbsp;</span></th>' +
    '		<th class="rtbd-data"><span class="th-inner">Plan</span><span>&nbsp;</span></th>' +
    '		<th class="rtbd-data"><span class="th-inner">Outlook</span><span>&nbsp;</span></th>' +
    '		<th class="rtbd-data"><span class="th-inner">Indicator</span><span>&nbsp;</span></th>' +
    '	</tr>' +
    '</thead>' +
    '<tbody>' +
    tableContent +
    '</tbody>' +
    '</table>';

  //append the table
  divForRTBD.empty().append(rtbdTable);
  setProperAlignment($('#rtbdTable tr'));
  if (data.tabledata.length === 0) {
    noDataDisplay('#rtbdTable');
  }

  var rtbdTableForSorting = $('#rtbdTable');
  rtbdTableForSorting.tablesorter({
    textExtraction : function (s) {
      if ($(s).find('img').length === 0)
        return $(s).text();
      return $(s).find('img').attr('alt');
    },
    headers : {
      //disable sorting on the following columns
      2 : {
        sorter : false
      },
      3 : {
        sorter : false
      },
      4 : {
        sorter : false
      }
    }
  });
  setHighlightOnTouch('#rtbdTable');
}

//method to populate the detailed CPB Table
function populateCPBTable(cpbData) {
  var container = $('#tableCPBContainer');
  var tableRows = '';
  // showBudgetTable(tabledata);
  var tabledata = cpbData.tabledata;

  if (tabledata.length === 0) {
    tableRows += '<tr>' +
    '<td colspan="7">No data available</td>' +
    '</tr>';
  } else {
  
    $.map(tabledata, function (data, i) {
	  data.approvedcpbequity = numberWithCommasWithoutDecimal(data.approvedcpbequity);
      data.fyytdequity = numberWithCommasWithoutDecimal(data.fyytdequity);
      data.fyyepequity = numberWithCommasWithoutDecimal(data.fyyepequity);
	  
      data.variance = (data.variance === '(null)%' || data.variance === '(null)' || data.variance === 'null' || data.variance === null || data.variance === undefined) ? 'N/A' : numberWithCommas(data.variance) + '%';
      data.indicator = (data.indicator == null || data.indicator === undefined ? "null" : data.indicator);
	  data.name = validateField(data.name);
	  data.region = validateField(data.region);
	  data.reportingdate = validateField(data.reportingdate);
    });
	
    $.each(tabledata, function (i, row) {
      tableRows += '<tr>' +
      '<td class="left">' + row.region + '</td>' +
      '<td class="left project" data-type="cpb" data-projectname="' + row.name + '" data-projectkey="' + validateField(row.projectKey) +'">' + row.name + '</td>' +
      // '<td class="left">' + row.reportingdate + '</td>' +
      '<td class="right">' + row.approvedcpbequity + '</td>' +
      '<td class="right">' + row.fyytdequity + '</td>' +
      '<td class="right">' + row.fyyepequity + '</td>' +
      '<td class="right">' + row.variance + '</td>' +
      '<td class="center"><img src="' + returnIndicatorPath(row.indicator) + '" alt="' + row.indicator + '"/></td>' +
      '</tr>';
    });

  }

  var table = '<table id="budgetTable" class="petronas zebra">' +
    '<thead>' +
    '<tr>' +
    '<th><span class="th-inner">Region</span></th>' +
    '<th><span class="th-inner">Project Name</span></th>' +
    // '<th><span class="th-inner">Reporting Date</span></th>' +
    '<th><span class="th-inner">Approved CPB<br/>Equity</span></th>' +
    '<th><span class="th-inner">FY YTD<br/>Equity</span></th>' +
    '<th><span class="th-inner">FY YEP<br/>Equity</span></th>' +
    '<th><span class="th-inner">Variance %</span></th>' +
    '<th><span class="th-inner">Indicator</span></th>' +
    '</tr>' +
    '</thead>' +
    '<tbody>' +
    tableRows +
    '</tbody>' +
    '</table>';

  container.empty().append(table);
  setProperAlignment($('#budgetTable tr'));

  if (tabledata.length === 0) {
    noDataDisplay('#budgetTable');
  }

  var budgetTable = $('#budgetTable');
  budgetTable.tablesorter({
    textExtraction : function (s) {
      if ($(s).find('img').length === 0)
        return $(s).text();
      return $(s).find('img').attr('alt');
    }
  });
  setHighlightOnTouch('#budgetTable');
}

//method to populate the detailed APC Chart
function populateAPCTable(apcData) {
  var APCTabledata = apcData.tabledata;
  var container = $('#tableAPCContainer');
  var tableRows = '';

  if (APCTabledata.length === 0) {
    tableRows += '<tr>' +
    '<td colspan="9">No data available</td>' +
    '</tr>';

  } else {
    $.map(APCTabledata, function (data, i) {
      data.APC = numberWithCommasWithoutDecimal(data.APC);
      data.ITD = numberWithCommasWithoutDecimal(data.ITD);
      data.AFC = numberWithCommasWithoutDecimal(data.AFC);
      data.phase = validateField(data.phase);
      data.variance = (data.variance === '(null)%' || data.variance === '(null)' || data.variance === 'null' || data.variance === null  || data.variance === undefined) ? 'N/A' : numberWithCommas(data.variance) + '%';
	  data.indicator = (data.indicator == null || data.indicator === undefined ? "null" : data.indicator);
	  data.name = validateField(data.name);
	  data.region = validateField(data.region);
	  data.remark = validateField(data.remark);
    });
    $.each(APCTabledata, function (i, row) {
      tableRows += '<tr>' +
      '<td class="left">' + row.region + '</td>' +
      '<td class="left project" data-type="apc" data-projectname="' + row.name + '" data-projectkey="' + validateField(row.projectKey) +'">' + row.name + '</td>' +
      '<td class="left">' + row.remark + '</td>' +
      '<td class="left">' + row.phase + '</td>' +
      '<td class="right">' + row.APC + '</td>' +
      '<td class="right">' + row.ITD + '</td>' +
      '<td class="right">' + row.AFC + '</td>' +
      '<td class="right">' + row.variance + '</td>' +
      '<td class="center"><img src="' + returnIndicatorPath(row.indicator) + '" alt="' + row.indicator + '"/></td>' +
      '</tr>';
    });
  }

  var table = '<table id="APCtable" class="petronas zebra">' +
    '<thead>' +
    '<tr>' +
    '<th><span class="th-inner">Region</span></th>' +
    '<th><span class="th-inner">Project<br/>Name</span></th>' +
    '<th><span class="th-inner">Remark</span></th>' +
    '<th><span class="th-inner">Phase</span></th>' +
    '<th><span class="th-inner">APC</span></th>' +
    '<th><span class="th-inner">VOWD/ITD</span></th>' +
    '<th><span class="th-inner">AFC</span></th>' +
    '<th><span class="th-inner">Variance %</span></th>' +
    '<th><span class="th-inner">Indicator</span></th>' +
    '</tr>' +
    '</thead>' +
    '<tbody>' +
    tableRows +
    '</tbody>' +
    '</table>';

  container.empty().append(table);
  setProperAlignment($('#APCtable tr'));
  if (APCTabledata.length === 0) {
    noDataDisplay('#APCtable');
  }

  var APCtable = $('#APCtable');
  APCtable.tablesorter({
    textExtraction : function (s) {
      if ($(s).find('img').length === 0)
        return $(s).text();
      return $(s).find('img').attr('alt');
    }
  });
  setHighlightOnTouch('#APCtable');
}

//method to populate the detailed HSE Chart
function populateHSETable(hseData) {

  var HSETabledata = hseData.tabledata;
  var container = $('#tableHSEContainer');
  var tableRows = '';

  if (HSETabledata.length === 0) {
    tableRows += '<tr>' +
    '<td colspan="6">No data available</td>' +
    '</tr>';
  } else {
    $.map(HSETabledata, function (data, i) {
      data.fatality = validateNumberField(data.fatality) === null ? 'N/A' : data.fatality;
      data.losttimeinjuries = validateNumberField(data.losttimeinjuries)  === null ? 'N/A' : data.losttimeinjuries;
      data.fireincident = validateNumberField(data.fireincident) === null ? 'N/A' : data.fireincident;
      data.totalrecordable = validateNumberField(data.totalrecordable) === null ? 'N/A' : data.totalrecordable;
	  data.name = validateField(data.name);
	  data.region = validateField(data.region);	  
    });
    $.each(HSETabledata, function (i, row) {
      tableRows += '<tr>' +
      '<td class="left">' + row.region + '</td>' +
      '<td class="left project" data-type="hse2" data-projectname="' + row.name + '" data-projectkey="' + validateField(row.projectKey) +'">' + row.name + '</td>' +
      '<td class="right">' + row.fatality + '</td>' +
      '<td class="right">' + row.losttimeinjuries + '</td>' +
      '<td class="right">' + row.fireincident + '</td>' +
      '<td class="right">' + row.totalrecordable + '</td>' +
      '</tr>';
    });
  }

  var table = '<table id="HSETable" class="petronas zebra">' +
    '<thead>' +
    '<tr>' +
    '<th><span class="th-inner">Region</span></th>' +
    '<th><span class="th-inner">Project Name</span></th>' +
    '<th><span class="th-inner">Fatality (FAR)</span></th>' +
    '<th><span class="th-inner break">Lost Time Injuries<br>(LTI)</span></th>' +
    '<th><span class="th-inner break">Fire Incident<br/>(FI)</span></th>' +
    '<th><span class="th-inner break">Total Recordable<br/>(TRC)</span></th>' +
    '</tr>' +
    '</thead>' +
    '<tbody>' +
    tableRows +
    '</tbody>' +
    '</table>';

  container.empty().append(table);
  setProperAlignment($('#HSETable tr'));
  if (HSETabledata.length === 0) {
    noDataDisplay('#HSETable');
  }

  var HSETable = $('#HSETable');
  HSETable.tablesorter({
    textExtraction : function (s) {
      if ($(s).find('img').length === 0)
        return $(s).text();
      return $(s).find('img').attr('alt');
    }
  });
  setHighlightOnTouch('#HSETable');
}

//method to populate the detailed WPB Chart
function populateWPBTable(wpbData) {
  var WPBtabledata = wpbData.tabledata;

  var container = $('#tableWPBContainer');
  var tableRows = '';

  if (WPBtabledata.length === 0) {
    tableRows += '<tr>' +
    '<td colspan="6">No data available</td>' +
    '</tr>';
  } else {
	 $.map(WPBtabledata, function (data, i) {
      data.submittedABR = (data.submittedABR === null) ? 'N/A' : numberWithCommasWithoutDecimal(data.submittedABR);
      data.approvedABR = (data.approvedABR === null) ? 'N/A' : numberWithCommasWithoutDecimal(data.approvedABR);
	  data.indicator = (data.indicator == null || data.indicator === undefined ? "null" : data.indicator);
	  data.name = validateField(data.name);
	  data.region = validateField(data.region);
	  data.reportingdate = validateField(data.reportingdate);
    });
    $.each(WPBtabledata, function (i, row) {
      tableRows += '<tr>' +
      '<td class="left">' + row.region + '</td>' +
      '<td class="left project" data-type="wpb" data-projectname="' + row.name + '" data-projectkey="' + validateField(row.projectKey) +'">' + row.name + '</td>' +
      // '<td class="left">' + row.reportingdate + '</td>' +
      '<td class="right">' + row.submittedABR + '</td>' +
      '<td class="right">' + row.approvedABR + '</td>' +
      '<td class="center"><img src="' + returnIndicatorPath(row.indicator) + '" alt="' + row.indicator + '"/></td>' +
      '</tr>';
    });
  }

  var table = '<table id="WPBtable" class="petronas zebra">' +
    '<thead class="fixedHeader">' +
    '<tr>' +
    '<th><span class="th-inner">Region</span></th>' +
    '<th><span class="th-inner">Project Name</span></th>' +
    // '<th><span class="th-inner">Reporting Date</span></th>' +
    '<th><span class="th-inner">Submitted ABR</span></th>' +
    '<th><span class="th-inner">Approved ABR</span></th>' +
    '<th><span class="th-inner">Indicator</span></th>' +
    '</tr>' +
    '</thead>' +
    '<tbody>' +
    tableRows +
    '</tbody>' +
    '</table>';

  container.empty().append(table);
  setProperAlignment($('#WPBtable tr'));
  if (WPBtabledata.length === 0) {
    noDataDisplay('#WPBtable');
  }

  $('#WPBtable').tablesorter({
    textExtraction : function (s) {
      if ($(s).find('img').length === 0)
        return $(s).text();
      return $(s).find('img').attr('alt');
    }
  });
  setHighlightOnTouch('#WPBtable');
}
