		    var tappedCell;
        	//Main Populate method
        	//populateCpb(cpbData);
        	function populateCpb(cpbData) {
			  var isNoData = false,
			    isChartEmpty = false,
                isTableBodyEmpty = false;
        	  if (cpbData !== 'disabled' || cpbData !== undefined) {
        	    if (cpbData == 'no data') {
        	      cpbData = JSON.parse('    {' +
        	          '        "topInformation":{"currency":"N/A", "update":"N/A", "reportingMonth":"N/A"}, ' +
        	          '        "chartdata": {        ' +
        	          '            "categories":[],' +
        	          '            "series":[{"name":"Malaysia"},{"name":"International"},{"name":"Gap"},{"name":"Total"}' +
        	          '            ]' +
        	          '        },' +
        	          '        "tabledata":{' +
        	          '            "header":[],' +
        	          '            "body": [["No Data"," Available"]] ' +
        	          '        }' +
        	          '    }');
					  isNoData = true;
        	    } else {
        	      cpbData.topInformation = cpbData.topInformation == undefined ? JSON.parse('{"currency":"N/A", "update":"N/A", "reportingMonth":"N/A"}') : cpbData.topInformation;
        	      cpbData.chartdata = cpbData.chartdata == undefined ? JSON.parse('{"series":[{"name":"Malaysia"},{"name":"International"},{"name":"Gap"},{"name":"Total"}], "categories":[]}') : cpbData.chartdata;
        	      cpbData.chartdata.series = cpbData.chartdata.series == undefined || cpbData.chartdata.series == "no data" ? JSON.parse('[{"name":"Malaysia", "data":[]},{"name":"International", "data":[]},{"name":"Gap", "data":[]},{"name":"Total", "data":[]}]') : cpbData.chartdata.series;
				  console.log(cpbData.chartdata.series.length);
				  if(cpbData.chartdata.series.length == 0){
				    cpbData.chartdata.series = JSON.parse('[{"name":"Malaysia", "data":[]},{"name":"International", "data":[]},{"name":"Gap", "data":[]},{"name":"Total", "data":[]}]');
					isChartEmpty = true;
				  }
				  
				  console.log(cpbData.chartdata.series.length);
        	      cpbData.chartdata.categories = cpbData.chartdata.categories == undefined ? JSON.parse('[]') : cpbData.chartdata.categories;
				  
				  cpbData.tabledata = cpbData.tabledata == undefined ? JSON.parse('{"header":[], "body":[]}') : cpbData.tabledata;
				  cpbData.tabledata.header = cpbData.tabledata.header == undefined ? JSON.parse('[]') : cpbData.tabledata.header;
				  cpbData.tabledata.body = cpbData.tabledata.body == undefined || cpbData.tabledata.body == "no data" ? JSON.parse('[]') : cpbData.tabledata.body;
                    
                    if(cpbData.tabledata.body.length == 0){
                        isTableBodyEmpty = true;
                        isNoData = true;
                    }
        	    }
				
				$("#currency").text('Currency: ' + validateField(cpbData.topInformation.currency));
        	    $("#update").text('Updated: ' + validateField(cpbData.topInformation.update));
        	    $("#reportingMonth").text('Reporting Month: ' + validateField(cpbData.topInformation.reportingMonth));

        	    //CPB Chart
        	    console.log(cpbData.chartdata.series);
        	    var gapValues = [];
				var arrayDataForGap = [];
				var arrayDataForMalaysia = [];
				var arrayDataForInternational = [];
				var arrayDataForTotal = [];
				/*set proper stacking for charts*/
        	    $.each(cpbData.chartdata.series, function (indexOfSeries, row) {
        	      if (row.name.toLowerCase() == 'gap') {
        	        row.index = 3;
        	        row.color = 'transparent';
        	        row.enableMouseTracking = false;
        	        row.showInLegend = false;
        	        gapValues = row.data;
					arrayDataForGap = row.data;
					row.data = setAbsoluteValueForData(arrayDataForGap, true)
        	      } else if (row.name.toLowerCase() == 'malaysia') {
        	        row.index = 2;
        	        row.legendIndex = 0;
        	        // row.color = '#4e81ba';
        	        row.color = 'rgb(147, 190, 229)';
					arrayDataForMalaysia = row.data;
					row.data = setAbsoluteValueForData(arrayDataForMalaysia, false)
        	      } else if (row.name.toLowerCase() == 'international') {
        	        row.index = 1;
        	        row.legendIndex = 2;
        	        // row.color = '#99b858';
        	        row.color = 'rgb(146, 208, 080)';
					arrayDataForInternational = row.data;
					row.data = setAbsoluteValueForData(arrayDataForInternational, false)
        	      } else if (row.name.toLowerCase() == 'total') {
        	        row.index = 0;
        	        row.legendIndex = 1;
        	        // row.color = '#b3312e';
        	        row.color = 'rgb(215, 037, 045)';
					arrayDataForTotal = row.data;
					row.data = setAbsoluteValueForData(arrayDataForTotal, false)
        	      }
				  
        	    });
                  console.log('cpbData.chartdata.series');
                  console.log(cpbData.chartdata.series);
				
				
				console.log('arrayDataForMalaysia')
				
				console.log(arrayDataForMalaysia)
				console.log(arrayDataForInternational)
				console.log(arrayDataForTotal)
				
        	    cpbWaterfallOption = setCPBWaterfallOption(gapValues, cpbData, arrayDataForMalaysia, arrayDataForInternational, arrayDataForTotal);

        	    //render chart
        	    var cpbWaterfallChart = new Highcharts.Chart(cpbWaterfallOption);
				
				if(isChartEmpty){
                    cpbWaterfallChart.renderer.text('No Data Available', 450, 200).css({
                      'font-size':'14px',
                      'color':'#333'
                    }).add();
				}

        	    var tableContainer = $('#eccrCpbTableContainer');
        	    var table = '';
        	    var tableHeaders = '<th>Region</th><th>Project</th>';
        	    var tableRows = '';

        	    $.each(cpbData.tabledata.header, function (index, row) {
        	      tableHeaders += '<th>' + row + '</th>'
        	    });
                
                  tableHeaders += '<th> Project Key </th><th> Region Key </th>';

				var projectKeys = [];
				$.each(cpbData.tabledata.body, function (index, row) {
        	      $.each(row, function (innerIndex, innerRow) {
				    if(innerIndex == row.length - 2){
					  projectKeys.push(innerRow);
					} 
        	      });
        	    });
				
				console.log(projectKeys);
				
        	    $.each(cpbData.tabledata.body, function (index, row) {
        	      tableRows += '<tr>';
        	      $.each(row, function (innerIndex, innerRow) {
				    if(isNoData){
					  tableRows += '<td>' + innerRow + '</td>';
					} else {
					  if(innerIndex == 1){
						tableRows += '<td class="tapForCPS" data-projectkey="' + projectKeys[index] + '">' + innerRow + '</td>';
					  } 
					  else if(innerIndex !== 0 && innerIndex!== 1 && innerIndex !== row.length-1 && innerIndex !== row.length-2){
					    tableRows += '<td>' + numberWithCommas(validateNumberField(innerRow)) + '</td>';
					  } 
					  else {
					    tableRows += '<td>' + innerRow + '</td>';
					  }
					}
        	        
        	      });
        	      tableRows += '</tr>';
        	    });

        	    table = '<table id="eccrCPBTable" class="petronas">' +
        	      '<thead>' +
        	      tableHeaders +
        	      '</thead>' +
        	      '<tbody>' +
        	      tableRows +
        	      '</tbody>' +
        	      '</table>';

                  
                  if(isTableBodyEmpty){
                      table = '<table id="eccrCPBTable" class="petronas">' +
                      '<thead>' +
                      tableHeaders +
                      '</thead>' +
                      '<tbody style="display: table-row-group">' +
                      '<td colspan="' + (cpbData.tabledata.header.length + 2) + '" style="text-align:center">No Data Available</td>'
                      '</tbody>' +
                      '</table>';
                  }
                  
        	    console.log(tableHeaders);
        	    console.log(tableRows);
        	    console.log(table);

        	    tableContainer.empty().append(table);
				
				if(isNoData){
					 $('#eccrCPBTable tbody td:nth-child(1)').css('text-align', 'center');
				}
				
                  $('#eccrCPBTable').tablesorter({sortList : [[13, 0], [1, 0]]});
                    $('#eccrCPBTable tr th:nth-child(2)').removeClass('tablesorter-headerAsc');
                  
        	    var columnWidth = (($('#eccrCPBTable').width()) / (cpbData.tabledata.header.length + 2));
        	    var columnWidthOffset = (columnWidth % 1) * cpbData.tabledata.header.length;
        	    columnWidth = Math.floor(columnWidth);
        	    var columnWidthForProject = columnWidth + columnWidthOffset;
        	    console.log('Table width: ' + $('#eccrCPBTable').width());
        	    console.log('Column width: ' + columnWidth);
        	    console.log('Column width offset: ' + columnWidthOffset);
        	    console.log('Column width for project: ' + columnWidthForProject);
                  
                  if(!isNoData){
                      $('#eccrCPBTable tbody td:nth-child(n+13):nth-child(-n+14)').remove();
                      $('#eccrCPBTable thead th:nth-child(n+13):nth-child(-n+14)').remove();
					  setProperAlignment($("#eccrCPBTable tr"));
                  }
				
				
        	    //set width for all columns but project column
        	    $('#eccrCPBTable tbody td').css('min-width', columnWidth + 'px');
        	    $('#eccrCPBTable tbody td').css('max-width', columnWidth + 'px');
        	    $('#eccrCPBTable thead th').css('min-width', columnWidth + 'px');
        	    $('#eccrCPBTable thead th').css('max-width', columnWidth + 'px');
        	    //set specific width for project column
        	    $('#eccrCPBTable tbody td:nth-child(2)').css('min-width', columnWidthForProject + 'px');
        	    $('#eccrCPBTable tbody td:nth-child(2)').css('max-width', columnWidthForProject + 'px');
        	    $('#eccrCPBTable thead th:nth-child(2)').css('min-width', columnWidthForProject + 'px');
        	    $('#eccrCPBTable thead th:nth-child(2)').css('max-width', columnWidthForProject + 'px');
				
				$("#eccrCPBTable").delegate("td.tapForCPS", "touchend", function (e) {
				  console.log($(this));
				  console.log($(this).data("projectkey"));
				  //Save the reference for displaying popover
				  sendNotificationToIOS("ECCR", "navigateToCPS", $(this).data("projectkey"));
				  //window.location = "ETGECCRCPS.html";
				  //Destroy all popovers except for selected one
				});
        	  }//end UAC on disabled/undefined

        	} //end populate function
			
			
			function setAbsoluteValueForData(array, isGap){
				  var newArray = [];
				  $.each(array, function(index, row){
					  
					  if(row < 0){
					    if(index == 1 || index == 8){
                            if(isGap){
                                newArray.push({y: Math.abs(row), name: 'negative', color: 'transparent'});
                            } else {
                                newArray.push({y: Math.abs(row), name: 'negative', color: 'rgb(215, 037, 045)'});
                            }
                         } else {
						  newArray.push({y: Math.abs(row), name: 'negative'});
						}
					    
					  } else {
					    if(index == 1 || index == 8){
//						  newArray.push({y: row, color: 'rgb(215, 037, 045)'});
                            if(isGap){
                                newArray.push({y: Math.abs(row), color: 'transparent'});
                            } else {
                                newArray.push({y: Math.abs(row), color: 'rgb(215, 037, 045)'});
                            }
						} else {
						  newArray.push(row);
						}
					    
					  }
					  
					  
					});
					return newArray;
			}
				
        	function sendNotificationToIOS(module, type, value) {
			  console.log('notify');
        	  //call to objective c with project name parameter and type of chart to link to pap screen
        	  var iframe = document.createElement("IFRAME");
        	  iframe.setAttribute("src", "ETG?module=\"" + module + "\"&type=\"" + type + "\"&value=\"" + value + "\"");
        	  iframe.setAttribute("height", "1px");
        	  iframe.setAttribute("width", "1px");
        	  document.documentElement.appendChild(iframe);
        	  iframe.parentNode.removeChild(iframe);
        	  iframe = null;
        	}
