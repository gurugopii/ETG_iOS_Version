var isPopoverDisplayed = false;
var isPopoverDisplayedLevel2 = false;
var level;


function displayPopover(description, placement) {

//  $('.popover').remove();
  //var popoverJsonObj = JSON.parse(popoverJson);

  //console.log(popoverJson);

  var self = clickedIndicator;
  //console.log(projectname+'  '+type);

  //Create the popover and show
  self.popover({
    trigger : 'manual',
    placement : placement,
    html : true,
    animation : false,
    container : 'body',
    content : description
  })
  .popover('show');
    
  console.log('popover show')

}


function populateTimestamp(data) {
  $('#report-period').empty().append('Reporting Period: ' + validateField(data.reportPeriod));
    console.log('data.lastUpdate');

    console.log(data.lastUpdate);
  $('#last-update').empty().append('Updated ' + validateField(data.lastUpdate));
}

function popupateGateChart(data, level, id) {
  var description = level1PopoverForPGD;

  options = setGateOption();

  if (level === 1) {
//    options.tooltip = {
//      enabled : false
//    };
    options.title = {
      text : 'Portfolio Gate Distribution Chart'
    };
	
	options.legend = {
	  y : -180
	};
  } else {
    description = level2PopoverForPGD;
//    options.legend = {
//      layout: 'vertical',
//      itemStyle: {
//        paddingBottom: '10px'
//      },
//    x: 210,
//    y: -150
//    };
    options.xAxis.offset = -182;
    options.yAxis.offset = -210;
//    options.chart.margin = 10;
//   options.chart.marginRight = 230;
//      options.chart.margin = 4;
//      options.chart.marginRight = 226;
      options.chart.margin = [0, 120, 20, 120];

  }

    $.each(data.chartContents, function(index, row){
           $.each(row.data, function(innerIndex, innerRow){
                  
                  if(innerRow.x !== null && innerRow.x !== undefined){
                    if(innerRow.x < -39){
                      innerRow.x = innerRow.x + 1;
                     } else if(innerRow.x > 39){
                      innerRow.x = innerRow.x - 1;
                     }
                  }
                  
                  if(innerRow.y !== null && innerRow.y !== undefined){
                    if(innerRow.y < -39){
                        innerRow.y = innerRow.y + 1;
                    } else if(innerRow.y > 39){
                        innerRow.y = innerRow.y - 1;
                    }
                  }
                  
                  });
           });
  options.series = data.chartContents;
    
    
  $.grep(options.series, function (row, i) {
    var name = validateField(row.name);
    if (name.toLowerCase() === 'yellow') {
      row.name = pgdReplaceColorWithValue(name);
      row.color = '#f5f500';
      row.marker = {
        symbol : 'triangle'
      };
        return row;
    } else if (name.toLowerCase() === 'limegreen') {
      row.name=pgdReplaceColorWithValue(name);
      row.color = '#02ab9a';
      row.marker = {
        symbol : 'circle'
      };
      return row;
    } else if (name.toLowerCase() === 'red'){
      row.name=pgdReplaceColorWithValue(name);
      row.color = '#bf0606';
      row.marker = {
        symbol : 'diamond'
      };
      return row;
    } else {
      //Some invalid color passed. Do not put on chart
      return false;
    }

  });
  var chart = new Highcharts.Chart(options);

  if (level === 1) {
	setEventHandlerToTitle(chart, id, description, 'bottomRightDescription', 'PGD');
  } else {
    // $('#gate-title').append('<span><img src="images/info.gif"></span>').on('touchend', function () {
    $('#gate-title').append('<span><img src="images/info.gif" class="popover-button PGD"></span>');
//	$('#gate-title').delegate('img', 'click', function () {
//      clickedIndicator = $(this);
//      displayPopover(description, 'bottomRightDescriptionPGD2');
//	  isPopoverDisplayedLevel2 = true;
//    });
	
	chart.container.onclick = function (e) {
	  if (isPopoverDisplayedLevel2) {
	    $('.popover').remove();
	    isPopoverDisplayedLevel2 = false;
	  }
	}
	
	
  }

  console.log('x-attribute-title');
  console.log($('#gate-title'));

}

//Replace the passed color with proper name
function pgdReplaceColorWithValue(pgdcolor) {
    pgdcolor = pgdcolor.toLowerCase();
    if (pgdcolor == 'yellow') {
        return 'Overdue';
    } else if (pgdcolor == 'limegreen') {
        return 'On Time/Ahead of Schedule';
    } else if (pgdcolor == 'red') {
        return 'FDPRC-FDP/Adv Funding Overdue';
    } else {
        return 'N/A';
    }
 }

function popupateMatrixChart(data, level, id) {
    //====================================================================
    //construct data for the chart
    var jsonForMatrixChart = JSON.parse('[{"name":"Slow FDP, Fast Execution","data":[]},{"name":"Fast FDP, Fast Execution","data":[]},{"name":"Fast FDP, Slow Execution","data":[]},{"name":"Slow FDP, Slow Execution","data":[]},{"name":"Projects with insufficient data","data":[]}]');
    console.log(jsonForMatrixChart);
    //colors : ['#cafcca', '#02ab9a', '#fcfc97', '#bd0000', '#a3a3cf'],
    $.each(data, function (index, row) {
      var status = validateField(row.status).toLowerCase().split(',');
      status = status[0] === 'n/a' ? 'n/a' : status[0].trim() + ',' + status[1].trim();
      console.log('status');
      console.log(status);
           
           var xCoordinate = validateNumberField(row.fdpDifferentMM) == 999999 ? 0 : validateNumberField(row.fdpDifferentMM);
           var yCoordinate = validateNumberField(row.execDifferentM) == 999999 ? 0 : validateNumberField(row.execDifferentM);
           
           if(xCoordinate > 12){
            xCoordinate = 12;
           } else if(xCoordinate < -12){
            xCoordinate = -12;
           }
           if(yCoordinate > 12){
             yCoordinate = 12;
           } else if(yCoordinate < -12){
             yCoordinate = -12;
           }
           
           var dataString = JSON.parse('{"name":"' + validateField(row.projectName) + '","x":' + xCoordinate + ',"y":' + yCoordinate + ', "reason":"' + validateField(row.riskCategoryName) + '"}');

           if (validateNumberField(row.fdpDifferentMM) === 999999) {
                //add to project with insufficient data
                jsonForMatrixChart[4].data.push(dataString);
                console.log('insufficient data');
                jsonForMatrixChart[4].data.push(dataString);
           
           } else if (validateNumberField(row.execDifferentM) === 999999) {
                //add to project with insufficient data
                jsonForMatrixChart[4].data.push(dataString);
                console.log('insufficient data');
                jsonForMatrixChart[4].data.push(dataString);
           
           } else {

                if (status === 'slow fdp,fast execution') {
                    jsonForMatrixChart[0].data.push(dataString);
                } else if (status === 'fast fdp,fast execution') {
                    jsonForMatrixChart[1].data.push(dataString);
                } else if (status === 'slow fdp,slow execution') {
                    jsonForMatrixChart[2].data.push(dataString);
                } else if (status === 'fast fdp,slow execution') {
                    jsonForMatrixChart[3].data.push(dataString);
                }
           }
    });
    console.log('jsonForMatrixChart');
    console.log(jsonForMatrixChart);
    
    
    //====================================================================

    // var description = 'This chart displays the distribution of projects based on its FDP and Execution speed, giving an overview of a project’s performance. <br/><br/>Only projects that have completed FDPRC-FDP/Advance Funding are shown here.';
    var description = level1PopoverForPEM;

    options = setMatrixOption();
    // options.series = data;
    options.series = jsonForMatrixChart;

    $.each(options.series, function (index, row) {
      var nameOfSeries = validateField(row.name).toLowerCase();
      if (nameOfSeries === 'projects with insufficient data') {
        row._colorIndex = 1;
      } else {
        row._colorIndex = 0;
      }
      console.log(nameOfSeries + ' ' + row._colorIndex);
    });

    console.log('MATRIX SERIES');
    console.log(options.series);

    if (level === 2) {
      // options.yAxis.offset = -179;
      // description = 'Displays all projects that have completed FDPRC-FDP/Advance Funding and is currently in Execution phase. <br/>If Execution speed is “N/A”, data is not available for that project and will be shown as a red dot in Project Execution Matrix.<br/>Tap on an individual project name to proceed to the PAP Screen.';
      description = level2PopoverForPEM;
    } else {
      options.tooltip = {
        enabled : false
      };
      options.title = {
        text : 'Project Execution Matrix'
      };
	  
	  // options.chart.margin = [60, 5, 240, 20];
	  options.chart.margin = [42, 50, 222, 50];
    }
    $.each(options.series, function (i, row) {
      row.marker = {
        symbol : 'circle'
      };
    });
    var chart = new Highcharts.Chart(options);

    if (level === 1) {
	  setEventHandlerToTitle(chart, id, description, 'bottomRightDescription', 'PEM');
	  
      //insufficient data
      // chart.renderer.circle(150, 387, 5)
      chart.renderer.circle(150, 457, 5)
      .css({
        color : '#bd0000'
      })
      .attr({
        zIndex : 999
      })
      .add();

      // chart.renderer.text('Projects with insufficient data', 160, 390)
      chart.renderer.text('Projects with insufficient data', 160, 460)
      .css({
        color : '#7d7d7d',
        fontSize : '11px'
      })
      .attr({
        zIndex : 999
      })
      .add();
    } else {
      // $('#matrix-title').append('<span><img src="images/info.gif"></span>').on('touchend', function () {
      $('#matrix-title').append('<span><img src="images/info.gif" class="popover-button PEM"></span>');
//      $('#matrix-title').delegate('img', 'touchend', function () {
//        clickedIndicator = $(this);
//        displayPopover(description, 'bottomRightDescriptionPGD2');
//		isPopoverDisplayedLevel2 = true;
//      });
	  
        chart.container.onclick = function (e) {
            if (isPopoverDisplayedLevel2) {
                $('.popover').remove();
                isPopoverDisplayedLevel2 = false;
            }
        }
    }
}

function sendURLToObjectiveC(url) {
  var iframe;
  iframe = document.createElement("IFRAME");
  iframe.setAttribute("src", "setURL:" + url);
  iframe.setAttribute("height", "1px");
  iframe.setAttribute("width", "1px");
  document.documentElement.appendChild(iframe);
  iframe.parentNode.removeChild(iframe);
  iframe = null;

  //for testing purposes only
  document.location = url;
}

function setEventHandlerToTitle(chart, id, description, placement, chartName) {
  chart.title.on('touchend', function () {
    sendURLToObjectiveC('ETGMAPLevel2.html?id=' + id);
  });

  // chart.renderer.image('images/info.gif', chart.title.alignAttr.x + 130, 10, 20, 20)
  chart.renderer.image('images/info.gif', chart.title.alignAttr.x + 220, 10, 20, 20)
  .attr({
    'class' : 'info-button',
        'data-chart' : chartName
        
  })
    .add();
//  .on('touchend', function () {
//    clickedIndicator = $(this);
//    displayPopover(description, 'bottomRightDescription');
//	isPopoverDisplayed = true;
//  });
  
//  chart.container.onclick = function(e){
//	if(isPopoverDisplayed && !$(e.target).is('.info-button')){
//		$('.popover').remove();
//		isPopoverDisplayed =  false;
//	}
//  }
}


