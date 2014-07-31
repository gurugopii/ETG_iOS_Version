var reportPeriod,
indicatorFill,
margin = 100; //margin(left and right) used for level 2 charts except key milestone and rtbd
var isFromPortfolio = false;

//function below to populate title
function populateTitleForProject(jsonString) {
  var data = jsonString,
  reportingMonth,
  title,
  currency,	
  status,
  lastUpdate;

  data.currency = validateField(data.currency);
  data.status = validateField(data.status);
  data.reportName = validateField(data.reportName);
  data.reportingMonth = validateField(data.reportingMonth);
  data.phase = validateField(data.phase);
  data.phase = validateField(data.phase);
  data.update = validateField(data.update);

  if (data == 'no data') {
    reportPeriod = 'XX';
    reportingMonth = 'N/A';
    title = 'N/A';
    currency = 'N/A';
    status = 'N/A';
    lastUpdate = 'N/A';
  } else {
    reportPeriod = (data.reportingMonth === undefined ||
      data.reportingMonth.toLowerCase() === 'no data' ? 'XX'
       : data.reportingMonth.substring(2, 4));

    reportingMonth = (data.reportingMonth === undefined ||
      data.reportingMonth.toLowerCase() === 'no data' ? 'No Data'
       : monthNames[data.reportingMonth.substring(4, 6) - 1] + ' ' + data.reportingMonth.substring(0, 4));

    title = (data.reportName === undefined ? 'N/A' : data.reportName);
    currency = data.currency;
    status = data.status;
    lastUpdate = data.update;
  }

  var divForProjectTitle = $('#project-id-title');
  var divForReportingMonth = $('#reporting-month-title');
  var divForProjectStatus = $('#status-title');
  var divForCurrency = $('#currency-title');
  var divForUpdate = $('#update-title');

  divForReportingMonth.empty().prepend('<p>Reporting Period: ' + reportingMonth + '</p>');
  divForProjectTitle.empty().prepend('<p>' + title + '</p>');
  divForCurrency.empty().append('<p>Currency: ' + currency + '</p>');
  divForProjectStatus.empty().append('<p>Submission Status: ' + status + '</p>');
  divForUpdate.empty().append('<p>Updated: ' + lastUpdate + '</p>');

} //end function for populating title

//function below to populate key milestone page
function populateKeyMilestoneChart(keyMilestoneData, level, reportingMonth, id) {
  console.log("start milestone");
  //chart for key milestone
  var keyMilestoneOptions = setKeyMilestoneOption(level);
  var milestoneChart = null;
  var jsonchart = keyMilestoneData.chartdata === undefined ? JSON.parse('{"chartTitle":"Key Milestone", "chartSubtitle":"N/A","chartContents":[{"name":"Actual Progress", "data":[]},{"name":"Original Baseline", "data":[]},{"name":"Plan", "data":[]}]}') : keyMilestoneData.chartdata;

  console.log(jsonchart);

  $.each(jsonchart.chartContents, function (i, line) {
    var seriesName = validateField(line.name).toLowerCase();
    line.data = $.map(line.data, function (data, i) {

        // console.log("Name: " + data.name + " date: " + data.x + " baselineNumbefore: " + data.y);
        //Map the date to Javascript format for Highcharts Consumption
        data.x = xmlDateToJavascriptDate(data.x, true);
        console.log(data.x);
        data.name = validateField(data.name);
        if (data.x !== null && data.x !== undefined && data.y !== null && data.y !== undefined) {
          // Map baselineNum - height of data point based on the formula provided by FUNC TEAM
          // If baselineNum is smaller than 0 than it is Outlook and has green or red color
          // If baselineNum is larger than 0 that it is Baseline and has blue color
          console.log('name ' + seriesName + ' y value ' + data.y);
          data.y = Math.abs(data.y);
          if (seriesName == "actual progress" || seriesName == "plan") {
            data.y = (data.y % 4 == 1 ? -10 : data.y % 4 == 2 ? -50 : data.y % 4 == 3 ? -30 : -70);
          } else if (seriesName == "original baseline") {
            data.y = (data.y % 4 == 1 ? 10 : data.y % 4 == 2 ? 50 : data.y % 4 == 3 ? 30 : 70);
          }
          // console.log(" AFTER date " + data.x + " baselineNumbAfter: " + data.y);
          return data;
        } else {
          //IF date is null need to remove it completely
          console.log("Line removed ");
          return null;
        }
      });
  });

  keyMilestoneOptions.title = {
    text : validateField(jsonchart.chartTitle) + ' (FY' + reportPeriod + ')'
  };
  keyMilestoneOptions.subtitle = {
    text : "Project Phase: " + validateField(jsonchart.chartSubtitle)
  };

  var month = reportingMonth.substring(4, 6),
  year = reportingMonth.substring(0, 4);

  //plotting the reporting month
  keyMilestoneOptions.xAxis.plotBands = [{
      color : '#DCDCDC',
      from : Date.UTC(year, month, 1),
      to : Date.UTC(year, month, 10),
      label : {
        text : 'Reporting Month',
        x : -60,
        y : 15
      }
    }
  ];

  keyMilestoneOptions.series = jsonchart.chartContents;
  console.log('keyMilestoneOptions.series');
  console.log(keyMilestoneOptions.series);

  keyMilestoneOptions.tooltip = {
    shared : false,
    positioner: function () {   //Make the position of tooltip to be fixed on the chart.
      return { x: 80, y: 40 };
    },
    formatter : function () {

        console.log(this.point);
        
      var newdateOfTappedPoint = new Date(this.point.x),
      resultOfTappedPoint = setCorrectDateFormat(newdateOfTappedPoint, 'chart'),
//      matchOfTappedPoint = setCorrectDateFormat(newdateOfTappedPoint, 'chart'),
      matchOfTappedPoint = 'N/A';
      labelNameOfTappedPoint = this.point.name.toLowerCase(),
      titleOfTappedPoint = 'Outlook',
      titleOfMatchPoint = 'Baseline',
      seriesTapped = this.series.name;

      $.each(keyMilestoneOptions.series, function (outerIndex, outerRow) {
        if (seriesTapped !== outerRow.name) {
          $.each(outerRow.data, function (innerIndex, innerRow) {
            if (labelNameOfTappedPoint == innerRow.name.toLowerCase()) {
              matchOfTappedPoint = setCorrectDateFormat(new Date(innerRow.x), 'chart');
            }
          });
        }
      });

      if (seriesTapped == 'Original Baseline') {
        return '<b>'+this.point.name + '</b>  Baseline: <b>' + resultOfTappedPoint +
        '</b> Outlook: <b>' + matchOfTappedPoint+'</b>';
      }
        return '<b>'+this.point.name + '</b>  Baseline: <b>' + matchOfTappedPoint +
        '</b> Outlook: <b>' + resultOfTappedPoint+'</b>';

    }
  };

  for (var colorIndex = 0; colorIndex < keyMilestoneOptions.series.length; colorIndex++) {
    var nameOfSeries = validateField(keyMilestoneOptions.series[colorIndex].name).toLowerCase();
    if (nameOfSeries == "actual progress") {
      keyMilestoneOptions.series[colorIndex].marker = {
        symbol : 'triangle-down'
      };
      keyMilestoneOptions.series[colorIndex].legendIndex = 3;
      console.log('actual progress');
      console.log(keyMilestoneOptions.series[colorIndex]);
    } else if (nameOfSeries == "original baseline") {
      keyMilestoneOptions.series[colorIndex].marker = {
        symbol : 'diamond'
      };
      keyMilestoneOptions.series[colorIndex].legendIndex = 1;
    } else if (nameOfSeries == "plan") {
      keyMilestoneOptions.series[colorIndex].marker = {
        symbol : 'triangle'
      };
      keyMilestoneOptions.series[colorIndex].legendIndex = 2;
    }
  }

  console.log(keyMilestoneOptions.series);

  //offset variable used to set the timeline at the center
  //value needs to be set in order for the lines that connect to the timeline to render properly
  var offset = 0;
  if (level == 1) {
    // offset = -103;
    offset = -103;
  } else {
    offset = -148;
  }
  keyMilestoneOptions.xAxis.offset = offset;

  milestoneChart = new Highcharts.Chart(keyMilestoneOptions);
  if (level == 1) {
    nextPage(milestoneChart, id);
    milestoneChart.renderer.text('Outlook', 20, 270).css({
      fontSize : '13px',
      color : 'black'
    }).add();
  } else {
    milestoneChart.renderer.text('Outlook', 20, 350).css({
      fontSize : '13px',
      color : 'black'
    }).add();
	
	if(!isFromPortfolio || isFromPortfolio == 'N/A'){
	  backImageForKeyMilestone(milestoneChart);
	}
    
  }

  //milestone mini table
  var hydroTableContainer = $('#milestone-left-container');
  hydroTableContainer.prepend('<p>First Hydrocarbon</p>');

  var milestoneTableContainer = $('#hydro-container');

  var tabledataForHydro = validateField(keyMilestoneData.firstHydrocarbon) === 'N/A' ? JSON.parse('[]') : keyMilestoneData.firstHydrocarbon;

  var tableRows = "";

  //adding data to rows
  if (tabledataForHydro.length === 0) {
    tableRows += '<tr class="tr-normal">' +
    '<td  colspan="3">No data available</td>' +
    '</tr>';

  } else {
    $.each(tabledataForHydro, function (i, row) {
      tableRows += '<tr class="tr-normal">' +
      '<td class="left">' + validateField(row.field) + '</td>' +
      '<td class="left">' + setCorrectDateFormat(validateField(row.plan), 'table') + '</td>' +
      '<td class="left">' + setCorrectDateFormat(validateField(row.forecast), 'table') + '</td>' +
      '</tr>';
    });
  }
  //appending the table
  milestoneTableContainer.append('<table id="milestoneMiniTable" class="tablesorter petronas">' +
    '<thead>' +
    '<tr>' +
    '<th><span class="th-inner">Field</span></th>' +
    '<th><span class="th-inner">Plan</span></th>' +
    '<th><span class="th-inner">Actual / Forecast</span></th>' +
    '</tr>' +
    '</thead>' +
    '<tbody>' +
    tableRows +
    '</tbody>' +
    '</table>');
  setProperAlignment($('#milestoneMiniTable tr'));
  if (tabledataForHydro.length === 0) {
    noDataDisplay('#milestoneMiniTable');
  }

  $('#milestoneMiniTable').tablesorter({
    dateFormat : 'ddmmyyyy'
  });

  console.log('end milestone');
} //end key milestone function

//function below to populate schedule page
function populateScheduleChart(scheduleData, level, id) {
  console.log("start schedule");
  //schedule progress chart
  var scheduleChartOptions = setScheduleOption();

  // alert(level);
  if (level == 2) {
    scheduleChartOptions.chart.marginRight = margin;
    scheduleChartOptions.chart.marginLeft = margin;
  }

  scheduleData.coreinfo = scheduleData.coreinfo === undefined || scheduleData.coreinfo === null ? JSON.parse('{}') : scheduleData.coreinfo;
    console.log("SCurve Subtitle "+ scheduleData.coreinfo.plan);
    var scheduleSubtitle = "Plan: " + (numberWithCommas(validateField(scheduleData.coreinfo.plan))=='N/A' ? 'N/A' : numberWithCommas(validateField(scheduleData.coreinfo.plan))+"%") +
                        " Actual: " + (numberWithCommas(validateField(scheduleData.coreinfo.actual))=='N/A' ? 'N/A' : numberWithCommas(validateField(scheduleData.coreinfo.actual))+"%") +
                        " Variance: " + (numberWithCommas(validateField(scheduleData.coreinfo.variance))=='N/A' ? 'N/A' : numberWithCommas(validateField(scheduleData.coreinfo.variance))+"%");

  console.log(scheduleSubtitle);
  var backtoSeries = scheduleData.chartdata === undefined ? JSON.parse('[{"name":"Actuual Progress", "data":[]},{"name":"Original Baseline", "data":[]},{"name":"Plan","data":[]}]') : scheduleData.chartdata;

  console.log(backtoSeries);

  $.each(backtoSeries, function (i, line) {
    //Change map to grep. Map flattens the array of arrays.
    line.data = $.grep(line.data === undefined ? JSON.parse('[]') : line.data, function (data, i) {
        //Convert the date to Javascript format
        data[0] = xmlDateToJavascriptDate(data[0]);
        data.name = validateField(data.name);
        // data[0] = new Date(data[0]);
        // console.log(data[0])

        //If array length is more than 1 (2) then it has the y value for progress
        if (data.length > 1 && data[0] !== null) {
          return data;
          //Else it doesnot have the y value for progress and no need to be plotted on chart
        } else {
          //Return false will remove the item from array
          return false;
        }

      });
  });

  scheduleChartOptions.title = {
    text : 'Schedule Progress S-Curve (FY' + reportPeriod + ')'
  };
  scheduleChartOptions.subtitle = {
    text : scheduleSubtitle
  };
  scheduleChartOptions.series = backtoSeries;

  console.log('scheduleChartOptions.series');
  console.log(scheduleChartOptions.series);
  $.each(scheduleChartOptions.series, function (index, row) {
    if (validateField(row.name).toLowerCase() == 'plan') {
      row.legendIndex = 1;
    } else if (validateField(row.name).toLowerCase() == 'actual progress') {
      row.legendIndex = 2;
    } else if (validateField(row.name).toLowerCase() == 'original baseline') {
      row.legendIndex = 3;
    }
  });
  //render chart
  var scheduleChart = new Highcharts.Chart(scheduleChartOptions);

  if (level == 1) {
    nextPage(scheduleChart, id);
  } else {
    if(!isFromPortfolio || isFromPortfolio == 'N/A'){
      backImage(scheduleChart);
	}
  }
  console.log('end schedule');
} //end schedule chart

function populateBudgetChart(budgetData, level, id, projectPhase) {
  //chart for budget
  var budgetOptions = setBudgetOption();
  //use data from the passed parameter
  var data = budgetData.chartdata;
  var budgetTitle = "Budget Governance";
  var budgetSubtitle = "FDP: " + ((data[0].coreinfo.FDP === undefined) || (data[0].coreinfo.FDP === null) ? 'N/A' : numberWithCommas(data[0].coreinfo.FDP) + " Mil.") +
    "&nbsp;&nbsp;&nbsp;Cum VOWD: " +
    ((data[0].coreinfo.CUMVOWD === undefined) || (data[0].coreinfo.CUMVOWD === null) ? 'N/A' : numberWithCommas(data[0].coreinfo.CUMVOWD) +  " Mil.") +
    "&nbsp;&nbsp;&nbsp;YTD Actual: " +
    ((data[0].coreinfo.YTDActual === undefined) || (data[0].coreinfo.YTDActual === null) ? 'N/A' : numberWithCommas(data[0].coreinfo.YTDActual) + " Mil.");

  var dataForTableOnSide = JSON.parse('{"tabledata": []}');
  for (var z = 0; z < 4; z++) {
    if (z === 0) {
      dataForTableOnSide.tabledata.push(checkForTableDataOnChart(data[0].series, 'apc', ['APC', 'AFC']));
    } else if (z === 1) {
      dataForTableOnSide.tabledata.push(checkForTableDataOnChart(data[0].series, 'cpb', ['CPB (E)', 'YEP (E)']));
    } else if (z === 2) {
      dataForTableOnSide.tabledata.push(checkForTableDataOnChart(data[0].series, 'drilling', ['WPB (Drilling)', 'YEP (Drilling)']));
    } else if (z === 3) {
      dataForTableOnSide.tabledata.push(checkForTableDataOnChart(data[0].series, 'facilities', ['WPB (Facilities)', 'YEP (Facilities)']));
    }
  }
  // table for Budget Performance chart
  Highcharts.drawTable = function (chart) {

    console.log(chart);

    // user options
    var tableTop = 30,
    colWidth = 170,
    tableLeft = 60,
    rowHeight = 20,
    cellPadding = 1.5,
    valueDecimals = 1,
    valueSuffix = ' °C';

    // internal variables
    var series = chart.series,
    renderer = chart.renderer,
    cellLeft = tableLeft,
    tabledata = data;

    // draw category labels
    for (var i = 0; i < 2; i++) {
      var text = renderer.text(
          (i === 0) ? 'Plan' : 'Forecast',
          (i === 0) ? cellLeft + (i) * colWidth - cellPadding + 20 : cellLeft + (i) * colWidth - 10,
          tableTop + rowHeight - cellPadding + 20)
        .css({
          // fontWeight : 'bold',
          color : 'black'
        })
        .attr({
          align : 'center',
          zIndex : 10
        })
        .add();

    }

    /*
    variables below are used to set values that would render properly on each level
     */
    var verticalLine, //height used to draw vertical line as divider to the table
    heightArray = [], //height used to draw the table cells (rectangle with proper color)
    topArray = [], //used as the starting position for each rectangle to be rendered
    padding, //used to add padding to rendering values in the table
    fill;

    // alert(level);
    if (level === 1) {
      verticalLine = 260;
      heightArray = [30, 40, 45, 45, 45];
      topArray = [50, 70, 120, 165, 215];
      padding = 30;
    } else {
      verticalLine = 325;
      heightArray = [40, 50, 70, 70, 70];
      topArray = [40, 65, 140, 210, 280];
      padding = 20;
    }

    //vertical table line
    renderer.rect(150, 50, 1, verticalLine, 0)
    .attr({
      'stroke-width' : 0.5,
      stroke : 'white',
      fill : 'transparent',
      zIndex : 3
    })
    .add();

    /*adding header background to the table*/
    renderer.rect(10, topArray[0], 280, heightArray[0], 0)
    .attr({
      'stroke-width' : 0.5,
      stroke : '#FFF',
      fill : '#CDFFEE'
    })
    .add();

    //below loop is used to render 4 rectangles that will serve as the background
    var length = heightArray.length;
    for (var colorIndex = i; colorIndex < length; colorIndex++) {
      if (colorIndex % 2 === 0) {
        fill = '#F3F3F3';
      } else {
        fill = '#FFF';
      }
      renderer.rect(10, topArray[colorIndex], 280, heightArray[colorIndex], 0)
      .attr({
        'stroke-width' : 0.5,
        stroke : '#FFF',
        fill : fill
      })
      .add();
    }

    $.each(dataForTableOnSide.tabledata, function (i, serie) {
      var value =  - (i + 1 - dataForTableOnSide.tabledata.length);
      var point = chart.series[0].data[value];
      var pointwidth = parseFloat(point.pointWidth);
      var barheight = parseFloat(point.plotX);

      for (var row = 0; row < 2; row++) {

        // Apply the value
        var numValue = renderer.text(
            (row === 0) ? serie.planvalue : serie.forecastvalue,
            (row === 0) ? cellLeft + (row) * colWidth - cellPadding + 20 : cellLeft + (row) * colWidth - 10,
            barheight + pointwidth + cellPadding + 30 + padding)
          .css({
            color : '#000'
          })
          .attr({
            align : 'center',
            'class' : 'sideTable' + i + ' sideTable'
          })
          .add();

//        setOnclick(numValue, i);

        // Apply the name
        var head = renderer.text(
            (row === 0) ? serie.plandescription : serie.forecastdescription,
            (row === 0) ? cellLeft + (row) * colWidth - cellPadding + 20 : cellLeft + (row) * colWidth - 10,
            barheight + pointwidth + cellPadding + 15 + padding)
          .css({
            color : '#000'
          })
          .attr({
            align : 'center',
            'class' : 'sideTable' + i + ' sideTable'
          })
          .add();

//        setOnclick(head, i);
      }

    });
  };

  //Budget performance chart
  budgetOptions.title = {
    text : budgetTitle + ' (FY' + reportPeriod + ')'
  };
  budgetOptions.subtitle = {
    text : budgetSubtitle,
    useHTML : true
  };

  //data array to be used for the chart
  var chartData = [];

  for (var i = 0; i < 4; i++) {
    if (i === 0) {
      chartData.push(checkForDataForChart(data[0].series, 'apc', 'APC vs AFC'));
    } else if (i == 1) {
      chartData.push(checkForDataForChart(data[0].series, 'cpb', 'CPB (E) vs YEP (E)'));
    } else if (i == 2) {
      chartData.push(checkForDataForChart(data[0].series, 'drilling', 'WPB(Drilling) vs YEP(Drilling)'));
    } else if (i == 3) {
      chartData.push(checkForDataForChart(data[0].series, 'facilities', 'WPB (Facilities) vs YEP (Facilities)'));
    }
  }

  console.log('BUDGET CHART DATA');
  console.log(chartData);
  console.log(projectPhase);

  var seriesOptions = [{
      name : "Variance",
      data : []
    }
  ];

  //manipulate data for the chart
  $.each(chartData, function (i, bar) {
    var name = validateField(bar.name);
    var value = parseFloat(validateField(bar.data)),
    phase = validateField(projectPhase).toLowerCase(),
    forecast = bar.forecast === undefined || bar.forecast === null ? 0 : (bar.forecast);
    plan = bar.plan === undefined || bar.plan === null ? 0 : (bar.plan);

    //var pattern = new RegExp('\\b' + identifier);
    var color = (value < 0) ? budgetOptions.colors[0] : budgetOptions.colors[1];

    if (name.toLowerCase().match(/\bfacilities/) !== null || name.toLowerCase().match(/\bdrilling/) !== null) {
      if (value > 10) {
        color = budgetOptions.colors[1];
      } else {
        color = budgetOptions.colors[0];
      }
    } else if (name.toLowerCase().match(/\bapc/) !== null) {
      if (value > 10 && (phase.match(/\bfid rev 0/) !== null || phase.match(/\bgate 3/) !== null || phase.match(/\bpre-dev/) !== null) ||
        value > 0 && !(phase.match(/\bfid rev 0/) !== null || phase.match(/\bgate 3/) !== null || phase.match(/\bpre-dev/) !== null)) {
        color = budgetOptions.colors[1];
      } else {
        color = budgetOptions.colors[0];
      }
    } else if (name.toLowerCase().match(/\bcpb/) !== null) {

      if (parseFloat(plan) < parseFloat(forecast)) {
        color = budgetOptions.colors[1];
      } else {
        color = budgetOptions.colors[0];
      }

    }

    var colorpointa = {
      name : name,
      y : value,
      color : color
    };

    seriesOptions[0].data.push(colorpointa);
  });

  //populate budget chart with data
  budgetOptions.series = seriesOptions;
  budgetPerfChart = new Highcharts.Chart(budgetOptions);
  if (level == 1) {
    nextPage(budgetPerfChart, id);
  } else {
    if(!isFromPortfolio || isFromPortfolio == 'N/A'){
      backImage(budgetPerfChart);
	}
  }
  // console.log('budgetPerfChart.series');
  console.log(budgetPerfChart.series);
  Highcharts.drawTable(budgetPerfChart);

//  $('.tr-normal').on('touchend', function () {
//    var i = $(this).index();
//    setSelected('sideTable' + i, i);
//  });

} //end budget

//check if data for table is complete for budget
//if data is incomplete, the fill in the missing data for table
function checkForTableDataOnChart(data, identifier, description) {
  var isPresent = false;
  var tableRow;
  $.each(data, function (i, row) {
    var pattern = new RegExp('\\b' + identifier),
    planDescription = validateField(row.plandescription);

    if (planDescription.toLowerCase().match(pattern) !== null) {
      tableRow = {
        plandescription : planDescription,
        planvalue : numberWithCommasWithoutDecimal(validateField(row.planvalue)),
        forecastdescription : validateField(row.forecastdescription),
        forecastvalue : numberWithCommasWithoutDecimal(validateField(row.forecastvalue)),
        forecastvariance : numberWithCommas(validateField(row.forecastvariance)),
        indicator : validateField(row.indicator)
      };
      isPresent = true;
    }
  });
  if (!isPresent) {
    tableRow = {
      plandescription : validateField(description[0]),
      planvalue : numberWithCommas(null),
      forecastdescription : validateField(description[1]),
      forecastvalue : numberWithCommas(null),
      forecastvariance : '',
      indicator : ''
    };
  }
  return tableRow;
}

//check if data for chart is complete for budget
//if data is incomplete, the fill in the missing data for chart
function checkForDataForChart(data, identifier, title) {
  var isPresent = false;
  var bar;
  $.each(data, function (i, row) {
    var pattern = new RegExp('\\b' + identifier);
    if (validateField(row.plandescription).toLowerCase().match(pattern) !== null) {
      bar = {
        name : validateField(row.plandescription) + ' vs ' + validateField(row.forecastdescription),
        data : validateField(row.forecastvariance),
        forecast : validateField(row.forecastvalue),
        plan : validateField(row.planvalue)
      };
      isPresent = true;
    }
  });

  if (!isPresent) {
    bar = {
      name : title,
      data : null,
      forecast : null,
      plan : null
    };
  }
  return bar;
}



//function below to populate AFE page
function populateAFEChart(AFEData, level, id) {
  var afeTitle = $('#afe-title');
  if (level == 2) {
    if (!isFromPortfolio || isFromPortfolio == 'N/A') {
      afeTitle.append('AFE Governance (FY ' + reportPeriod + ')<img id="close-button" class="back" src="images/close.png" alt="Close">');
      $('#close-button').on('touchend', function (e) {
        document.location = "ETGProjectModuleLevel1.html";
      });
    } else {
      afeTitle.append('AFE Governance (FY ' + reportPeriod + ')');
    }

  } else {
    afeTitle.append('AFE Governance (FY ' + reportPeriod + ')');
    afeTitle.on('touchend', function (e) {
      document.location = "ETGProjectModuleLevel2.html?id=" + id;
    });
  }

  //afe summary table
  var AFETableContainer = $('#chartAFEContainer');
  var data = AFEData.chartdata === undefined ? JSON.parse('[]') : AFEData.chartdata;
  var tableRows = "";

  if (data.length === 0) {
    tableRows += '<tr>' +
    '<td colspan="3">No data available</td>' +
    '</tr>';
  } else {

    $.map(data, function (dataRow, i) {
      dataRow.AFE = (dataRow.AFE === null || dataRow.AFE === undefined) ? 'N/A' : dataRow.AFE;
      dataRow.Indicator = validateField(dataRow.Indicator);
      dataRow.Status = validateField(dataRow.Status);
    });
    /*
    sorting data by color: Green, Yellow, Red
     */
    var dataWithGreenIndicator = JSON.parse('{"data": []}'),
    dataWithYellowIndicator = JSON.parse('{"data": []}'),
    dataWithRedIndicator = JSON.parse('{"data": []}'),
    dataWithOtherIndicator = JSON.parse('{"data": []}');
    $.each(data, function (i, row) {
      var ind = row.Indicator.toLowerCase(),
      data = '{"AFE":"' + (row.AFE) + '", ' +
        '"Indicator":"' + (row.Indicator) + '",' +
        '"Status":"' + (row.Status) + '"' +
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

    //add rows to table
    $.each(sortedJsonForTable.tableData, function (outerIndex, outerRow) {
      $.each(outerRow.data, function (innerIndex, innerRow) {
        var statusArray = innerRow.Status.split(',');

        var finalStatus = '';
        var statusLength = statusArray.length;
        $.each(statusArray, function (statusIndex, statusRow) {
          if (statusIndex == statusLength - 1) {
            finalStatus += statusRow + '<br/>';
          } else {
            finalStatus += statusRow + ';<br/>';
          }
        });

        tableRows += '<tr>' +
        '<td class="left">' + finalStatus + '</td>' +
        '<td><img src="' + returnIndicatorPath(innerRow.Indicator) + '" alt="' + innerRow.Indicator + '"/></td>' +
        '<td>' + (innerRow.AFE) + '</td>' +
        '</tr>';
      });
    });
  }

  //append the table
  AFETableContainer.empty();
  AFETableContainer.append('<table id="AFESummaryTable" class="petronas">' +
    '<thead>' +
    '   <tr>' +
    '     <th><span class="th-inner">Status</span></th>' +
    '     <th><span class="th-inner">Indicator</span></th>' +
    '    <th><span class="th-inner">No. of AFE</span></th>' +
    '</tr>' +
    '</thead>' +
    '<tbody>' +
    tableRows +
    '</tbody>' +
    '</table>');
	
	setProperAlignment($('#AFESummaryTable tr'));

  if (data.length === 0) {
    noDataDisplay('#AFESummaryTable');
  }

  $('#AFESummaryTable').tablesorter({
    textExtraction : function (s) {
      if ($(s).find('img').length === 0)
        return $(s).text();
      return $(s).find('img').attr('alt');
    }
  });

  setHighlightOnTouch('#AFESummaryTable');

} //end afe chart

//function below to populate RTBD page
function populateRTBDChart(RTBDData, level, id) {
  //rtbd chart
  var RTBDChartOptions = setRTBDOption();

  if (level == 2) {
    RTBDChartOptions.chart.marginLeft = 200;
    RTBDChartOptions.chart.marginRight = margin;
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
  var series = [];

  series = [{
      name : validateField(RTBDData.chartdata.newproduction[1].name),
      data : validateNumberField(RTBDData.chartdata.newproduction[1].data),
      yAxis : 0
    }, {
      name : validateField(RTBDData.chartdata.rtbd[1].name),
      data : validateNumberField(RTBDData.chartdata.rtbd[1].data),
      linkedTo : ':previous',
      yAxis : 1
    }, {
      name : validateField(RTBDData.chartdata.newproduction[0].name),
      data : validateNumberField(RTBDData.chartdata.newproduction[0].data),
      yAxis : 0
    }, {
      name : validateField(RTBDData.chartdata.rtbd[0].name),
      data : RTBDData.chartdata.rtbd[0].data,
      linkedTo : ':previous',
      yAxis : 1
    }
  ];

  RTBDChartOptions.series = series;

  RTBDChartOptions.title = {
    text : 'Production and RTBD Performance (FY' + reportPeriod + ')'
  };

  //render the chart
  RTBDChart = new Highcharts.Chart(RTBDChartOptions);

  console.log(RTBDChart.series);

  /*
  variables below is used to position the renderer for each category depending on the level
   */
  var topNewProd, //variable used to set top position the 'New Production' category
  topRTBD, //variable used to set top position the 'RTBD' category
  left, //variable used to set left position the categories
  font; //font size for the categories
  if (level == 1) {
    topNewProd = 180;
    topRTBD = 240;
    font = 12;
    left = 15;
  } else {
    topNewProd = 240;
    topRTBD = 330;
    font = 15;
    left = 70;
  }

  //category title on the side of the chart
  RTBDChart.renderer.text('| New Production |',
    left, topNewProd).
  css({
    width : 100,
   // color : '#999',
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
   // color : '#999',
    textAlign : 'center',
    fontSize : font
  }).attr({
    zIndex : 999,
    rotation : -90
  }).add();

  if (level == 1) {
    nextPage(RTBDChart, id);
  } else {
    if (!isFromPortfolio || isFromPortfolio == 'N/A') {
	  backImage(RTBDChart);
	}
    
  }
} //end rtbd

function populateRiskAndOpportunityChart(riskAndOpportunityTableData, level, id) {
  var riskTitle = $('#riskAndOpMainTitle');
  if (level == 1) {
    riskTitle.append('Risk & Opportunity Impact (FY ' + reportPeriod + ')');
    riskTitle.on('touchend', function (e) {
      document.location = "ETGProjectModuleLevel2.html?id=" + id;
    });
  } else {
    if (!isFromPortfolio || isFromPortfolio == 'N/A') {
      riskTitle.append('Risk & Opportunity Impact (FY ' + reportPeriod + ')<img id="close-riskOp" class="back" src="images/close.png" alt="Close">');
      $('#close-riskOp').on('touchend', function (e) {
        document.location = "ETGProjectModuleLevel1.html";
      });
    } else {
	  riskTitle.append('Risk & Opportunity Impact (FY ' + reportPeriod + ')');
	}
  }

  var riskSummaryContainer = $('#chartRiskContainer');
  var opportunitySummaryContainer = $('#chartOpportunityContainer');

  //risk summary table
  var Riskdata = riskAndOpportunityTableData.chartdata.risk;
  var riskTableRow = "";
  if (Riskdata.length === 0) {
    riskTableRow += '<tr>' +
    '<td colspan="3">No data available</td>' +
    '</tr>';
  } else {

    $.map(Riskdata, function (data, i) {
      data.Cost = (data.Cost === null || data.Cost === undefined) ? 'N/A' : numberWithCommas(data.Cost);
      data.Prod = (data.Prod === null || data.Prod === undefined) ? 'N/A' : numberWithCommas(data.Prod);
      data.Cluster = validateField(data.Cluster);
    });
    //populating summary risk rows with data

    $.each(Riskdata, function (i, row) {
      riskTableRow += '<tr>' +
      '<td class="left">' + row.Cluster + '</td>' +
      '<td class="right">' + row.Cost + '</td>' +
      '<td class="right">' + row.Prod + '</td>' +
      '</tr>';
    });
  }

  //creating the summary risk table
  var riskTable = '<table id="riskSummaryTable" class="petronas tablesorter">' +
    '<caption>Risk</caption>' +
    '<thead>' +
    '<tr>' +
    '<th><span="th-inner">Cluster</span></th>' +
    '<th><span="th-inner">Cost</span></th>' +
    '<th><span="th-inner">Production (kboed)</span></th>' +
    '</tr>' +
    '</thead>' +
    '<tbody>' +
    riskTableRow +
    '</tbody>' +
    '</table>';

  riskSummaryContainer.empty().append(riskTable);
  setProperAlignment($('#riskSummaryTable tr'));
  if (Riskdata.length === 0) {
    noDataDisplay('#riskSummaryTable');
  }

  //opportunity table summary
  var Opportunitydata = riskAndOpportunityTableData.chartdata.opportunity;
  var opportunityRow = "";

  if (Opportunitydata.length === 0) {
    opportunityRow += '<tr>' +
    '<td colspan="3">No data available</td>' +
    '</tr>';
  } else {
    $.map(Opportunitydata, function (data, i) {
      data.Cst = (data.Cst === null || data.Cst === undefined) ? 'N/A' : numberWithCommas(data.Cst);
      data.Prd = (data.Prd === null || data.Prd === undefined) ? 'N/A' : numberWithCommas(data.Prd);
      data.Clust = validateField(data.Clust);
    });
    //populating summary opportunity table with data
    $.each(Opportunitydata, function (i, row) {
      opportunityRow += '<tr>' +
      '<td class="left">' + row.Clust + '</td>' +
      '<td class="right">' + row.Cst + '</td>' +
      '<td class="right">' + row.Prd + '</td>' +
      '</tr>';
    });
  }

  //creating the summary opportunity table
  var opportunityTable = '<table id="opportunitySummaryTable" class="petronas tablesorter">' +
    '<caption>Opportunity</caption>' +
    '<thead>' +
    '<tr>' +
    '<th>Cluster</th>' +
    '<th>Cost</th>' +
    '<th>Production (kboed)</th>' +
    '</tr>' +
    '</thead>' +
    '<tbody>' +
    opportunityRow +
    '</tbody>' +
    '</table>';

  opportunitySummaryContainer.empty().append(opportunityTable);
  setProperAlignment($('#opportunitySummaryTable tr'));
  if (Opportunitydata.length === 0) {
    noDataDisplay('#opportunitySummaryTable');
  }

  var riskSummaryTable = $('#riskSummaryTable');
  riskSummaryTable.tablesorter({
    sortList : [[2, 0], [1, 0]]
  });
  $('#riskSummaryTable tr:nth-child(n+4)').remove();
  riskSummaryTable.trigger('update');
  $('#riskSummaryTable thead th').removeClass('tablesorter-headerAsc');

  var opportunitySummaryTable = $('#opportunitySummaryTable');
  opportunitySummaryTable.tablesorter({
    sortList : [[2, 1], [1, 1]]
  });
  $('#opportunitySummaryTable tr:nth-child(n+4)').remove();
  opportunitySummaryTable.trigger('update');
  $('#opportunitySummaryTable thead th').removeClass('tablesorter-headerDesc');

  setHighlightOnTouch('#riskSummaryTable');
  setHighlightOnTouch('#opportunitySummaryTable');
}

//function below to populate hse page
function populateHSEChart(HSEData, level, id) {

  console.log('START HSE');
  var fatalityCount = 0;
  //hse table
  var dataTable = HSEData.tabledata === undefined ? JSON.parse('[]') : HSEData.tabledata;

  var dataChart = JSON.parse('{"categories":[],"ytdFrequencies":[],"kpi":[]}');
  var kpiIndexNull = [];
  var ytdIndexNull = [];
  //add data to hse table
  $.each(dataTable, function (index, row) {
    dataChart.categories.push(row.HSEID === undefined || row.HSEID === null || row.HSEID === 'null' ? 'N/A' : row.HSEID);
    dataChart.ytdFrequencies.push(Number(row.ytdfrequency === undefined || row.ytdfrequency === null || row.ytdfrequency === 'null' ? null : row.ytdfrequency));
    if (row.ytdfrequency === undefined || row.ytdfrequency === null || row.ytdfrequency === 'null') {
      ytdIndexNull.push(index);
    }
    dataChart.kpi.push(Number(row.kpi === undefined || row.kpi === null || row.kpi === 'null' ? null : row.kpi));
    if (row.kpi === undefined || row.kpi === null || row.kpi === 'null') {
      kpiIndexNull.push(index);
    }
    if (validateField(row.HSEID) === 'FAR') {
      fatalityCount = row.ytdcase === undefined || row.ytdcase === null || row.ytdcase === 'null' ? 'N/A' : row.ytdcase;
    }
  });
  console.log('hse dataChart');
  console.log(dataChart);
  console.log(kpiIndexNull);

  var isDataEmpty = false;
  if (dataTable.length === 0) {
    isDataEmpty = true;
    fatalityCount = 'N/A';
  }

  //hse chart
  var HSEChartOptions = setHSEOptionForProject(level, isDataEmpty, dataChart.categories, kpiIndexNull);
  if (level == 2) {
    HSEChartOptions.chart.marginRight = margin;
    HSEChartOptions.chart.marginLeft = margin;
  }
  //setting subtitle to the chart
  var fatality = '<font style="color:red;">Fatality: ' + numberWithCommas(fatalityCount)+'</font>';
  var manHour = '&nbsp;&nbsp;Total Man Hour: ' + numberWithCommas(HSEData.chartdata[0].totalManHour) + ' hr';

  //setting the data series to the chart
  var kpiArray = dataChart.kpi;
  var seriesData = dataChart.ytdFrequencies;

  HSEChartOptions.subtitle = {
    text : fatality + ' ' + manHour,
    useHTML : true
  };
  HSEChartOptions.series = [{
      data : kpiArray,
      color : 'transparent',
      name : 'KPI'
    }, {
      name : "HSE Criteria",
      data : seriesData,
      color : '#82b4e0'
    }
  ];

  HSEChartOptions.tooltip = {
    formatter : function () {
      var barTappedCategory = this.x,
      criteria = '',
      kpi = 0,
      ytd = 0;
      $.each(dataTable, function (index, row) {
        if (barTappedCategory == row.HSEID) {
          criteria = validateField(row.hsecriteria);
          kpi = validateNumberField(row.kpi);
          ytd = numberWithCommas(validateNumberField(row.ytdfrequency));
        }
      });

      return '<b>HSE Criteria: </b> ' + criteria + '<br/>' +
      '<b>YTD Frequency: </b> ' + ytd + '<br/>' +
      '<b>KPI: </b> ' + numberWithCommas(kpi);
    }
  };

  HSEChartOptions.title = {
    text : 'HSE Performance (FY' + reportPeriod + ')'
  };
  //rendering the chart
  HSEChart = new Highcharts.Chart(HSEChartOptions);

  if (level == 1) {
    nextPage(HSEChart, id);
  } else {
    if (!isFromPortfolio || isFromPortfolio == 'N/A') {
	  backImage(HSEChart);
	}
    
  }
} //end hse

//function below is used to display PPMS Review table
function populatePPMSReviewTable(PPMSReviewTableData, level, id) {
  console.log('START PPMS');
  var ppmsTitle = $('#ppms-title');
  if (level == 2) {
    if (!isFromPortfolio || isFromPortfolio == 'N/A') {
	  ppmsTitle.append('PPMS Review Summary (FY ' + reportPeriod + ')<img id="close-ppms" class="back" src="images/close.png" alt="Close">');
	  $('#close-ppms').on('touchend', function (e) {
	    document.location = "ETGProjectModuleLevel1.html";
	  });
	} else {
	  ppmsTitle.append('PPMS Review Summary (FY ' + reportPeriod + ')');
	}
    
  } else {
    ppmsTitle.append('PPMS Review Summary (FY ' + reportPeriod + ')');
    ppmsTitle.on('touchend', function (e) {
      document.location = "ETGProjectModuleLevel2.html?id=" + id;
    });
  }

  var PPMSReviewTableContainer = $('#tablePPMSContainer');

  //PPMS table
  var PPMSdata = PPMSReviewTableData;

  var PPMSTableRow = "";

  if (PPMSdata.length === 0) {
    PPMSTableRow += '<tr>' +
    '<td colspan="3">No data available</td>' +
    '</tr>';
  } else {
    $.map(PPMSdata, function (data, i) {
      data.Percentage = (data.Percentage === '(null)%' || data.Percentage === '(null)' || data.Percentage === 'null' || data.Percentage === undefined) ? 'N/A' : numberWithCommas(data.Percentage) + '%';
      data.indicator = (data.Ind === null || data.Ind === undefined ? "null" : data.Ind);
      data.Status = validateField(data.Status);
    });

    var newPPMSJson = JSON.parse('{"tabledata":[]}'),
    forecastString = JSON.parse('{"data":[]}'),
    completedClosedString = JSON.parse('{"data":[]}'),
    conditionalString = JSON.parse('{"data":[]}'),
    completedOpenString = JSON.parse('{"data":[]}'),
    overdueString = JSON.parse('{"data":[]}'),
    otherString = JSON.parse('{"data":[]}'),
    isOtherDataAvailable = false;

    $.each(PPMSdata, function (i, row) {
      var data = row.Status.toLowerCase(),
      newData = JSON.parse('{"indicator":"' + row.Ind + '","status":"' + row.Status + '","percentage":"' + row.Percentage + '"}');

      if (data == 'forecasted') {
        forecastString.data.push(newData);
      } else if (data == 'completed and closed action items') {
        completedClosedString.data.push(newData);
      } else if (data == 'conditional completion and closed action items') {
        conditionalString.data.push(newData);
      } else if (data == 'completed with open action items') {
        completedOpenString.data.push(newData);
      } else if (data.match(/\boverdue.*/) !== null) {
        overdueString.data.push(newData);
      } else {
        otherString.data.push(newData);
      }
    });

    newPPMSJson.tabledata.push(forecastString);
    newPPMSJson.tabledata.push(overdueString);
    newPPMSJson.tabledata.push(completedClosedString);
    newPPMSJson.tabledata.push(conditionalString);
    newPPMSJson.tabledata.push(completedOpenString);
    newPPMSJson.tabledata.push(otherString);

    console.log(newPPMSJson);

    $.each(newPPMSJson.tabledata, function (outerIndex, outerRow) {
      $.each(outerRow.data, function (innerIndex, innerRow) {
        PPMSTableRow += '<tr>' +
        '<td class="ppms-other-column center">' + '<img class="indicator" src="' + returnPPMSIndicatorPath(innerRow.indicator) + '" alt="' + innerRow.indicator + '"/>' + '</td>' +
        '<td class="left ppms-status-column">' + innerRow.status + '</td>' +
        '<td class="right ppms-other-column">' + innerRow.percentage + '</td>' +
        '</tr>';
      });
    });
  }

  var PPMSTable = '<table id="PPMSReviewTable" class="petronas tablesorter">' +
    // '<caption>PPMS Review Summary (FY '+ reportPeriod +')</caption>' +
    '<thead>' +
    '<tr>' +
    '<th class="ppms-other-column-header"><span class="th-inner">Indicator</span></th>' +
    '<th class="ppms-status-column"><span class="th-inner">Status</span></th>' +
    '<th class="ppms-other-column-header"><span class="th-inner">Percentage</span></th>' +
    '</tr>' +
    '</thead>' +
    '<tbody>' +
    PPMSTableRow +
    '</tbody>' +
    '</table>';

  PPMSReviewTableContainer.empty().append(PPMSTable);
  setProperAlignment($('#PPMSReviewTable tr'));
  if (PPMSdata.length === 0) {
    noDataDisplay('#PPMSReviewTable');
  }

  $('#PPMSReviewTable').tablesorter({
    textExtraction : function (s) {
      if ($(s).find('img').length === 0)
        return $(s).text();
      return $(s).find('img').attr('alt');
    }
  });
  setHighlightOnTouch('#PPMSReviewTable');
    
    console.log('END PPMS');
}

function returnPPMSIndicatorPath(indicator) {
  if (indicator.toLowerCase() == "bluebinocs") {
    return "images/04 Blue Binocs.png";
  } else if (indicator.toLowerCase() == "redcross") {
    return "images/red.png";
  } else if (indicator.toLowerCase() == "gray") {
    return "images/grey.png";
  } else if (indicator.toLowerCase() == "yellowexclamation") {
    return "images/yellow.png";
  } else if (indicator.toLowerCase() == "greentick") {
    return "images/green.png";
  } else if (indicator.toLowerCase() == "orangeflag") {
    return "images/orangeFlag.png";
  }
  return "images/transparent.png";
}

//adding click event listener to chart title
function nextPage(chart, section) {
  indicatorFill = section;
  chart.title.on('touchend', function (e) {
    document.location = "ETGProjectModuleLevel2.html?id=" + section;
  });
}

function backImageForKeyMilestone(chart) {
  //rendering on top right of the chart
  chart.renderer.image('images/close.png', 615, 5, 17, 17)
  .attr({
    'class' : 'back'
  })
  .add().on('touchend', function (e) {
    //back to portfolio
	  document.location = "ETGProjectModuleLevel1.html";
	
  });
}

function backImage(chart) {
  //rendering on top right of the chart
  chart.renderer.image('images/close.png', 960, 5, 17, 17)
  .attr({
    'class' : 'back'
  })
  .add().on('touchend', function (e) {
    //back to portfolio
	  document.location = "ETGProjectModuleLevel1.html";
	
    // document.location = "ETGProjectModuleLevel1.html";
  });
}

function validateBudgetData(budgetData) {

  if(budgetData.chartdata === undefined || budgetData.chartdata === 'disabled'){
    return JSON.parse('{"chartdata":[{"coreinfo":{"FDP":"N/A", "Cum VOWD":"N/A","YTD Actual":"N/A"},' +
        '"series":[' +
        ']}], "tabledata":' +
        '[{"coreinfo":{"FDP":"N/A", "Cum VOWD":"N/A","YTD Actual":"N/A"},' +
        '"series":[' +
        ']}]' +
        '}');
  }
  
  budgetData.chartdata[0] = budgetData.chartdata[0] === undefined ? JSON.parse('[]') : budgetData.chartdata[0];
  budgetData.chartdata[0].coreinfo = budgetData.chartdata[0].coreinfo === undefined ? JSON.parse('{}') : budgetData.chartdata[0].coreinfo;
  budgetData.chartdata[0].series = budgetData.chartdata[0].series === undefined ? JSON.parse('[]') : budgetData.chartdata[0].series;

  $.map(budgetData.chartdata[0].coreinfo, function (data, index) {
    data.FDP = data.FDP === undefined ||
      data.FDP === null ? 'N/A'
       : data.FDP;
    data.CUMVOWD = data.CUMVOWD === undefined ||
      data.CUMVOWD === null ? 'N/A'
       : data.CUMVOWD;
    data.YTDActual = data.YTDActual === undefined ||
      data.YTDActual === null ? 'N/A'
       : data.YTDActual;

  });

  $.map(budgetData.chartdata[0].series, function (data, index) {
    data.plandescription = data.plandescription === undefined ||
      data.plandescription === null ? 'N/A'
       : data.plandescription;
    data.planvalue = data.planvalue === undefined ||
      data.planvalue === null ? 'N/A'
       : data.planvalue;
    data.forecastdescription = data.forecastdescription === undefined ||
      data.forecastdescription === null ? 'N/A'
       : data.forecastdescription;
    data.forecastvalue = data.forecastvalue === undefined ||
      data.forecastvalue === null ? 'N/A'
       : data.forecastvalue;
    data.forecastvariance = data.forecastvariance === undefined ||
      data.forecastvariance === null ? 'N/A'
       : data.forecastvariance;
    data.indicator = data.indicator === undefined ||
      data.indicator === null ? 'N/A'
       : data.indicator;
  });
  return budgetData;
}


