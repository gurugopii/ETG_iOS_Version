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
        $('.popover').remove();
      }
    });
  console.log(location.search.split("=")[1]);
  window.swiper.slide(location.search.split("=")[1], 100);
       
       
});


//Delegate the close button logic
$('#swiper').delegate('.close-button', 'touchend', function() {
    document.location = 'ETGMAPLevel1.html';
});



var fill = location.search.split("=")[1];
// populateAllCharts(data);
// populateAllCharts(noData);

function populateAllCharts(jsonData) {
    currentLevel=2;
  var module = 'project',
  level = 2,
  pageCount = 0,
  id = 0,
  pagePosition = ['#first', '#second'],
  timeStampJson = jsonData.topInformation === undefined ? 'no data' : jsonData.topInformation,
  gateJson = jsonData.gate === undefined ? 'disabled' : jsonData.gate,
  matrixJson = jsonData.matrix === undefined ? 'disabled' : jsonData.matrix;

  populateTimestamp(timeStampJson);

  if (gateJson == 'disabled') {}
  else if (gateJson == 'no data') {
    $(pagePosition[pageCount]).empty().append(gateHTMLContent);
    pageCount++;
    popupateGateChart(gateNoData.gate, level);
    populateGateTable(gateNoData.gate.tabledata);
    id++;
  } else {
    $(pagePosition[pageCount]).empty().append(gateHTMLContent);
    pageCount++;
    popupateGateChart(gateJson, level);
    populateGateTable(gateJson.tabledata);
    id++;
      //Enable zooming
      $('#gate-chart-container .highcharts-container').each(function () {
                                                            new RTP.PinchZoom($(this), {});
                                                            });
  }

  if (matrixJson == 'disabled') {}
  else if (matrixJson == 'no data') {
    $(pagePosition[pageCount]).empty().append(matrixHTMLContent);
    pageCount++;
    popupateMatrixChart(matrixNoData.matrix, level);
    populateMatrixBreakdownCharts(matrixNoData.matrix);
    populateMatrixTable(matrixNoData.matrix);
    id++;
  } else {
    $(pagePosition[pageCount]).empty().append(matrixHTMLContent);
    pageCount++;
    popupateMatrixChart(matrixJson, level);
    populateMatrixBreakdownCharts(matrixJson);
    populateMatrixTable(matrixJson);
    id++;
      //Enable zooming
      $('#matrix-chart-container .highcharts-container').each(function () {
                                                              new RTP.PinchZoom($(this), {maxZoom : 8});
                                                              
                                                              });
  }

    var ispopoverDisplayedForPie = false;
    $('.info-button').on('click', function(){
                         $('.popover').remove();
                         clickedIndicator = $(this);
                         
                         if(clickedIndicator.data('chart') == 'pieBreakdown'){
                         description = level2PopoverForPEMB;
                         } else if(clickedIndicator.data('chart') == 'pieFast'){
                         description = level2PopoverForPEMFE;
                         } else if(clickedIndicator.data('chart') == 'pieSlow'){
                         description = level2PopoverForPEMSE;
                         }
                         displayPopover(description, 'bottomRightDescription');
                         ispopoverDisplayedForPie = true;
        });
    
    $('.popover-button').on('click', function(){
                         $('.popover').remove();
                         clickedIndicator = $(this);
                         
                         if(clickedIndicator.hasClass('PGD')){
                            description = level2PopoverForPGD;
                         } else if(clickedIndicator.hasClass('PEM')){
                            description = level2PopoverForPEM;
                         }
                         displayPopover(description, 'bottomRightDescription');
                         isPopoverDisplayedLevel2 = true;
                         });
    
    
    $('body').delegate('*','touchend', function(e){
                       if(isPopoverDisplayedLevel2 && !$(e.target).is('.popover-button')){
                            $('.popover').remove();
                            isPopoverDisplayedLevel2 = false;
                       }
                       
                       if(ispopoverDisplayedForPie && !$(e.target).is('.info-button')){
                            $('.popover').remove();
                            ispopoverDisplayedForPie = false;
                       }
                       
                       if(ispopoverDisplayedForPie && $(e.target).is('.popover-button') && isPopoverDisplayedLevel2){
                       $('.popover').remove();
                       ispopoverDisplayedForPie = false;
                       ispopoverDisplayedForPie = false;
                       }
                       
                       
                       });
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
}
function populateMatrixBreakdownCharts(data) { // Level and id is not used hence to be removed
    //---------------------------------------------------------
    //construct json for the charts
    
    //Create the objects for each report. Each object will be an array with Status/riskCategoryName as key
    
    var speedBreakdownCountTemp = new Object(), //Temporary for counting all reasons first
    fastExecCountTemp = new Object(),//Temporary for counting all reasons first
    slowExecCountTemp = new Object();//Temporary for counting all reasons first
    
    //Loop through the data and populate the arrays for count
    for (var i in data) {
        //To Lower Case and Trim the status name for consistent comparing
        var status = validateField(data[i].status).toLowerCase().split(',');
        status = status[0] === 'n/a' ? 'n/a' : status[0].trim() + ',' + status[1].trim();
        
        if (status === 'slow fdp,fast execution') {
            //add the counter for speed breakdown chart
            speedBreakdownCountTemp = increaseCounterInObjectArray(speedBreakdownCountTemp, data[i].status);
            
            //add the counter to fast Execution chart
            //If riskCategoryName is empty, undefined or null, don't include it counting
            if (data[i].riskCategoryName!="" && data[i].riskCategoryName!=undefined && data[i].riskCategoryName!=null) {
                fastExecCountTemp = increaseCounterInObjectArray(fastExecCountTemp, data[i].riskCategoryName);
            }
        } else if (status === 'fast fdp,fast execution') {
            //add the counter for speed breakdown chart
            speedBreakdownCountTemp = increaseCounterInObjectArray(speedBreakdownCountTemp, data[i].status);
            //add the counter to fast Execution chart
            //If riskCategoryName is empty, undefined or null, don't include it counting
            if (data[i].riskCategoryName!="" && data[i].riskCategoryName!=undefined && data[i].riskCategoryName!=null) {
                fastExecCountTemp = increaseCounterInObjectArray(fastExecCountTemp, data[i].riskCategoryName);
            }
        } else if (status === 'slow fdp,slow execution') {
            //add the counter for speed breakdown chart
            speedBreakdownCountTemp = increaseCounterInObjectArray(speedBreakdownCountTemp, data[i].status);
            
            //add the counter to slow Execution chart
            //If riskCategoryName is empty, undefined or null, don't include it counting
            if (data[i].riskCategoryName!="" && data[i].riskCategoryName!=undefined && data[i].riskCategoryName!=null) {
                slowExecCountTemp = increaseCounterInObjectArray(slowExecCountTemp, data[i].riskCategoryName);
            }
        } else if (status === 'fast fdp,slow execution') {
            //add the counter for speed breakdown chart
            speedBreakdownCountTemp = increaseCounterInObjectArray(speedBreakdownCountTemp, data[i].status);
            
            //add the counter to slow Execution chart
            //If riskCategoryName is empty, undefined or null, don't include it counting
            if (data[i].riskCategoryName!="" && data[i].riskCategoryName!=undefined && data[i].riskCategoryName!=null) {
                slowExecCountTemp = increaseCounterInObjectArray(slowExecCountTemp, data[i].riskCategoryName);
            }
        }
    }
    
    console.log(speedBreakdownCountTemp);
    console.log(fastExecCountTemp);
    console.log(slowExecCountTemp);
    //Let's sort the arrays now: fastExecCountTemp and slowExecCountTemp
    //Cannot sort the objects, then convert the object to array
    var speedBreakdownCountArray = new Array(); //Final array for speed Breakdown pie chart
    var slowExecCountTempArray = new Array();
    var fastExecCountTempArray = new Array();
    
    for (var key in speedBreakdownCountTemp) {
        speedBreakdownCountArray.push({"status":key, "count":speedBreakdownCountTemp[key]});
    }
    for (var key in slowExecCountTemp) {
        slowExecCountTempArray.push({"riskCategoryName":key, "count":slowExecCountTemp[key]});
    }
    for (var key in fastExecCountTemp) {
        fastExecCountTempArray.push({"riskCategoryName":key, "count":fastExecCountTemp[key]});
    }
    //Arrays
    console.log("After converted objects to arrays");
    console.log(speedBreakdownCountArray);
    console.log(fastExecCountTempArray);
    console.log(slowExecCountTempArray);
    
    //Sort the arrays Descending
    speedBreakdownCountArray.sort(function (a, b) {
                                  return b.count-a.count;
                                  });
    slowExecCountTempArray.sort(function (a, b) {
                                return b.count-a.count;
                                });
    fastExecCountTempArray.sort(function (a, b) {
                                return b.count-a.count;
                                });
    console.log("Sorted arrays now");
    console.log(speedBreakdownCountArray);
    console.log(fastExecCountTempArray);
    console.log(slowExecCountTempArray);
    
    //Prepare the arrays for pie charts. Show only top 3 items, the rest put in Others category
    var slowExecCountArray = new Array();
    var fastExecCountArray = new Array();
    var countForOthersInSlowExec = 0;
    var countForOthersInFastExec = 0;
    for (var key in slowExecCountTempArray) {
        if (key<3) {
            slowExecCountArray.push(slowExecCountTempArray[key]);
        } else {
            countForOthersInSlowExec += slowExecCountTempArray[key].count;
        }
    }
    if (countForOthersInSlowExec!=0) {
        slowExecCountArray.push({"riskCategoryName":"Others", "count":countForOthersInSlowExec});
    }
    for (var key in fastExecCountTempArray) {
        if (key<3) {
            fastExecCountArray.push(fastExecCountTempArray[key]);
        } else {
            countForOthersInFastExec += fastExecCountTempArray[key].count;
        }
    }
    if (countForOthersInFastExec!=0) {
        fastExecCountArray.push({"riskCategoryName":"Others", "count":countForOthersInFastExec});
    }
    
    console.log("Final arrays for pie charts");
    console.log(fastExecCountArray);
    console.log(slowExecCountArray);
    
    //Prepare the strings and JSON objects
    var speedBreakdownString,
    fastExecString,
    slowExecString;
    speedBreakdownString='[';
    for (var key in speedBreakdownCountArray) {
        if (key!=0) speedBreakdownString+=',';
        speedBreakdownString+='["'+speedBreakdownCountArray[key].status+'", '+speedBreakdownCountArray[key].count+']';
    }
    speedBreakdownString+=']';
    fastExecString='[';
    for (var key in fastExecCountArray) {
        if (key!=0) fastExecString+=',';
        fastExecString+='["'+fastExecCountArray[key].riskCategoryName+'", '+fastExecCountArray[key].count+']';
    }
    fastExecString+=']';
    slowExecString='[';
    for (var key in slowExecCountArray) {
        if (key!=0) slowExecString+=',';
        slowExecString+='["'+slowExecCountArray[key].riskCategoryName+'", '+slowExecCountArray[key].count+']';
    }
    slowExecString+=']';
    
    console.log("Resulted strings");
    console.log(speedBreakdownString);
    console.log(fastExecString);
    console.log(slowExecString);
    
    speedBreakdownString.replace(/&quot;/ig,'"');
    var jsonForBreakdown = JSON.parse(speedBreakdownString);
    //  var jsonForBreakdown = speedBreakdownString;
    
    console.log('jsonForBreakdown');
    console.log(jsonForBreakdown);
    
    fastExecString.replace(/&quot;/ig,'"');
    var jsonForFastExec = JSON.parse(fastExecString);
    // var jsonForFastExec = fastExecString;
    
    console.log('jsonForFastExec');
    console.log(jsonForFastExec);
    
    slowExecString.replace(/&quot;/ig,'"');
    var jsonForSlowExec = JSON.parse(slowExecString);
    // var jsonForSlowExec = slowExecString;
    
    console.log('jsonForSlowExec');
    console.log(jsonForSlowExec);
    
    
    //colors for breakdown
    
    var breakdownColors = [];
    $.each(jsonForBreakdown, function(index, row){
           $.each(row, function(innerIndex, innerRow){
                    if(innerIndex == 0){
						var speedStatus = validateField(innerRow).toLowerCase().split(',');
						speedStatus = speedStatus[0] === 'n/a' ? 'n/a' : speedStatus[0].trim() + ',' + speedStatus[1].trim();
                        if(speedStatus == 'slow fdp,fast execution'){
                           breakdownColors.push('rgb(204, 255, 204)');
                        } else if(speedStatus == 'slow fdp,slow execution'){
                            breakdownColors.push('rgb(192, 0, 0)');
                        } else if(speedStatus == 'fast fdp,slow execution'){
                            breakdownColors.push('rgb(255, 255, 153)');
                        } else if(speedStatus == 'fast fdp,fast execution'){
                            breakdownColors.push('rgb(2, 173, 157)');
                        }
                    }
                  });
           });
    //---------------------------------------------------------
    
    optionForBreakdownChart = setMatrixBreakdownOption(jsonForBreakdown,
                                                       'percent-breakdown-container',
                                                       '% Breakdown of Project Execution Matrix',
                                                       breakdownColors,
                                                       //['#cafcca', '#02ab9a', '#bd0000', '#fcfc97'],
                                                       level2PopoverForPEMB,
                                                       150,
                                                       'pieBreakdown');

    console.log('optionForBreakdownChart.series');
    console.log(optionForBreakdownChart.series);
//    $.each(optionForBreakdownChart.series, function(index, row){
//           
//           });
    // optionForBreakdownChart.legend = {
    // itemWidth: 170,
    // width: 360
    // };
    
    console.log(optionForBreakdownChart.series);
    optionForFastExecChart = setMatrixBreakdownOption(jsonForFastExec,
                                                      'fast-execution-container', 
                                                      'Reason for Fast Execution', 
                                                      ['#007d7d', '#cafcca', '#32c9c9', '#00c994'], 
                                                      level2PopoverForPEMFE,
                                                      100,
                                                      'pieFast');
    
    // optionForFastExecChart.legend = {
    // itemWidth: 80,
    // width: 160
    // };
    
    optionForSlowExecChart = setMatrixBreakdownOption(jsonForSlowExec, 
                                                      'slow-execution-container', 
                                                      'Reason for Slow Execution', 
                                                      ['#bd0000', '#fcca65', '#f0dbda'], 
                                                      level2PopoverForPEMSE,
                                                      100,
                                                      'pieSlow');
    
    console.log('optionForBreakdownChart.series')
    console.log(optionForBreakdownChart.series)
    var chartForBreakdownChart = new Highcharts.Chart(optionForBreakdownChart);
    var chartForFastExecChart = new Highcharts.Chart(optionForFastExecChart);
    var chartForSlowExecChart = new Highcharts.Chart(optionForSlowExecChart);
}

/*
 *  Count number of keys in Associative Array (array with objects as keys). 
 */
function increaseCounterInObjectArray(objArray, key) {
    if (objArray[key]==undefined) {
        objArray[key]=1;
    } else {
        objArray[key]++;
    }
    return objArray;
}


function populateGateTable(data) {

    console.log('data for gate chart');
    console.log(data);
    var gateTableContent = '<table id="gate-table" class="petronas zebra">' +
    '<thead>' +
    '<tr>' +
    '<th>Region</th>' +
    '<th>Phase</th>' +
    '<th>Project</th>' +
    '<th>Duration to Hand Over (Month)</th>' +
    '<th>Milestone/Review Health</th>' +
    '</tr>' +
    '</thead>' +
    '<tbody>';
  var tableRows = '';
    console.log('table rows initiation');
        console.log(tableRows);
    
  if (data.length < 1) {
    tableRows = '<tr>' +
      '<td colspan="5">No data available</td>' +
      '</tr>';
  } else {
    $.each(data, function (index, row) {
	  var duration = validateNumberField(row.duration) == 999999 ? 'N/A' : validateNumberField(row.duration);
	  
      tableRows += '<tr>' +
      '<td>' + validateField(row.region) + '</td>' +
      '<td>' + validateField(row.phase) + '</td>' +
      '<td class="project" data-projectname="' + validateField(row.projectName) + '" data-projectkey="' + validateField(row.projectKey) + '">' + validateField(row.projectName) + '</td>' +
      '<td>' + numberWithCommas(duration) + '</td>' +
      '<td>' + pgdReplaceColorWithValue(validateField(row.milestone)) + '</td>' +
      '</tr>';
    });

  }
    
    console.log('table rows end');
    console.log(tableRows);

  gateTableContent += tableRows +'</tbody></table>';

    console.log('table content');
    console.log(gateTableContent);
    
  $('#gate-table-container').empty().append(gateTableContent);
  if (data.length < 1) {
    noDataDisplay('#gate-table');
  } else {
    $('#gate-table').tablesorter();
	setProperAlignment($('#gate-table tr'));
    setOnTouchEventForProject();
  }

}

function populateMatrixTable(data) {
    var matrixTableContent = '<table id="matrix-table" class="petronas zebra">' +
    '<thead>' +
    '<tr>' +
    '<th>Project Execution<br/>Performance</th>' +
    '<th>Project</th>' +
    '<th>Region</th>' +
    '<th>FDP Speed<br/>(Month)</th>' +
    '<th>Execution Speed<br/>(Month)</th>' +
    '<th>Reason</th>' +
    '</tr>' +
    '</thead>' +
    '<tbody>';
  var tableRows = '';
  if (data.length < 1) {
    tableRows = '<tr>' +
      '<td colspan="6">No data available</td>' +
      '</tr>';
  } else {
    $.each(data, function (index, row) {
           var fdpSpeed = validateNumberField(row.fdpDifferentMM) == 999999 ?  'N/A' : validateNumberField(row.fdpDifferentMM);
           var execSpeed = validateNumberField(row.execDifferentM) == 999999 ?  'N/A' : validateNumberField(row.execDifferentM);
      tableRows += '<tr>' +
      '<td>' + validateField(row.status) + '</td>' +
      '<td class="project" data-projectname="' + validateField(row.projectName) + '" data-projectkey="' + validateField(row.projectKey) + '">' + validateField(row.projectName) + '</td>' +
      '<td>' + validateField(row.regionName) + '</td>' +
      '<td>' + (fdpSpeed > 0 ? 'Ahead by ' + numberWithCommas(Math.abs(fdpSpeed)) : fdpSpeed < 0 ? 'Behind by ' + numberWithCommas(Math.abs(fdpSpeed)) : fdpSpeed === 0 ? fdpSpeed : 'N/A') + '</td>' +
      '<td>' + (execSpeed > 0 ? 'Ahead by ' + numberWithCommas(Math.abs(execSpeed)) : execSpeed < 0 ? 'Behind by ' + numberWithCommas(Math.abs(execSpeed)) : execSpeed === 0 ? execSpeed : 'N/A') + '</td>' +
      '<td>' + validateField(row.riskCategoryName) + '</td>' +
      '</tr>';
    });
  }

  matrixTableContent += tableRows +'</tbody></table>';

  $('#matrix-table-container').empty().append(matrixTableContent);
  if (data.length < 1) {
    noDataDisplay('#matrix-table');
  } else {
    $('#matrix-table').tablesorter({
      textExtraction : {
        3 : function (node) {
          return sortingOnMatrixTable(node);
        },
        4 : function (node) {
          return sortingOnMatrixTable(node);
        }
      }
    });
	setProperAlignment($('#matrix-table tr'));
    setOnTouchEventForProject();
  }
}

function setOnTouchEventForProject() {
  // $('.project').on('click', function () {
  $('table').delegate('.project', 'touchend', function () {
    var clickedItem = $(this);
	var pllReviewKey = clickedItem.data('projectkey');
    //call to objective c with project name parameter and type of chart to link to pap screen
    var iframe = document.createElement("IFRAME");
    iframe.setAttribute("src", "setURL:ETGMAPKeyMilestone.html?projectKey=" + pllReviewKey);
    iframe.setAttribute("height", "1px");
    iframe.setAttribute("width", "1px");
    document.documentElement.appendChild(iframe);
    iframe.parentNode.removeChild(iframe);
    iframe = null;

    //the next line of code is for testing purposes only
    //document.location = 'ETGMAPKeyMilestone.html';
  });
}

//custom sorting for matrix table column(fdp speed and execution speed)
function sortingOnMatrixTable(node) {

  var stringBeforeNumber = node.innerHTML,
  numberInsideTheString = node.innerHTML.replace(/^\D+/g, ''); //removing format of numbers

  if (stringBeforeNumber.indexOf('Behind by') !== -1) {
    return parseFloat(numberInsideTheString) * -1;
  } else if (stringBeforeNumber.indexOf('Ahead by') !== -1) {
    return parseFloat(numberInsideTheString);
  }
  // extract data from markup and return it
  return node.innerHTML;
}
