
// populateKeyMilestone(keyMilestoneMAP);
// populateKeyMilestone(keymilestoneData);
// populateKeyMilestone(JSON.parse('{"keymilestone": "no data"}'));
//function below to populate key milestone page
function populateKeyMilestone(json) {
  if (json.keymilestone !== undefined || json.keymilestone.toLowerCase() !== "disabled") {
    var keyMilestoneData = json.keymilestone;
    if (keyMilestoneData === "no data") {
      keyMilestoneData = keyMilestoneNoData;
    }
    var projectNameContainer = $('#projectName');
    projectNameContainer.empty().append(keyMilestoneData.projectName === undefined || keyMilestoneData.projectName === null ? 'N/A' : keyMilestoneData.projectName);
    console.log("start milestone");
    //chart for key milestone
    var keyMilestoneOptions = setKeyMilestoneOption(2);
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

	keyMilestoneData.reportingMonth = keyMilestoneData.reportingMonth === undefined || keyMilestoneData.reportingMonth === null ? 'XXXXXXXX' : keyMilestoneData.reportingMonth;
    keyMilestoneOptions.title = {
      text : validateField(jsonchart.chartTitle) + ' (FY' + keyMilestoneData.reportingMonth.substring(2, 4) + ')'
    };
      
    var projectPhase = validateField(jsonchart.chartSubtitle) == "" ? "N/A" : validateField(jsonchart.chartSubtitle)
    keyMilestoneOptions.subtitle = {
        text : "Project Phase: " + projectPhase
    };

    var month = keyMilestoneData.reportingMonth.substring(4, 6),
    year = keyMilestoneData.reportingMonth.substring(0, 4);

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
      positioner : function () { //Make the position of tooltip to be fixed on the chart.
        return {
          x : 80,
          y : 40
        };
      },
      formatter : function () {

        console.log(this.point);

        var newdateOfTappedPoint = new Date(this.point.x),
        // resultOfTappedPoint = setCorrectDateFormat(newdateOfTappedPoint, 'chart'),
        resultOfTappedPoint = setCorrectDateFormat(newdateOfTappedPoint),
        // matchOfTappedPoint = setCorrectDateFormat(newdateOfTappedPoint, 'chart'),
        matchOfTappedPoint = "N/A",
        labelNameOfTappedPoint = this.point.name.toLowerCase(),
        titleOfTappedPoint = 'Outlook',
        titleOfMatchPoint = 'Baseline',
        seriesTapped = this.series.name;

        $.each(keyMilestoneOptions.series, function (outerIndex, outerRow) {
          if (seriesTapped !== outerRow.name) {
            $.each(outerRow.data, function (innerIndex, innerRow) {
              if (labelNameOfTappedPoint == innerRow.name.toLowerCase()) {
                // matchOfTappedPoint = setCorrectDateFormat(new Date(innerRow.x), 'chart');
                matchOfTappedPoint = setCorrectDateFormat(new Date(innerRow.x));
              }
            });
          }
        });

        if (seriesTapped == 'Original Baseline') {
          return '<b>' + this.point.name + '</b>  Baseline: <b>' + resultOfTappedPoint +
          '</b> Outlook: <b>' + matchOfTappedPoint + '</b>';
        }
        return '<b>' + this.point.name + '</b>  Baseline: <b>' + matchOfTappedPoint +
        '</b> Outlook: <b>' + resultOfTappedPoint + '</b>';

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
    var offset = -148;
    keyMilestoneOptions.xAxis.offset = offset;

    milestoneChart = new Highcharts.Chart(keyMilestoneOptions);

	console.log(milestoneChart);
	
    milestoneChart.renderer.text('Outlook', 20, 350).css({
      fontSize : '13px',
      color : 'black'
    }).add();

	
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
        // '<td class="left">' + setCorrectDateFormat(validateField(row.plan), 'table') + '</td>' +
        // '<td class="left">' + setCorrectDateFormat(validateField(row.forecast), 'table') + '</td>' +
		'<td class="left">' + validateField(row.plan) + '</td>' +
        '<td class="left">' + validateField(row.forecast) + '</td>' +
        '</tr>';
      });
    }
    //appending the table
    milestoneTableContainer.empty().append('<table id="milestoneMiniTable" class="tablesorter petronas">' +
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

    //key milestone detailed table

    //table for key milestone
    var dataKeyMilestone = keyMilestoneData.tabledata;

    $.map(dataKeyMilestone, function (data, i) {
      data.indicator = validateField(data.indicator);
      data.milestone = validateField(data.milestone);
      data.baseline = validateField(data.baseline);
      data.outlook = validateField(data.outlook);
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
    setProperAlignment($('#keymilestoneTable tr'));
    removeTableDuplicates($('#keymilestoneTable tr'));
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
                                        headers: {
                                        0: {
                                        sorter:false
                                        }
                                        }
    });

    $('#keymilestoneTable tr th:nth-child(-n+2)').removeClass('tablesorter-headerAsc');
    setHighlightOnTouch('#keymilestoneTable');
  }

} //end key milestone function
