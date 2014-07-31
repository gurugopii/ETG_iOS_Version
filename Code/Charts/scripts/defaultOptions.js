var monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
//Highcharts charts optimization

//Default Chart Options
/*
 * Define all common options for all Highcharts charts
 *All charts extend the common options and add chart specific options
 * (see code below for each chart's specific options)
 */

var defaultColor = '#000';

var defaultOption = {
  chart : {
    style : {
      fontFamily : 'Museo Sans 300'
    },
    borderRadius : 0
  },
  exporting : {
    enabled : false
  },
  //remove highcharts logo
  credits : {
    enabled : false
  },
  title : {
    style : {
      color : '#02AD9D',
      fontFamily : 'Museo Sans 300',
      fontSize : '15px',
      padding : '2px'
    }
  },
  subtitle : {
    style : {
        marginTop: '5px', //TO move the subtitle lower to make it distinct from Title
        color : defaultColor,
        fontFamily : 'Museo Sans 300',
        fontSize : '13px'
    }
  },
  xAxis : {
    labels : {
      style : {
        color : defaultColor,
        font : 'Museo Sans 300',
        fontSize : '12px'
      }
    },
    title : {
      style : {
        color : defaultColor,
        font : 'Museo Sans 900',
        fontSize : '12px'
      }
    },
    lineColor : '#02AD9D',
    gridLineColor : '#02AD9D',
    tickColor : '#02AD9D'
  },
  yAxis : {
    labels : {
      style : {
        color : defaultColor,
        font : 'Museo Sans 300',
        fontSize : '12px'
      }
    },
    title : {
      style : {
        color : defaultColor,
        font : 'Museo Sans 900',
        fontSize : '12px'
      }
    },
    lineColor : '#02AD9D',
    gridLineColor : '#02AD9D',
    tickColor : '#02AD9D'
  },
  legend : {
    itemStyle : {
      color : '#999',
      font : 'Museo Sans 300',
      fontSize : '12px'
    },
    borderWidth : 0
  }
};

Highcharts.setOptions(defaultOption);

//Specific options for RTBD Chart for project and portfolio
var setRTBDOption = function () {
  var RTBDOption = {
    chart : {
      type : 'bar',
      renderTo : 'RTBDChart',
      marginLeft : 120, //margin used for the grouped catergories label
      marginBottom : 75,
      marginRight : 50
    },
    colors : ['#92cf51', '#92cf51', '#82b4e0', '#82b4e0'],
    title : {
      text : 'Production and RTBD'
    },
    xAxis : [{
        categories : ['Oil (kbd)', 'Gas (MMscfd)', 'Condy (kboed)', 'Oil/Gas/<br/>Condy (MMBOE)']
      }
    ],
    yAxis : [{ // Primary yAxis
        title : {
          text : 'Production',
          style : {
            color : '#4572A7'
          }
        },
        labels : {
          // format: '{value:,.2f}',
          style : {
            color : '#4572A7'
          }
        },
        opposite : true
      }, { // Secondary yAxis
        gridLineWidth : 0,
        title : {
          text : 'RTBD',
          style : {
            color : '#89A54E'
          }
        },
        labels : {
          // format: '{value:,.2f}',
          style : {
            color : '#89A54E'
          }
        }

      }
    ],
    tooltip : {
      shared : false,
      formatter : function () {
        if (this.series.name == 'CPB') {
          return '<b>Total Plan (CPB):</b> ' + numberWithCommas(this.y);
        }
        return '<b>Total Outlook (YEP):</b> ' + numberWithCommas(this.y);
      }
    },
    plotOptions : {
      series : {
        pointPadding : -0.50, //used to make bars close to each other
        borderWidth : 0
      }
    },
    legend : {
      layout : 'horizontal',
      verticalAlign : 'bottom',
      y : 10,
      floating : true,
      labelFormatter : function () {
        if (this.name == "YEP") {
          return 'Outlook (' + this.name + ')';
        } else {
          return 'Plan (' + this.name + ')';
        }
      },
      backgroundColor : '#FFFFFF',
      reversed : true
    },
    series : []
  };

  return RTBDOption;
};

/*Portfolio Chart*/
//Specific options for CPB Chart
var setCPBOption = function () {
  var CPBOption = {
    chart : {
      renderTo : 'cpbChart',
      type : 'line'
    },
    colors : ['#0070bf', '#7032ab', '#b3a3c7'],
    title : {
      text : 'CPB Performance'
    },
    legend : {
      itemDistance : 1,
      labelFormatter : function () {
        if (this.name == 'FY YTD Actual Equity') {
          return 'Actual (FY YTD Equity)';
        }
        if (this.name == 'Approved CPB Equity') {
          return 'Plan (Approved CPB Equity)';
        } else {
          return 'Outlook (FY YEP Equity)';
        }
      }
    },
    xAxis : {
      categories : ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
      labels : {
        style : {
          fontSize : '12px'
        }
      }
    },
    yAxis : {
      title : {
        text : 'Billion'
      },
      min : 0
    },
    tooltip : {
      shared : true,
      crosshairs : true,
      formatter : function () {
        var planData = '',
		  actualData = '',
		  outlookData ='';
        $.each(this.points, function (i, point) {
		  //if(point.series.name)
		  if(validateField(point.series.name).toLowerCase() === 'fy ytd actual equity'){
		    actualData = '<b>Actual YTD:</b> ' +
			numberWithCommas(point.y) + '<br/>';
		  } else if(validateField(point.series.name).toLowerCase() === 'approved cpb equity'){
		    planData = '<b>Plan CPB:</b> ' +
			numberWithCommas(point.y) + '<br/>';
		  } else if(validateField(point.series.name).toLowerCase() === 'fy yep equity'){
		    outlookData = '<b>Outlook YEP:</b> ' +
			numberWithCommas(point.y) + '<br/>';
		  } 
        });
        return planData + actualData + outlookData;
      }
    },
    plotOptions : {
      series : {
        allowPointSelect : true,
        marker : {
          radius : 1.5
        }
      },
      events : {
        marker : 'pointer'
      }
    },
    series : []
  };

  return CPBOption;
};

//Specific options for APC Chart
var setAPCOption = function () {
  var APCOption = {
    chart : {
      renderTo : 'apcChart',
      type : 'column',
      marginBottom : 70 //used the space for rendering of categories grouped at the bottom
    },
    colors : ['#ffdc2c', '#92cf51', '#d92329', '#92cf51', '#d92329'],
    title : {
      text : 'APC Performance'
    },
    legend : {
      enabled : false
    },
    xAxis : {
      categories : ['<-10.00%', '(-10.00%) to (10.00%)', '> 10.00%', '≤ 0.00%', '> 0.00%']
    },
    yAxis : {
      title : {
        text : 'No. of Projects'
      },
	  minTickInterval: 1
    },
    tooltip : {
      formatter : function () {
        return '<b>No. of Projects:</b> ' + this.y;
      }
    },
    plotOptions : {
      series : {
        marker : {
          enabled : false
        },
        events : {
          cursor : 'pointer'
        }
      }
    },
    series : []
  };

  return APCOption;
};

//Specific options for HSE Chart for portfolio
var setHSEOptionForPortfolio = function () {
  var HSEOption = {
    chart : {
      type : 'column',
      renderTo : 'hseChart'
    },
    title : {
      text : 'HSE Performance'
    },
    colors : ['#82b4e0'],
    xAxis : {
      categories : ['FAR', 'LTI', 'FI', 'TRC']
    },
    yAxis : {
      title : {
        text : 'YTD Cases'
      }
    },
    legend : {
      enabled : false
    },
    tooltip : {
      formatter : function () {
        return '<b>YTD Cases: </b>' + this.y;
      }
    },
    plotOptions : {
      series : {
        dataLabels : {
          enabled : false,
          formatter : function () {
            return this.y;
          },
		  style : {
		    color : '#000'
		  }
        }
      }
    },
    series : [{}

    ]
  };
  return HSEOption;
};

//Specific options for WPB Chart
var setWPBOption = function () {
  var WPBOption = {
    chart : {
      renderTo : 'wpbChart',
      type : 'line'
    },
    colors : ['#d92329', '#82b4e0'],
    title : {
      text : 'WPB Performance'
    },
    legend : {
      layout : 'horizontal',
      reversed : true,
      labelFormatter : function () {
        if (this.name == 'ABRApproved') {
          return 'ABR Approved';
        }
        return 'ABR Submitted';
      },
      borderWidth : 0
    },
    xAxis : {
      categories : monthNames
    },
    yAxis : {
      title : {
        text : 'Million (RM)'
      }
    },
    tooltip : {
      shared : true,
      crosshairs : true,
      formatter : function () {

        var s = '';
        $.each(this.points, function (i, point) {
          var nameOfItem = point.series.name;
          if (point.series.name == 'ABRApproved') {
            nameOfItem='ABR Approved';
          } else {
            nameOfItem='ABR Submitted';
          }
            
               
          s += '<b>' + nameOfItem + '</b>: ' +
          // point.y +'%';
          numberWithCommas(point.y) + '<br/>';
        });

        return s;
      }
    },
    plotOptions : {
      series : {
        allowPointSelect : true,
        marker : {
          radius : 1.5
        }
      },
      events : {
        marker : 'pointer'
      }
    },
    series : [{}

    ]
  };

  return WPBOption;
};

var setKeyMilestoneOption = function (level) {
  var isActualClicked = false,
  isBaselineClicked = false,
  isOutlookClicked = false;
  var actualVisibility = true,
  outlookVisibility = true,
  baselineVisibility = true,
  isZoomedIn = false;

  var keyMilestonOption = {
    chart : {
      type : 'scatter',
      renderTo : 'keyMilestoneChart',
      events : {
        load : function () {

          //used to set the timeline position
          //level 1 offset is smaller than level 2 since level 1 chart container is smaller
          var center = 0;
          if (level == 1) {
            center = 155;
          } else {
            center = 200;
          }
          var chart = this;

          chart.renderer.text('Baseline', 20, 60).css({
            fontSize : '13px',
            color : 'black'
          }).add();

          /**
           * Draw the line
           * The yAxis vertical coordinates is found by checking the location of the label on a timeline
           */
          $.each(chart.series, function (i, serie) {
            $.each(serie.data, function (i, point) {
              chart.renderer.path(['M', point.plotX + 10, point.plotY + 55, 'L', point.plotX + 10, center])
              // chart.renderer.path(['M', point.plotX, point.plotY, 'L', point.plotX, center])
              .attr({
                'stroke-width' : 1,
                stroke : point.series.color,
                'class' : 'lines'
              })
              .add();
            });
          });
        },
        selection : function (event) {
          if (event.xAxis) {
            $('.lines').hide();
            isZoomedIn = true;
          } else {
            if (actualVisibility && outlookVisibility && baselineVisibility) {
              $('.lines').show();
            }

            isZoomedIn = false;
          }
        }
      }
    },
    colors : ['#d92329', '#82b4e0', '#92cf51'],
    xAxis : {
      lineWidth : 3,
      title : {
        enabled : true,
        text : 'Timeline'
      },
      startOnTick : true,
      endOnTick : true,
      type : 'datetime',
      labels : {
        overflow : 'justify',
        zIndex : 3
      }
    },
    yAxis : {
      labels : {
        enabled : false
      },
      title : {
        text : ''
      },
      gridLineWidth : 0,
	  min : -80,
	  max: 80
    },
    legend : {
      layout : 'horizontal',
      floating : false,
      borderWidth : 1,
      padding : 10,
      borderColor : 'transparent',
      labelFormatter : function () {
        if (this.name == 'Actual Progress') {
          return 'Outlook Behind Schedule';
        } else if (this.name == 'Original Baseline') {
          return 'Original Baseline';
        } else {
          return 'Outlook on Schedule/Ahead of Schedule';
        }
      }
    },
    plotOptions : {
      series : {
        events : {
          legendItemClick : function (e) {

            e.preventDefault();

            var chart = this;

            if (chart.name == 'Actual Progress') {
              if (!isActualClicked) {
                isActualClicked = true;
                removeLines();
                actualVisibility = chart.visible;
              } else {
                showChart();
                actualVisibility = chart.visible;
                showLines();
                isActualClicked = false;
              }
            } else if (chart.name == 'Original Baseline') {
              if (!isBaselineClicked) {
                isBaselineClicked = true;
                removeLines();
                baselineVisibility = chart.visible;
              } else {
                showChart();
                baselineVisibility = chart.visible;
                showLines();
                isBaselineClicked = false;
              }
            } else {
              if (!isOutlookClicked) {
                isOutlookClicked = true;
                removeLines();
                outlookVisibility = chart.visible;
              } else {
                showChart();
                outlookVisibility = chart.visible;
                showLines();
                isOutlookClicked = false;
              }
            }

            function removeLines() {
              $('.lines').hide();
              chart.hide();
            }

            function showChart() {
              chart.show();
            }
            function showLines() {
              if (actualVisibility && outlookVisibility && baselineVisibility && !isZoomedIn) {
                $('.lines').show();
              }
            }
          }
        },
        showInLegend : true,
        marker : {
          radius : 7,
          states: {
            hover: {
              radius: 12
            }
          }
        }
      }
    },
    series : []
  };

  return keyMilestonOption;
};

//Specific options for Schedule Progress Chart
var setScheduleOption = function () {

  var scheduleOption = {
    chart : {
      type : 'spline',
      renderTo : 'scheduleChart'
    },
    colors : ['#7032ab', '#83962f', '#82b4e0'],
    xAxis : {
      startOnTick : true,
      endOnTick : true,
      showFirstLabel : true,
      showLastLabel : true,
      type : 'datetime',
      labels : {
        style : {
          fontSize : '9px'
        }
      }
    },
    yAxis : {
      title : {
        text : 'Percentage %'
      },
      labels : {
        formatter : function () {
          return this.value;
        }
      },
      min : 0,
      max : 100
    },
    tooltip : {
      shared : true,
      crosshairs : true,
      hideDelay : 0,
      formatter : function () {
//        var newdate = new Date(this.x),
//        result = setCorrectDateFormat(newdate);

//          var newdate = new Date(this.x),
          var result = setCorrectDateFormat(this.x, 'chart');
        s = '<b>Reporting Date</b>:' + result + ' ';

        $.each(this.points, function (i, point) {
          s += '<br/><b>' + point.series.name + '</b>: ' +
          // point.y +'%';
          numberWithCommas(point.y) + '%';
        });

        return s;
      }
    },
    legend : {
      layout : 'horizontal',
      labelFormatter : function () {
        if (this.name.toLowerCase() == 'plan') {
          return 'Plan Progress';
        }
        return this.name;
      }
    },
    plotOptions : {
      series : {
        marker: {
          radius: 4
        }
      }
    },
    series : []
  };

  return scheduleOption;
};

//Specific options for Budget Performance Chart
var setBudgetOption = function () {
  var budgetOption = {
    chart : {
      type : 'bar',
      marginLeft : 300, //margin used for the table
      marginTop : 70, //margin used to align the table cells to the bars on the chart
      marginRight : 20,
      renderTo : 'budgetChart'
    },
    colors : ['#82b4e0', '#d92329'],
    xAxis : [{
      categories : ['', '', '', ''],
      tickLength : 0,
      gridLineWidth : 1
    },
	{categories : ['', '', '', ''],
      tickLength : 0,
      gridLineWidth : 2,
	  opposite: true
	}
	],
    yAxis : {
      gridLineWidth : 1,
      title : {
        text : 'Variance(%)'
      },
      labels : {
        formatter : function () {
          return this.value;
        }
      }
    },
    plotOptions : {
      series : {
        stacking : 'normal',
        cursor : 'pointer',
        events : {
          click : function (e) {
            console.log(e.point);
            var i = e.point.x;
            setSelected('sideTable' + i, i);
          }
        },
        borderColor : 'transparent'
      }
    },
    tooltip : {
      animation : false,
      formatter : function () {
        return '<b>' + this.point.name + '</b><br/>' +
        ((numberWithCommas(this.point.y) === 'N/A') ? 'N/A' : numberWithCommas(this.point.y) + ' %');
      }
    },
    legend : {
      enabled : false
    },
    series : []
  };

  return budgetOption;
};

//Specific options for HSE Chart for project
var setHSEOptionForProject = function (level, isDataEmpty, cat, kpiNulls) {
  var HSEOption = {
    chart : {
      type : 'bar',
      renderTo : 'HSEChart',
      marginRight : 20,
      events : {
        load : function () {
		  
		  //add legend for kpi
		  $('#HSEChart .highcharts-legend-item:first-child rect').attr('fill', '#000');
		  
          if (!isDataEmpty) {
            var chart = this;

            var d = chart.series[0].data;

            console.log('d');
            console.log(d);

            /*
            top and left variable is used to set the position of the 'kpi' value (black line)
            needs to be set based on the level (level 1 with smaller dimension)
             */
            var top = 0,
            left = 0;

            if (level === 1) {
              top = 235;
              left = 475;
            } else {
              top = 320;
              left = 884;
            }
            //var d = kpiArray;
            len = d.length;
            for (var i = 0; i < len; i++) {
			  var strokeColor = 'black';
              var point = d[i],
              plotLine = {},
              // elem = point.graphic.element.getBBox(),
              yStart,
              xStart,
              newline;
              console.log(point, 'black');
              xStart = point.plotX;
              // xStart = elem.x;
              console.log('start' + xStart);
              yStart = point.plotY;
              // yStart = elem.y;

              console.log('HSE point');
              console.log(point);
              // console.log('elem ' + elem);
              // console.log(elem);
              // plotLine.path = ['M', xStart - 30, yStart, 'L', xStart + point.pointWidth -25, yStart];
              plotLine.path = ['M', xStart + point.pointWidth - 5, yStart, 'L', xStart - point.pointWidth + 5, yStart];
			  
			  for(var kIndex = 0; kIndex < kpiNulls.length; kIndex++){
			    if(kpiNulls[kIndex] === i){
				  strokeColor = 'transparent';
				}
			  }
			  
              plotLine.attr = {
                // transform : 'translate(' + left + ',' + top + ') rotate(90) scale(1, 1) scale(-1,1)',
                transform : 'translate(' + left + ',' + top + ') rotate(90) scale(1, 1) scale(-1,1)',
                'stroke-width' : 7,
                stroke : strokeColor,
                zIndex : 5
              };

              newline = chart.renderer.path(plotLine.path).attr(plotLine.attr).add();
            }
          }

        }
      }
    },
    xAxis : {
      categories : cat
    },
    yAxis : {
      allowDecimals : true,
      title : {
        text : 'YTD Cases',
        align : 'middle'
      }
    },
    plotOptions : {
      series : {
        color : '#0066FF',
		events : {
		  legendItemClick : function (){
		    return false;
		  }
		}
      },
      bar : {
        grouping : false,
        borderColor : 'transparent'
      }
    },
    series : []
  };

  return HSEOption;
};

var setGateOption = function () {
  var tooltipContainer = $('#gate-tooltip-container');
  var gateOption = {
    chart : {
      type : 'scatter',
      renderTo : 'gate-chart-container',
     margin : [60, 50, 240, 50],
      // margin : [30, 10, 30, 10],
      borderRadius : 0,
	  events : {
	    load : function (){
		  tooltipContainer.css('opacity', '0');
		},
		click : function(){
		  $('.popover').remove();
		}
	  },
        plotBackgroundImage : 'images/PGDv6.png'//'images/PGDv5.png' //'images/PGDbgGrey.png'
    },
    title : {
      text : ''
    },
    legend : {
      borderWidth : 0,
      y : 10
    },
    tooltip : {
	  enabled : false
    },
    colors : ['#f5f500', '#bf0606', '#02ab9a'],
    credits : {
      enabled : false
    },
	plotOptions : {
      series : {
      marker: {
        radius: 4
      },
        point : {
          events : {
            mouseOver : function () {
                var numberOfMonths = (this.months == 999999 ? 'N/A' : this.months);
              tooltipContainer.css('opacity', '1');
              tooltipContainer.css('border-color', this.graphic.fill);
              tooltipContainer.html(this.name + ', Duration to handover: ' + numberOfMonths);
            }
          }
        },
        events : {
          mouseOut : function () {
            tooltipContainer.empty();
            tooltipContainer.css('opacity', '0');

          }
        }
      }
    },
    xAxis : {
      lineColor : 'transparent',//'#dedede',//'gray',
      min : -40,
      max : 40,
      lineWidth : 1,
      labels : {
        enabled : false
      },
      tickWidth : 2,
      tickInterval : 10,
      offset : -150,
      tickColor : 'transparent'//'#b0b0b0'
    },
    yAxis : {
      lineColor : 'transparent',//'#dedede',//'black',
      title : {
        text : ''
      },
      min : -40,
      max : 40,
      gridLineWidth : 0,
      offset : -178,
      labels : {
        enabled : false
      },
      tickInterval : 10,
      lineWidth : 1,
      minorGridLineWidth : 0,
      minorTickInterval : 10,
      minorTickWidth : 2,
      minorTickColor : 'transparent',//'#b0b0b0',//'black',
      minorTickLength : 5
    },
    series : [
      {
              name: 'Overdue',
              marker: {
                symbol: 'triangle'
              }
              
      },
              {
              name: 'FDPRC-FDP/Adv Funding Overdue',
              marker: {
              symbol: 'cirlce'
              }
              
              },
              {
              name: 'On Time/Ahead of Schedule',
              marker: {
              symbol: 'diamond'
              }
              
              }
              
      ]
  };

  return gateOption;
};

var setMatrixOption = function () {
  var tooltipContainer = $('#matrix-tooltip-container');
  var matrixOption = {
    chart : {
      type : 'scatter',
      renderTo : 'matrix-chart-container',
      margin : [30, 72, 18, 72],
      borderRadius : 0,
        plotBackgroundImage : 'images/PEM_v04.png',//'images/PEMv3.png',//'images/PEMbgWithNumbers.png',
      events : {
        load : function () {
          tooltipContainer.css('opacity', '0');
        }
      }
    },
    title : {
      text : ''
    },
    legend : {
      enabled : false
    },
    tooltip : {
      enabled : false
    },
    colors : ['#b1e0e0', '#bd0000'],
    credits : {
      enabled : false
    },
    plotOptions : {
      series : {
        point : {
          events : {
            mouseOver : function () {
              tooltipContainer.css('opacity', '1');
              tooltipContainer.css('border-color', this.graphic.fill);
                console.log(this);
              tooltipContainer.html(this.name + '<br/>FDP Speed: ' +
                (this.x >= 0 ? '+ ' : '- ') + Math.abs(this.x) + ',<br/>Execution Speed/Reason: ' +
                (this.y >= 0 ? '+ ' : '- ') + Math.abs(this.y) + ', ' + (this.reason.toLowerCase() === 'null' || this.reason.toLowerCase() === undefined || this.reason.toLowerCase() === null ? 'N/A' : this.reason));
            }
          }
        },
        events : {
          mouseOut : function () {
            tooltipContainer.empty();
            tooltipContainer.css('opacity', '0');

          }
        }
      }
    },
    xAxis : {
      min : -15,
      max : 15,
      labels : {
        enabled : false
      },
      offset : -140,
      lineWidth : 0,
      tickInterval : 3,
      tickColor : 'transparent'
    },
    yAxis : {
      min : -15,
      max : 15,
      title : {
        text : ''
      },
      gridLineWidth : 0,
      offset : -177,
      lineWidth : 0,
      labels : {
        enabled : false
      },
      tickColor : 'transparent'
    },
    series : []
  };
  return matrixOption;
};



var setMatrixBreakdownOption = function (data, container, title, colors, description, xPosition, chartType) {
  var matrixBreakdownOption = {
    chart : {
      renderTo : container,
      type : 'pie',
      marginTop : 30,
      marginBottom : 40,
      events : {
        load : function () {

          this.renderer.image('images/info.gif', this.title.alignAttr.x + xPosition, 10, 20, 20)
          .attr({
            'class' : 'info-button',
                'data-chart': chartType
          })
          .add()
//          .on('click', function () {
//              $('.popover').remove();
//            clickedIndicator = $(this);
//            displayPopover(description, 'bottomRightDescription');
//              
//            isPopoverDisplayedLevel2 = true;
//          });
            console.log(' pie chart this.series');
            console.log(this.series);
        }
      }
    },
    colors : colors,
    title : {
      text : title
    },
    tooltip : {
      formatter : function () {
        return parseFloat(this.point.percentage).toFixed(2) + '%, ' + this.point.name;
      }
    },
    plotOptions : {
      pie : {
        slicedOffset : 0,
        cursor : 'pointer',
        dataLabels : {
          enabled : true,
          inside : true,
          connectorWidth : 0,
          distance : -25,
          formatter : function () {
              console.log('pie formatter this.point');
              console.log(this.point);
            var color = '#333';
//            if (this.point.name.toLowerCase() == 'fast fdp, slow execution' ||
//              this.point.name.toLowerCase() == 'slow fdp, fast execution' ||
//              this.point.name.toLowerCase() == 'project team' ||
//              this.point.name.toLowerCase() == 'timing') {
              if (this.point.color == '#02ab9a' ||
                  this.point.color == '#007d7d' ||
                  this.point.color == '#bd0000' ||
                  this.point.color == '#00c994' ||
				  this.point.color == 'rgb(192, 0, 0)') {
              color = '#fff';
            }

            if (this.percentage === 0) {
              color = 'transparent';
            }
            return '<span style="color:' + color + '">' + parseFloat(this.percentage).toFixed(2) + '%';
          }
        },
        showInLegend : true
      },
      series : {
        point : {
          events : {
            legendItemClick : function () {
              return false;
            }
          }
        }
      }
    },
    series : [{
        data : data
      }
    ]
  };

  return matrixBreakdownOption;
};

/* ECCR Options*/

var setCPBWaterfallOption = function(gapValues, cpbData, malaysia, international, total){
  var cpbWaterfallOption = {
        	      chart : {
        	        borderRadius : 0,
        	        type : 'column',
        	        renderTo : 'eccrCpbChartContainer'
        	      },
        	      credits : {
        	        enabled : false
        	      },
        	      legend : {
        	        borderWidth : 0,
        	        itemWidth : 100
        	      },
        	      title : {
        	        text : 'CPB Waterfall Overall'
        	      },
        	      xAxis : {
        	        categories : cpbData.chartdata.categories
        	      },
        	      yAxis : {
        	        //min : 0,
        	        title : {
        	          text : "MYR '000,000"
        	        }
        	      },
        	      tooltip : {
        	        formatter : function () {
        	          console.log(this)
        	          console.log(this.point.x)
					  var yValue = this.y;
					  
					  if(this.key === 'negative'){
					    this.y = this.y * - 1;
					  }
					  
					  var index = this.point.x;
        	          var sum = malaysia[index] + international[index] + total[index];
					  
        	          // return '<b>' + this.x + '</b><br/>' + this.series.name + ': ' + Highcharts.numberFormat(this.y) + '<br/>' +
        	          // 'Total: ' + Highcharts.numberFormat(sum);
					  
					  return '<b>' + this.x + '</b><br/>Malaysia: ' + Highcharts.numberFormat(malaysia[index]) + '<br/>' +
					  '<br/>International: ' + Highcharts.numberFormat(international[index]) + '<br/>' +
        	          'Total: ' + Highcharts.numberFormat(sum);
        	        }
        	      },
        	      plotOptions : {
        	        column : {
        	          stacking : 'normal',
        	          dataLabels : {
        	            enabled : false,
        	            formatter : function () {
        	              if (validateField(this.series.name.toLowerCase()) === 'gap') {
        	                return '';
        	              } else if (Highcharts.numberFormat(this.y) == '0.00') {
        	                return ''
        	              }
						  var positiveIdentifier = '';
						  if(this.key == 'negative'){
							positiveIdentifier = '-'
						  }
						  
        	              var color = '#fff';

        	              if (this.point.shapeArgs.height < 10) {
        	                color = '#000';
        	              }
						  
        	              return '<span style="color: ' + color + '">' + positiveIdentifier + '' + Highcharts.numberFormat(this.y) + '</span>';
        	              //return Highcharts.numberFormat(this.y);
        	            },
        	            color : (Highcharts.theme && Highcharts.theme.dataLabelsColor) || 'white'
        	          },
        	          borderColor : 'transparent'
        	        }
        	      },
        	      series : cpbData.chartdata.series
        	    }; //end cpb option
				
	return cpbWaterfallOption;
}

// MPS Options
var setMPSOption = function() {
  var MPSOption = {
        colors: ["#fc5255", "#95bfe3", "#9f9f9f", "#7798BF"],
        title : {text : 'Manpower Loading Histogram'},
        chart: {
            renderTo: 'mpsChart',
            spacingBottom: 50,
            borderRadius : 0,
            type: 'column'
        },
        xAxis: {
            lineColor : '#02AD9D',
            gridLineColor : '#02AD9D',
            tickColor : '#02AD9D'
        },
        yAxis: {
            min: 0,
            stackLabels: {
                enabled: false,
                style: {
                    fontWeight: 'bold',
                    color: (Highcharts.theme && Highcharts.theme.textColor) || 'gray'
                }
            },
            lineColor : '#02AD9D',
            gridLineColor : '#02AD9D',
            tickColor : '#02AD9D'
        },
        legend: {
            reversed : true,
            borderWidth : 0,
            align: 'center',
            verticalAlign: 'bottom',
            y: 20,
            floating: true,
            shadow: false
        },
        plotOptions: {
            column: {
                stacking: 'normal',
                borderWidth: 0,
                dataLabels: {
                    enabled: false,
                    color: (Highcharts.theme && Highcharts.theme.dataLabelsColor) || 'white',
                    style: {
                        textShadow: '0 0 3px black, 0 0 3px black'
                    }
                }
            }
        },
        tooltip: {
            formatter: function() {
                return '<b>'+ this.x +'</b><br/>'+
                    this.series.name +': '+ this.y +'<br/>'+
                    'Total: '+ this.point.stackTotal;
            }
        },
    };

  return MPSOption;
};

//function for correct formatting of date (result = dd mmm yyyy)
function setCorrectDateFormat(date, type) {
  var values,
  year,
  month,
  day,
  hours,
  minutes,
  seconds,
  formattedDate;
  
  console.log("date before: " + date)

  if (type == 'table') {
    values = date.split(/[^0-9]/),
    year = parseInt(values[0], 10),
    month = parseInt(values[1], 10) - 1,
    day = parseInt(values[2], 10),
    hours = parseInt(values[3], 10),
    minutes = parseInt(values[4], 10),
    seconds = parseInt(values[5], 10),
	
	formattedDate = new Date(year, month, day, hours, minutes, seconds);
  } else {
	formattedDate = new Date(date);
  }

  
  console.log("date data type: " + formattedDate)

  if (formattedDate == 'Invalid Date') {
    return 'N/A'
  }

  year = formattedDate.getFullYear(),
  day = formattedDate.getDate(),
  month = formattedDate.getMonth();

  console.log(day + ' ' + monthNames[month] + ' ' + year);
  return day + ' ' + monthNames[month] + ' ' + year;

}
