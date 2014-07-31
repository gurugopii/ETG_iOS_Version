var reportPeriod,
/*
margins and offset used for level 2 charts
 */
level2MarginLeft = 150,
level2MarginRight = 100,
level2yAxisOffset = 70,
reportingYear = '';

function populateTitleForPortfolio(projectData) {

  var data = projectData,
  reportingMonth,
  operatorship,
  phase,
  lastUpdate;

  data.reportingPeriod = validateField(data.reportingPeriod);
  data.operatorship = validateField(data.operatorship);
  data.phase = validateField(data.phase);
  data.update = validateField(data.update);
  
  if (data == 'no data') {
    reportPeriod = 'XX';
    reportingMonth = 'N/A';
    operatorship = 'N/A';
    phase = 'N/A';
    lastUpdate = 'N/A';
  } else {
    reportPeriod = (data.reportingPeriod === undefined 
		|| data.reportingPeriod.toLowerCase() === 'no data' 
		|| !(data.reportingPeriod.match(/([0-9]{4})([0-1])([0-9])([0-3])([0-9])/)) ? 'XX' 
		: data.reportingPeriod.substring(2, 4));
    reportingMonth = (data.reportingPeriod === undefined 
		|| data.reportingPeriod.toLowerCase() === 'no data' 
		|| !(data.reportingPeriod.match(/([0-9]{4})([0-1])([0-9])([0-3])([0-9])/)) ? 'No Data' 
		: monthNames[data.reportingPeriod.substring(4, 6) - 1] + ' ' + data.reportingPeriod.substring(0, 4));
	
	// reportPeriod = (data.reportingPeriod === undefined 
		// || data.reportingPeriod.toLowerCase() === 'no data' ? 'XX' 
		// : data.reportingPeriod.substring(2, 4));
    // reportingMonth = (data.reportingPeriod === undefined 
		// || data.reportingPeriod.toLowerCase() === 'no data' ? 'No Data' 
		// : monthNames[data.reportingPeriod.substring(5, 7) - 1] + ' ' + data.reportingPeriod.substring(0, 4));
    operatorship = (data.operatorship === undefined ? 'N/A' : data.operatorship);
    phase = data.phase;
    lastUpdate = data.update;

    reportingYear = data.reportingPeriod.substring(0, 4);
    // alert(reportingYear);
  }

  $('#report-period').empty().append('Reporting Period: ' + reportingMonth);
  $('#operatorship').empty().append('Operatorship: ' + operatorship);
  $('#phase').empty().append('Phase: ' + phase);
  $('#update').empty().append('Updated: ' + lastUpdate);
}

//method to populate the detailed Hydrocarbon Table
function populateHydroTable(hydroData, level, id) {
  var title = $('#hydro-title'),
  imageColumn; //variable used to offset the indicator on the table
  if (level == 1) {
    title.empty().append('First Hydrocarbon/IA (FY ' + reportPeriod + ')');
    title.on('touchend', function (e) {
      document.location = "ETGPortfolioLevel2.html?id=" + id;
    });
    imageColumn = 3; //number of columns to adjust the indicator for level 1
  } else {
    title.empty().append('First Hydrocarbon/IA (FY ' + reportPeriod + ')<img id="close-hydro" class="back" src="images/close.png" alt="Close">');
    imageColumn = 5; //number of columns to adjust the indicator for level 2
  }

  $('#close-hydro').on('touchend', function (e) {
    document.location = "ETGPortfolioLevel1.html";
  });

  var hydroMainContainer = $('#hydroMainContainer');
  var hydroTableContainer = $('#tableHydroContainer');

  var table = '<table id="hydroTable" class="petronas tablesorter">' +
    '<thead>' +
    '<tr>' +
    '<th class="td-main"><span class="th-inner">Group</span></th> ' +
    '<th class="td-main"><span class="th-inner">Region</span></th> ' +
    '<th class="td-main"><span class="th-inner">Project Name</span></th> ';

  if (level == 2) {
    table += '<th class="td-main"><span class="th-inner">Plan Date</span></th>' +
    '<th class="td-main"><span class="th-inner">Actual Date</span></th>';
  }
  table += '<th class="td-month"><span class="th-inner">Jan</span></th> ' +
  '<th class="td-month"><span class="th-inner">Feb</span></th> ' +
  '<th class="td-month"><span class="th-inner">Mar</span></th> ' +
  '<th class="td-month"><span class="th-inner">Apr</span></th> ' +
  '<th class="td-month"><span class="th-inner">May</span></th> ' +
  '<th class="td-month"><span class="th-inner">Jun</span></th> ' +
  '<th class="td-month"><span class="th-inner">Jul</span></th> ' +
  '<th class="td-month"><span class="th-inner">Aug</span></th> ' +
  '<th class="td-month"><span class="th-inner">Sep</span></th> ' +
  '<th class="td-month"><span class="th-inner">Oct</span></th> ' +
  '<th class="td-month"><span class="th-inner">Nov</span></th> ' +
  '<th class="td-month"><span class="th-inners">Dec</span></th> ' +
  //added 1105
  '<th class="td-additional"><span class="th-inners"> </span></th> ' +
  '</tr>' +
  '</thead>' +
  '<tbody>' +
  '</tbody>' +
  '</table>';

  hydroTableContainer.empty().append(table);
  var hydroTable = $('#hydroTable');
  var hydroTableBody = $('#hydroTable tbody');
  hydroTableBody.empty();

  var data = hydroData;
  if (data.length === 0) {

    var span = 16;
    if (level == 2) {
      span = 18;
    }
    var tableRows = '<tr>' +
      '<td colspan="' + span + '">No data available</td>' +
      '</tr>';

    hydroTableBody.append(tableRows);
    noDataDisplay('#hydroTable');
    //$('#hydroTable td').css('height', '554px');
    //$('#hydroTable').css('height', '3000px');
    if (level == 2) {
      $('#hydroTable').css('width', '974px');
    }
  } else {
    //pass the json data to each row in the 2 Hydrocarbon tables
      var rowCount = 0;
    $.each(data, function (i, row) {
           /*var tableRows = '<tr id="parent-row" class="rules first">' +
           '<td rowspan="2"  class="td-main left">' + validateField(row.group) + '</td>' +
           '<td rowspan="2"  class="td-main left">' + rowCount + validateField(row.region) + '</td>' +
           '<td rowspan="2"  class="td-main left project" data-type="hydro" data-projectname="' + validateField(row.name) + '" data-projectkey="' + validateField(row.projectKey) +'">' + validateField(row.name) + '</td>';
           tableRows += '<td class="td-month border-bottom"></td><td class="td-month border-bottom"> </td><td class="td-month border-bottom"> </td>' +
           '<td class="td-month border-bottom"> </td class="td-month border-bottom"><td class="td-month border-bottom"> </td><td class="td-month border-bottom"> </td>' +
           '<td class="td-month border-bottom"> </td><td class="td-month border-bottom"> </td><td class="td-month border-bottom"> </td>' +
           '<td class="td-month border-bottom"> </td><td class="td-month border-bottom"> </td><td class="td-month border-bottom"> </td></tr>';
           hydroTableBody.append(tableRows);*/
           
      var tableRows = '<tr id="parent-row" class="rules first">' +
        '<td rowspan="2"  class="td-main left">' + validateField(row.group) + '</td>' +
        '<td rowspan="2"  class="td-main left">' + validateField(row.region) + '</td>' +
        '<td rowspan="2"  class="td-main left project" data-type="hydro" data-projectname="' + validateField(row.name) + '" data-projectkey="' + validateField(row.projectKey) +'">' + validateField(row.name) + '</td>';

      if (level == 2) {
        tableRows += '<td rowspan="2"  class="td-main left">' + validateField(row.plan) + '</td>' +
        '<td rowspan="2"  class="td-main left">' + validateField(row.actualforecast) + '</th>';
      }

      tableRows += '<td class="td-month border-bottom"></td><td class="td-month border-bottom"> </td><td class="td-month border-bottom"> </td>' +
      '<td class="td-month border-bottom"> </td class="td-month border-bottom"><td class="td-month border-bottom"> </td><td class="td-month border-bottom"> </td>' +
      '<td class="td-month border-bottom"> </td><td class="td-month border-bottom"> </td><td class="td-month border-bottom"> </td>' +
      '<td class="td-month border-bottom"> </td><td class="td-month border-bottom"> </td><td class="td-month border-bottom"> </td>' +
      //added 1105
      '<td class="td-additional"> </td>' +
      '</tr>'+
      '<tr id="child-row" class="rules expand-child">' +
      '<td class="td-month"> </td><td class="td-month"> </td><td class="td-month"> </td>' +
      '<td class="td-month"> </td><td class="td-month"> </td><td class="td-month"> </td>' +
      '<td class="td-month"> </td><td class="td-month"> </td><td class="td-month"> </td>' +
      '<td class="td-month"> </td><td class="td-month"> </td><td class="td-month"> </td>' +
      //added 1105
      '<td class="td-additional"> </td>' +
      '</tr>';
        var planmConvert = new Date(validateField(row.plan));
	  var actualmConvert = new Date(validateField(row.actualforecast));
           //alert(i);
       //console.log(i)
      // console.log(planmConvert.getFullYear())
      // console.log(actualmConvert.getFullYear())
	  
	  if (planmConvert.getFullYear().toString() === reportingYear || actualmConvert.getFullYear().toString() === reportingYear) {
	    hydroTableBody.append(tableRows);
        //Jermin
        //hydroTableBody.append(tableRows);
        //Jermin
	    //Instead of text put the img with indicator
	    if (planmConvert.getFullYear() == reportingYear) {
	      console.log(planmConvert.getFullYear() + 'asdasd' + reportingYear);
	      var planm = planmConvert.getMonth() + imageColumn;
	      hydroTable.find('tbody:last tr:last').prev('tr').find('td:eq(' + planm + ')').
	      html('<img class="indicator" style="width:12px; height: 12px" src="images/bluediamond.png" alt="blue"/>');
	    }

	    if (actualmConvert.getFullYear() == reportingYear) {
	      var actualm = actualmConvert.getMonth() + 1;
	      hydroTable.find('tbody:last tr:last td:nth-child(' + actualm + ')').
	      html('<img class="indicator" style="width:12px; height: 12px" src="images/' + row.indicator + 'triangle.png" alt="' + row.indicator + '"/>');
	    }
	  }
    }); //end adding rows

	var rowEven = $('.first:even');
      rowEven.addClass('tr-even');
      rowEven.next().addClass("tr-even");

    var rowOdd = $('.first:odd');
      rowOdd.addClass('tr-odd');
      rowOdd.next().addClass("tr-odd");
	
	
    $('#hydroTable').delegate('tr', 'touchend', function () {
      var i = $(this).index() + 1;
      $('#hydroTable tr').removeClass('tr-hover');
      if (this.id == "child-row") {
        $(this).addClass('tr-hover');
        $(this).prev().addClass('tr-hover');
      } else {
        $(this).addClass('tr-hover');
        $(this).next().addClass('tr-hover');
      }
    });

      //Depending on the level disable different columns of months
      if (level == 1) {
          hydroTable.tablesorter({
            cssChildRow : "expand-child",
            headers: {
                3:{sorter:false},4:{sorter:false},5:{sorter:false},6:{sorter:false},
                7:{sorter:false},8:{sorter:false},9:{sorter:false},10:{sorter:false},
                11:{sorter:false},12:{sorter:false},13:{sorter:false},14:{sorter:false},
            }
          });
          

      } else {
          hydroTable.tablesorter({
            cssChildRow : "expand-child",
            headers: {
                5:{sorter:false},6:{sorter:false},7:{sorter:false},8:{sorter:false},
                9:{sorter:false},10:{sorter:false},11:{sorter:false},12:{sorter:false},
                13:{sorter:false},14:{sorter:false},15:{sorter:false},16:{sorter:false},
            }
        });
      }
    
    hydroTable.trigger("update");
	
	setProperAlignment($('#hydroTable tr'));
    //maintain striped table upon sort
    hydroTable.bind("sortStart", function () {
      //do your magic here
      $('.rules').removeClass("tr-even");
      $('.rules').removeClass("tr-odd");
    }).bind("sortEnd", function () {
      //when done finishing do other magic things
      var row = $('.first:even');
      row.addClass('tr-even');
      row.next().addClass("tr-even");

      var row2 = $('.first:odd');
      row2.addClass('tr-odd');
      row2.next().addClass("tr-odd");
    });
  } //end appending data
  
  if ($('#hydroTable tbody tr').length === 0) {
    var span = 16;
    if (level == 2) {
      span = 18;
    }
    var tableRows = '<tr>' +
      '<td colspan="' + span + '">No data available</td>' +
      '</tr>';

    hydroTableBody.append(tableRows);
    noDataDisplay('#hydroTable');
    $('#hydroTable td').css('height', '554px');
    if (level == 2) {
      $('#hydroTable').css('width', '974px');
    }
  }

} //end hydro carbon

//function below to populate RTBD page
function populateRTBDChart(RTBDData, level, id) {
  //getting rtbd chart options
  var RTBDChartOptions = setRTBDOption();

  if (level == 2) {
    RTBDChartOptions.chart.marginLeft = 200; //RTBD needs own marginLeft for rendering of text category
    RTBDChartOptions.chart.marginRight = level2MarginRight;
  }

    //Verify if values equal to 0 replace with null.
    for (var i in RTBDData.chartdata.rtbd) {
        for (var j in RTBDData.chartdata.rtbd[i].data) {
            if(RTBDData.chartdata.rtbd[i].data[j] == 0){
                RTBDData.chartdata.rtbd[i].data[j] = null;
            }
        }
    }
    for (var i in RTBDData.chartdata.newproduction) {
        for (var j in RTBDData.chartdata.newproduction[i].data) {
            if(RTBDData.chartdata.newproduction[i].data[j] == 0){
                RTBDData.chartdata.newproduction[i].data[j] = null;
            }
        }
    }
    
//    if(RTBDData.chartdata.rtbd[0].data[3] == 0){
//        RTBDData.chartdata.rtbd[0].data[3] = null;
//    }
//    if(RTBDData.chartdata.rtbd[1].data[3] == 0){
//        RTBDData.chartdata.rtbd[1].data[3] = null;
//    }
  //set data series for the chart
  var series = [];
  series = [{
      name : validateField(RTBDData.chartdata.newproduction[0].name),
      data : validateNumberField(RTBDData.chartdata.newproduction[0].data),
	  yAxis : 0
    }, {
      name : validateField(RTBDData.chartdata.rtbd[0].name),
      linkedTo : ':previous',
      yAxis : 1,
      data : validateNumberField(RTBDData.chartdata.rtbd[0].data)
    }, {
      name : validateField(RTBDData.chartdata.newproduction[1].name),
      data : validateNumberField(RTBDData.chartdata.newproduction[1].data),
	  yAxis : 0      
    }, {
      name : validateField(RTBDData.chartdata.rtbd[1].name),
      linkedTo : ':previous',
      data : validateNumberField(RTBDData.chartdata.rtbd[1].data),
	  yAxis : 1
    }
  ];
  console.log(series);
  RTBDChartOptions.series = series;

  //setting title of the chart
  RTBDChartOptions.title = {
    text : 'Production and RTBD Performance (FY' + reportPeriod + ')'
  };

  //render the chart
  RTBDChart = new Highcharts.Chart(RTBDChartOptions);

  /*
  variables below is used to position the renderer for each category depending on the level
   */
  var topProd, //variable used to set top position the 'New Production' category
  topRTBD, //variable used to set top position the 'RTBD' category
  font, //font size for the categories
  left; //variable used to set left position the categories
  if (level == 1) {
    nextPage(RTBDChart, id);
    topProd = 190;
    topRTBD = 240;
    font = 12;
    left = 15;
  } else {
    topProd = 240;
    topRTBD = 330;
    font = 15;
    left = 70;
    backImage(RTBDChart);
  }
  console.log(RTBDChart.series);

  //category title on the side of the chart
  RTBDChart.renderer.text('| New Production |',
    left, topProd).
  css({
    width : 100,
    color : '#000',
    textAlign : 'center',
    fontSize : font
  }).attr({
    zIndex : 999,
    rotation : -90
  }).add();
  RTBDChart.renderer.text('| RTBD |',
    left, topRTBD).
  css({
    width : 50,
    color : '#000',
    textAlign : 'center',
    fontSize : font
  }).attr({
    zIndex : 999,
    rotation : -90
  }).add();
} //end rtbd

//method to populate the detailed CPB Chart
function populateCPBChart(cpbData, level, id) {

  var CPBChartOption = setCPBOption();

  if (level == 2) {
    setMarginForLevel2(CPBChartOption);
  }
  console.log('CPB DATA');
  console.log(cpbData.chartdata);

  var newCPBJson = JSON.parse('{"chartdata": []}');

  $.each(cpbData.chartdata === undefined ? JSON.parse('[{"name":"FY YTD Actual Equity","data":[]},{"name":"Approved CPB Equity","data":[]},{"name":"FY YEP Equity","data":[]}]') : cpbData.chartdata, function (i, row) {
    var name = validateField(row.name),
    dataArray = validateNumberField(row.data);
    actualData = {
      name : name,
      data : dataArray
    };
    //check if data is complete (12 months) to render the categories on x axis properly
    if (dataArray.length < 12) {
      var missingNulls = 12 - dataArray.length;
      for (var missingIndex = 0; missingIndex < missingNulls; missingIndex++) {
        dataArray.push(null);
      }

      actualData = {
        name : name,
        data : dataArray
      };
    }
    newCPBJson.chartdata.push(actualData);
  });
  console.log(newCPBJson);
  CPBChartOption.series = newCPBJson.chartdata;

  $.each(CPBChartOption.series, function (index, row) {
    if (row.name == 'FY YTD Actual Equity') {
      CPBChartOption.series[index].legendIndex = 2;
    } else if (row.name == 'Approved CPB Equity') {
      CPBChartOption.series[index].legendIndex = 1;
    } else if (row.name == 'FY YEP Equity') {
      CPBChartOption.series[index].legendIndex = 3;
    }
  });

  if (level == 1) {
    CPBChartOption.legend.layout = 'vertical';
  }
  var budgetChart = new Highcharts.Chart(CPBChartOption);
  //set title with the Fiscal Year (for filtering purposes)
  budgetChart.setTitle({
    text : "CPB Governance (FY" + reportPeriod + ")"
  });

  if (level == 1) {
    nextPage(budgetChart, id);
  } else {
    backImage(budgetChart);
  }
} //end cpb

//method to populate the detailed APC Chart
function populateAPCChart(apcData, level, id) {
  var APCChartOptions = setAPCOption();

  if (level == 2) {
    setMarginForLevel2(APCChartOptions);
  }
  var jsonObject = apcData.chartdata === undefined ? JSON.parse('[]') : apcData.chartdata;

  //counting the number of sanction and resanction to display on the subtitle of the chart
  var sanction = 0,
  resanction = 0;
  
  apcData.tabledata == apcData.tabledata === undefined ? JSON.parse('[]') : apcData.tabledata;
  
  if (apcData.tabledata.length === 0) {}
  else {
    $.each(apcData.tabledata, function (i, row) {
      console.log(row.remark);
      if (validateField(row.remark) == 'Sanction') {
        sanction++;
      } else if (validateField(row.remark) == 'Resanction') {
        resanction++;
      }
    });
  }

  APCChartOptions.subtitle = {
    text : 'Resanction: ' + (resanction) + ' projects - Sanction: ' + (sanction) + ' projects'
  };
  var seriesOptions = [{
      name : "Performance",
      data : []
    }
  ];

  $.each(jsonObject[0].data === undefined ? JSON.parse('[]') : jsonObject[0].data, function (i, e) {

    var value = parseFloat(e);
    var color = (i === 0) ? APCChartOptions.colors[0] :
    (i === 1) ? APCChartOptions.colors[1] :
    (i === 2) ? APCChartOptions.colors[2] :
    (i === 3) ? APCChartOptions.colors[3] :
    (i === 4) ? APCChartOptions.colors[4] :
    APCChartOptions.colors[0];

    var colorpointa = {
      y : value,
      color : color

    };

    seriesOptions[0].data.push(
      colorpointa);

  });

  APCChartOptions.series = seriesOptions;

  var APCChart = new Highcharts.Chart(APCChartOptions);
  //set title with the Fiscal Year (for filtering purposes)
  APCChart.setTitle({
    text : "Approved Project Cost Governance (FY" + reportPeriod + ")"
  });

  /*
  variables below is used to render each category grouping depending on the level
   */
  var top, //used to set top position of the categories
  leftFID, //used to set left position of 'FID (APC vs AFC)' category
  leftGate, //used to set left position of 'Gate 3 (APC vs ITD )' category
  titleFID, //used to set the proper spacing for each category
  titleGate; //used to set the proper spacing for each category

  if (level == 1) {
    nextPage(APCChart, id);
    top = 305;
    leftFID = 60;
    leftGate = 320;
    titleFID = '|________FID (APC vs AFC)________|';
    titleGate = '|_Gate 3 (APC vs ITD )_|';
  } else {
    backImage(APCChart);
    top = 380;
    leftFID = 170;
    leftGate = 630;
    titleFID = '|_________________FID (APC vs AFC)_________________|';
    titleGate = '|______Gate 3 (APC vs ITD )______|';
  }
  //add below the xAxis categories on the chart

  APCChart.renderer.text(titleFID,
    leftFID, top).
  css({
    width : 450,
    color : '#000',
    textAlign : 'center',
    fontSize : 12
  }).attr({
    zIndex : 999
  }).add();
  APCChart.renderer.text(titleGate,
    leftGate, top).
  css({
    width : 350,
    color : '#000',
    textAlign : 'center',
    fontSize : 12
  }).attr({
    zIndex : 999
  }).add();
} //end apc

//method to populate the detailed HSE Chart
function populateHSEChart(hseData, level, id) {

  var HSEColumnChartOptions = setHSEOptionForPortfolio();

  if (level == 2) {
    setMarginForLevel2(HSEColumnChartOptions);
  }
  HSEColumnChartOptions.series = hseData.chartdata === undefined || hseData.chartdata[0].data === undefined  ? JSON.parse('[{"name":"LTI","data":[]}]') : hseData.chartdata;
  
  var HSEChart = new Highcharts.Chart(HSEColumnChartOptions);

  //set title with the Fiscal Year
  HSEChart.setTitle({
    text : "HSE Performance (FY" + reportPeriod + ")"
  });

  if (level == 1) {
    nextPage(HSEChart, id);
  } else {
    backImage(HSEChart);
  }
}

//method to populate the detailed WPB Chart
function populateWPBChart(wpbData, level, id) {
  var WPBLineChartOptions = setWPBOption();

  if (level == 2) {
    setMarginForLevel2(WPBLineChartOptions);
  }
  
  /*
    check if data contains negative,
	if no negative found, set the min to 0
  */
  var isDataNegative = false;
  $.each(wpbData.chartdata === undefined ? JSON.parse('[{"data":[null, null, null, null, null, null,null, null, null,null, null, null],"name":"ABRApproved"},{"data":[null, null, null, null, null, null,null, null, null,null, null, null],"name":"ABRSubmitted"}]') : wpbData.chartdata, function(outerIndex, row){
    $.each(row.data === undefined ? JSON.parse('[]') : row.data, function(innerIndex, data){
	  if(data < 0){
	    isDataNegative = true;
	  }
	});
  });
  
  if(!isDataNegative){
    WPBLineChartOptions.yAxis.min = 0;
  }
	    
  WPBLineChartOptions.series = wpbData.chartdata;
  WPBChart = new Highcharts.Chart(WPBLineChartOptions);
  //set title with the Fiscal Year (for filtering purposes)
  WPBChart.setTitle({
    text : "WPB Governance (FY" + reportPeriod + ")"
  });

  if (level == 1) {
    nextPage(WPBChart, id);
  } else {
    backImage(WPBChart);
  }
} //end wpb

function backImage(chart) {
  //rendering on top right of the chart
  chart.renderer.image('images/close.png', 960, 5, 17, 17)
  .attr({
    'class' : 'back'
  })
  .add().on('touchend', function (e) {
    document.location = "ETGPortfolioLevel1.html";
  });
}
//adding click event listener to chart title
function nextPage(chart, section) {

  chart.title.on('touchend', function (e) {
    document.location = "ETGPortfolioLevel2.html?id=" + section;
  });
}

//function to set the margin at level 2
function setMarginForLevel2(chartOption) {
  chartOption.chart.marginLeft = level2MarginLeft;
  chartOption.chart.marginRight = level2MarginRight;
//  chartOption.yAxis.title.offset = level2yAxisOffset;
}

function setEventListenerToProjectName(level){
  $('table').delegate('.project', 'click', function(){
    var self = $(this);

    var projectname = self.data('projectname');
    var projectkey = self.data('projectkey');
    var type = self.data('type');
	
	if(type == 'hydro'){
	  type = type + '' + level;
	}

	console.log('project name = ' + projectname + ' projectkey = ' + projectkey + ' type = ' + type);
	sendRequestToIOS(projectname, projectkey, type);
	//window.location = 'ETGProjectModuleLevel1.html';
                      
  });
}

function sendRequestToIOS(projectkey, projectname, type) {
  var iframe = document.createElement("IFRAME");
  iframe.setAttribute("src", "main:" + "navigateToProject:" + projectkey + ":" + projectname + ":" + type + ":");
  iframe.setAttribute("height", "1px");
  iframe.setAttribute("width", "1px");
  document.documentElement.appendChild(iframe);
  iframe.parentNode.removeChild(iframe);
  iframe = null;
}