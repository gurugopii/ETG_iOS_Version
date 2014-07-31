//Main Populate method
        	//populateWpbAbr(wpbAbrData);
        	//populateWpbAbr(wpbNoData);
        	function populateWpbAbr(wpbAbrData) {
			  var isNoData = false;
			  var isTableNotDefined = false;
			  var isTableEmpty = false;
			  var isDataForChartNull = true;
        	  if (wpbAbrData !== 'disabled') {
				if (wpbAbrData == 'no data') {
				  wpbAbrData = JSON.parse(
				      '    {  ' +
				      '        "topInformation":{ "currency":"N/A", "update":"N/A", "reportingMonth":"N/A"},' +
				      '        "chartdata": [        ' +
				      '            { "name": "ABRApproved"},' +
				      '            { "name": "ABRSubmitted"}' +
				      '        ], ' +
				      '        "tabledata": [{"name": "", "submittedABR":"No Data Available", "approvedABR":"" , "region": "", "indicator": ""}] ' +
				      '    }   ');
					  
					  isNoData = true;
				} else {
				  wpbAbrData.topInformation = wpbAbrData.topInformation == undefined ? JSON.parse('{"currency":"N/A", "update":"N/A", "reportingMonth":"N/A"}') : wpbAbrData.topInformation;
				  wpbAbrData.chartdata = wpbAbrData.chartdata == undefined ? JSON.parse('[{"name":"ABRApproved"},{"name":"ABRSubmitted"}]') : wpbAbrData.chartdata;
				  
				  $.each(wpbAbrData.chartdata, function(index, row){
					$.each(row.data, function(dataIndex, dataRow){
					  if(dataRow != null){
					    isDataForChartNull = false;
					  }
					});
				  });
				  
				  
				  if(wpbAbrData.tabledata == undefined){
				    isTableNotDefined = true;
				  }
				  
				  wpbAbrData.tabledata = wpbAbrData.tabledata == undefined ? JSON.parse('[{"name":"", "submittedABR":"No Data Available", "approvedABR":"" , "region":"", "indicator":""}]') : wpbAbrData.tabledata;
				  
				  if(wpbAbrData.tabledata.length == 0){
				    isTableEmpty = true;
				  }
				}
        	    console.log(wpbAbrData);
        	    $("#currency").text('Currency: ' + validateField(wpbAbrData.topInformation.currency));
        	    $("#update").text('Updated: ' + validateField(wpbAbrData.topInformation.update));
        	    $("#reportingMonth").text('Reporting Month: ' + validateField(wpbAbrData.topInformation.reportingMonth));
                  
                  var validatedReportingMonth = validateField(wpbAbrData.topInformation.reportingMonth);
                  reportingYear = validatedReportingMonth === 'N/A' ? '' : validatedReportingMonth.substring(4, 8);
                  
        	    var tableContainer = $('#eccrWpbAbrTableContainer');
        	    var table = '';
        	    var tableRows = '';
        	    var reportingYear;
				
				if(isNoData || isTableEmpty){
				  tableRows += '<tr>' +
        	      '<td></td>' +
        	      '<td></td>' +
        	      '<td style="text-align:center">No Data Available</td>' +
        	      '<td></td>' +
        	      '<td></td>' +
        	      '</tr>';
				  reportingYear = 'XXXX';
				} else {
				  $.each(wpbAbrData.tabledata, function (index, row) {
				    if (isTableNotDefined) {
				      tableRows += '<tr>' +
				      '<td></td>' +
				      '<td></td>' +
				      '<td style="text-align:center">No Data Available</td>' +
				      '<td></td>' +
				      '<td></td>' +
				      '</tr>';
				      reportingYear = 'XXXX';
				    } else {
				      row.region = validateField(row.region);
				      row.name = validateField(row.name);
				      row.submittedABR = numberWithCommasWithoutDecimal(validateField(row.submittedABR));
				      row.approvedABR = numberWithCommasWithoutDecimal(validateField(row.approvedABR));
				      row.indicator = validateField(row.indicator);
				      //reportingYear = new Date(validateField(row.reportingdate));

				      //if(reportingYear !== 'N/A'){
				      //reportingYear = reportingYear.getFullYear();
				      //}

				      tableRows += '<tr>' +
				      '<td>' + row.region + '</td>' +
				      '<td>' + row.name + '</td>' +
				      '<td>' + row.submittedABR + '</td>' +
				      '<td>' + row.approvedABR + '</td>' +
				      // '<td>'+row.indicator+'</td>' +
				      '<td><img src="' + returnIndicatorPath(validateField(row.indicator)) + '" alt="' + validateField(row.indicator) + '"/></td>' +
				      '</tr>';
				    }

				  });
				}
        	    

        	    table = '<table id="eccrWPBTable" class="petronas">' +
        	      '<thead>' +
        	      '<th>Region</th>' +
        	      '<th>Project</th>' +
        	      '<th>Submitted ABR</th>' +
        	      '<th>Approved ABR</th>' +
        	      '<th>Indicator</th>' +
        	      '</thead>' +
        	      '<tbody>' +
        	      tableRows +
        	      '</tbody>' +
        	      '</table>';

        	    tableContainer.empty().append(table);
				setProperAlignment($("#eccrWPBTable tr"));
        	    $('#eccrWPBTable').tablesorter();
        	    /*
        	    check if data contains negative,
        	    if no negative found, set the min to 0
        	     */
        	    var isDataNegative = false;
        	    $.each(wpbAbrData.chartdata, function (outerIndex, row) {
        	      $.each(row.data === undefined ? JSON.parse('[]') : row.data, function (innerIndex, data) {
        	        if (data < 0) {
        	          isDataNegative = true;
        	        }
        	      });
        	    });

        	    var wpbAbrOpions = setWPBOption();
        	    if (!isDataNegative) {
        	      wpbAbrOpions.yAxis.min = 0;
        	    }
				
				wpbAbrOpions.yAxis = {
				  title : {
					text : '(MYR \'000,000)'
				  }
				};
				wpbAbrOpions.tooltip = {
				  shared : true,
				  crosshairs : true,
				  formatter : function () {

				    var s = '';
					var month;
				    $.each(this.points, function (i, point) {
				      var nameOfItem = point.series.name;
				      if (point.series.name == 'ABRApproved') {
				        nameOfItem = 'ABR Approved';
				      } else {
				        nameOfItem = 'ABR Submitted';
				      }

					  month= point.point.x;
				      s += '<b>' + nameOfItem + '</b>: ' +
				      Highcharts.numberFormat(point.y) + '<br/>';
				    });

				    return monthNames[month] + ' ' + reportingYear + '<br/>' + s;
				  }
				};
				
        	    wpbAbrOpions.series = wpbAbrData.chartdata;
        	    WPBChart = new Highcharts.Chart(wpbAbrOpions);
        	    //set title with the Fiscal Year (for filtering purposes)
        	    WPBChart.setTitle({
        	      text : 'WPB Performance (FY' + reportingYear.toString().substring(2, 4) + ')'
        	    });
				
				if (isDataForChartNull) {
				  WPBChart.renderer.text('No Data Available', 450, 200).css({
				    'font-size' : '14px',
				    'color' : '#333'
				  }).add();
				}
        	  }

        	} //end wpb populate