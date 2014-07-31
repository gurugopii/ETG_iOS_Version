var timestamp = '{"reportingPeriod":"20130101", "operatorship": "operatorship", "phase": "phase", "update":"13 Mar 2013", "isProjectEnabled":"yes"}';

var reportPeriod;
var monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
//function for highlighting a cell on click


var displayTable, clickedIndicator, isProductionEmpty = false, popoverPlacement = '';
var tabledata = '[{"hse":"red","costPMU":"grey","production":"","projectName":"PROJECT DEMO 01","region":"Pen. Malaysia","costPCSB":"","projectKey":83,"manpower":"","schedule":"red"},{"hse":"green","costPMU":"grey","production":"Red","projectName":"PROJECT DEMO 03","region":"Pen. Malaysia","costPCSB":"","projectKey":89,"manpower":"","schedule":"red"},{"hse":"green","costPMU":"grey","production":"Red","projectName":"PROJECT DEMO 03","region":"Pen. Malaysia","costPCSB":"","projectKey":89,"manpower":"","schedule":"red"},{"hse":"green","costPMU":"grey","production":"Red","projectName":"PROJECT DEMO 03","region":"Pen. Malaysia","costPCSB":"","projectKey":89,"manpower":"","schedule":"red"},{"hse":"green","costPMU":"grey","production":"Red","projectName":"PROJECT DEMO 03","region":"Pen. Malaysia","costPCSB":"","projectKey":89,"manpower":"","schedule":"red"},{"hse":"green","costPMU":"grey","production":"Red","projectName":"PROJECT DEMO 03","region":"Pen. Malaysia","costPCSB":"","projectKey":89,"manpower":"","schedule":"red"},{"hse":"green","costPMU":"grey","production":"Red","projectName":"PROJECT DEMO 03","region":"Pen. Malaysia","costPCSB":"","projectKey":89,"manpower":"","schedule":"red"},{"hse":"green","costPMU":"grey","production":"Red","projectName":"PROJECT DEMO 03","region":"Pen. Malaysia","costPCSB":"","projectKey":89,"manpower":"","schedule":"red"},{"hse":"green","costPMU":"grey","production":"Red","projectName":"PROJECT DEMO 03","region":"Pen. Malaysia","costPCSB":"","projectKey":89,"manpower":"","schedule":"red"},{"hse":"green","costPMU":"grey","production":"Red","projectName":"PROJECT DEMO 03","region":"Pen. Malaysia","costPCSB":"","projectKey":89,"manpower":"","schedule":"red"},{"hse":"green","costPMU":"grey","production":"Red","projectName":"PROJECT DEMO 03","region":"Pen. Malaysia","costPCSB":"","projectKey":89,"manpower":"","schedule":"red"},{"hse":"green","costPMU":"grey","production":"Red","projectName":"PROJECT DEMO 03","region":"Pen. Malaysia","costPCSB":"","projectKey":89,"manpower":"","schedule":"red"},{"hse":"green","costPMU":"grey","production":"Red","projectName":"PROJECT DEMO 03","region":"Pen. Malaysia","costPCSB":"","projectKey":89,"manpower":"","schedule":"red"},{"hse":"green","costPMU":"grey","production":"Red","projectName":"PROJECT DEMO 03","region":"Pen. Malaysia","costPCSB":"","projectKey":89,"manpower":"","schedule":"red"},{"hse":"green","costPMU":"grey","production":"Red","projectName":"PROJECT DEMO 03","region":"Pen. Malaysia","costPCSB":"","projectKey":89,"manpower":"","schedule":"red"},{"hse":"green","costPMU":"grey","production":"Red","projectName":"PROJECT DEMO 03","region":"Pen. Malaysia","costPCSB":"","projectKey":89,"manpower":"","schedule":"red"},{"hse":"green","costPMU":"grey","production":"Red","projectName":"PROJECT DEMO 03","region":"Pen. Malaysia","costPCSB":"","projectKey":89,"manpower":"","schedule":"red"},{"hse":"green","costPMU":"grey","production":"Red","projectName":"PROJECT DEMO 03","region":"Pen. Malaysia","costPCSB":"","projectKey":89,"manpower":"","schedule":"red"},{"hse":"green","costPMU":"grey","production":"Red","projectName":"PROJECT DEMO 03","region":"Pen. Malaysia","costPCSB":"","projectKey":89,"manpower":"","schedule":"red"},{"hse":"green","costPMU":"grey","production":"Red","projectName":"PROJECT DEMO 03","region":"Pen. Malaysia","costPCSB":"","projectKey":89,"manpower":"","schedule":"red"},{"hse":"green","costPMU":"grey","production":"Red","projectName":"PROJECT DEMO 03","region":"Pen. Malaysia","costPCSB":"","projectKey":89,"manpower":"","schedule":"red"},{"hse":"green","costPMU":"grey","production":"Red","projectName":"PROJECT DEMO 03","region":"Pen. Malaysia","costPCSB":"","projectKey":89,"manpower":"","schedule":"red"},{"hse":"green","costPMU":"grey","production":"Red","projectName":"PROJECT DEMO 03","region":"Pen. Malaysia","costPCSB":"","projectKey":89,"manpower":"","schedule":"red"},{"hse":"green","costPMU":"grey","production":"Red","projectName":"PROJECT DEMO 03","region":"Pen. Malaysia","costPCSB":"","projectKey":89,"manpower":"","schedule":"red"},{"hse":"green","costPMU":"grey","production":"Red","projectName":"PROJECT DEMO 03","region":"Pen. Malaysia","costPCSB":"","projectKey":89,"manpower":"","schedule":"red"},{"hse":"green","costPMU":"grey","production":"Red","projectName":"PROJECT DEMO 03","region":"Pen. Malaysia","costPCSB":"","projectKey":89,"manpower":"","schedule":"red"},{"hse":"green","costPMU":"grey","production":"Red","projectName":"PROJECT DEMO 03","region":"Pen. Malaysia","costPCSB":"","projectKey":89,"manpower":"","schedule":"red"},{"hse":"green","costPMU":"grey","production":"Red","projectName":"PROJECT DEMO 03","region":"Pen. Malaysia","costPCSB":"","projectKey":89,"manpower":"","schedule":"red"},{"hse":"green","costPMU":"grey","production":"Red","projectName":"PROJECT DEMO 03","region":"Pen. Malaysia","costPCSB":"","projectKey":89,"manpower":"","schedule":"red"},{"hse":"green","costPMU":"grey","production":"Red","projectName":"PROJECT DEMO 03","region":"Pen. Malaysia","costPCSB":"","projectKey":89,"manpower":"","schedule":"red"},{"hse":"green","costPMU":"grey","production":"Red","projectName":"PROJECT DEMO 03","region":"Pen. Malaysia","costPCSB":"","projectKey":89,"manpower":"","schedule":"red"},{"hse":"green","costPMU":"grey","production":"Red","projectName":"PROJECT DEMO 03","region":"Pen. Malaysia","costPCSB":"","projectKey":89,"manpower":"","schedule":"red"},{"hse":"green","costPMU":"grey","production":"Red","projectName":"PROJECT DEMO 03","region":"Pen. Malaysia","costPCSB":"","projectKey":89,"manpower":"","schedule":"red"},{"hse":"green","costPMU":"grey","production":"Red","projectName":"PROJECT DEMO 03","region":"Pen. Malaysia","costPCSB":"","projectKey":89,"manpower":"","schedule":"red"},{"hse":"green","costPMU":"grey","production":"Red","projectName":"PROJECT DEMO 03","region":"Pen. Malaysia","costPCSB":"","projectKey":89,"manpower":"","schedule":"red"},{"hse":"green","costPMU":"grey","production":"Red","projectName":"PROJECT DEMO 03","region":"Pen. Malaysia","costPCSB":"","projectKey":89,"manpower":"","schedule":"red"},{"hse":"green","costPMU":"grey","production":"Red","projectName":"PROJECT DEMO 03","region":"Pen. Malaysia","costPCSB":"","projectKey":89,"manpower":"","schedule":"red"},{"hse":"green","costPMU":"grey","production":"Red","projectName":"PROJECT DEMO 03","region":"Pen. Malaysia","costPCSB":"","projectKey":89,"manpower":"","schedule":"red"},{"hse":"red","costPMU":"grey","production":"","projectName":"Proj ETG Do Not Touch 2","region":"Pen. Malaysia","costPCSB":"","projectKey":85,"manpower":"","schedule":"red"},{"hse":"green","costPMU":"grey","production":"","projectName":"Proj ETG Do Not Touch 3","region":"Pen. Malaysia","costPCSB":"","projectKey":82,"manpower":"","schedule":"green"},{"hse":"green","costPMU":"grey","production":"","projectName":"Project 80","region":"Pen. Malaysia","costPCSB":"","projectKey":80,"manpower":"green","schedule":"red"},{"hse":"green","costPMU":"grey","production":"","projectName":"Project 86","region":"Pen. Malaysia","costPCSB":"","projectKey":86,"manpower":"","schedule":"yellow"},{"hse":"green","costPMU":"grey","production":"","projectName":"Project 90","region":"Pen. Malaysia","costPCSB":"","projectKey":90,"manpower":"red","schedule":"red"}]';



jQuery(function ($) {

  //Define all variables on the ground.
  var maintable = $('#maintable');
  var maintablebody = $('#maintable tbody');
  var maintablehead = $('#maintable thead');

  $('*').on('touchend', function (e) {
    if (!($(e.target).hasClass('tapForPopover') || $(e.target).is('img') || $(e.target).is('td.withIndicator') || $(e.target).is('.popover *'))) {
	  // $('.popover').remove();
	  clickedIndicator.popover('destroy')
    } 
  });
  
  maintable.delegate('tr', 'click', function (e) {
    $(this).addClass('highlight-row');
	$(this).nextAll().removeClass('highlight-row');
	$(this).prevAll().removeClass('highlight-row');
  });
  
       
       
  
  maintable.tablesorter({
    textExtraction : function (s) {
      if ($(s).find('img').length === 0)
        return $(s).text();
      return $(s).find('img').attr('alt');
    }
	,sortList: [[1, 0]]
  });
       
  // maintable.bind("sortStart", function () {
    // //do your magic here
	// if(clickedIndicator !== undefined){
	  // clickedIndicator.popover('destroy');
	// }
    
  // }).bind("sortEnd", function () {
    // //when done finishing do other magic things
    // if(clickedIndicator !== undefined){
	  // clickedIndicator.popover('destroy');
	// }
  // });
  
  var tapEventListener = function (e) {

    $('.popover').remove();
    clickedIndicator = $(this);
    processThePopoverLogic();
    console.log('show popover');
  }
  
  var isRegionAscending = true,
    isProjectAscending = true,
    isScheduleAscending = true,
    isProductionAscending = true,
    isHSEAscending = true,
    isPMUAscending = true,
    isPCSBAscending = true,
    isManpowerAscending = true;

  //sort event
  var headers = $('.header th');
	
  var sortListener = function(e){
    $('.popover').remove();
      var headerClicked = $(this);
      var column = headerClicked.data('type');
      var sorting;

      //getting unclicked headers and changing its sort image
      headers.not(this).each(function () {
        var unClickedHeader = $(this);
        unClickedHeader.removeClass('asc-sort-image');
        unClickedHeader.removeClass('desc-sort-image');
        unClickedHeader.addClass('normal-sort-image');
      });

      if (column == "region") {
        if (isRegionAscending) {
          sorting = [[0, 1]];
          addSortImage(headerClicked, isRegionAscending);
          isRegionAscending = false;
        } else if (!isRegionAscending) {
          sorting = [[0, 0]];
          addSortImage(headerClicked, isRegionAscending);
          isRegionAscending = true;
        }
      } else if (column == "project") {
        if (isProjectAscending) {
          sorting = [[1, 1]];
          addSortImage(headerClicked, isProjectAscending);
          isProjectAscending = false;
        } else if (!isProjectAscending) {
          sorting = [[1, 0]];
          addSortImage(headerClicked, isProjectAscending);
          isProjectAscending = true;
        }
      } else if (column == "production") {
        if (isProductionAscending) {
          sorting = [[2, 1]];
          addSortImage(headerClicked, isProductionAscending);
          isProductionAscending = false;
        } else if (!isProductionAscending) {
          sorting = [[2, 0]];
          addSortImage(headerClicked, isProductionAscending);
          isProductionAscending = true;
        }
      } else if (column == "hse") {
        if (isHSEAscending) {
          sorting = [[3, 1]];
          addSortImage(headerClicked, isHSEAscending);
          isHSEAscending = false;
        } else if (!isHSEAscending) {
          sorting = [[3, 0]];
          addSortImage(headerClicked, isHSEAscending);
          isHSEAscending = true;
        }
      } else if (column == "schedule") {
        if (isScheduleAscending) {
          sorting = [[4, 1]];
          addSortImage(headerClicked, isScheduleAscending);
          isScheduleAscending = false;
        } else if (!isScheduleAscending) {
          sorting = [[4, 0]];
          addSortImage(headerClicked, isScheduleAscending);
          isScheduleAscending = true;
        }
      } else if (column == "pcsb") {
        if (isPCSBAscending) {
          sorting = [[5, 1]];
          addSortImage(headerClicked, isPCSBAscending);
          isPCSBAscending = false;
        } else if (!isPCSBAscending) {
          sorting = [[5, 0]];
          addSortImage(headerClicked, isPCSBAscending);
          isPCSBAscending = true;
        }
      }else if (column == "manpower") {
        if (isManpowerAscending) {
          sorting = [[7, 1]];
          addSortImage(headerClicked, isManpowerAscending);
          isManpowerAscending = false;
        } else if (!isManpowerAscending) {
          sorting = [[7, 0]];
          addSortImage(headerClicked, isManpowerAscending);
          isManpowerAscending = true;
        }
      } else {
        if (isPMUAscending) {
          sorting = [[6, 1]];
          addSortImage(headerClicked, isPMUAscending);
          isPMUAscending = false;
        } else if (!isPMUAscending) {
          sorting = [[6, 0]];
          addSortImage(headerClicked, isPMUAscending);
          isPMUAscending = true;
        }
      }

      maintable.trigger("sorton", [sorting]);
      // alert("main sort");
      // return false to stop default link action
      return false;
  }

  //---- for testing purposes only --- comment out next line when using actual data
  // showTable(tabledata, timestamp);
  //Populate the main table
  function showTable(tabledataobj, topInfo) {
    //function showTable(tabledataobj) {
    console.log('loggggggg');

    console.log(topInfo);
    console.log(tabledataobj);
    // populateTitleForPortfolio(tabledataobj.projectDetails);
    populateTitleForPortfolio(topInfo);

	tabledataobj = tabledataobj == '(null)' || tabledataobj == undefined ? '[]' : tabledataobj;
    tabledataobj = JSON.parse(tabledataobj);
    console.log('populate table');
	
	var classToProject = '';
	var projectInfo = JSON.parse(topInfo);

	if (validateField(projectInfo.isProjectEnabled) == 'yes') {
	  classToProject = ' tapForPopover project';
	}
    //$('.popover').remove();
    $.each(tabledataobj, function (i, row) {
      //generate scorecard table
      maintablebody.append('<tr>' +
        '<td class="left region-column">' + validateField(row.region) + '</td>' +
        // '<td class="left' + addClassToProject(validateField(row.isProjectEnabled)) + ' project-column" data-projectname="' + validateField(row.projectName) + '" data-type="projectname" data-projectkey="' + validateField(row.projectKey) + '">' + validateField(row.projectName) + '</td>' +
        // '<td class="left tapForPopover project project-column" data-projectname="' + validateField(row.projectName) + '" data-type="projectname" data-projectkey="' + validateField(row.projectKey) + '">' + validateField(row.projectName) + '</td>' +
		'<td class="left' + classToProject + ' project-column" data-projectname="' + validateField(row.projectName) + '" data-type="projectname" data-projectkey="' + validateField(row.projectKey) + '">' + validateField(row.projectName) + '</td>' +
        '<td class="tapForPopover withIndicator left indicator-column" data-projectkey="' + row.projectKey + '" data-projectname="' + row.projectName + '" data-type="production"><img src="' + returnIndicatorPath(row.production) + '" alt="' + row.production + '">' + '</td>' +
        '<td class="tapForPopover withIndicator indicator-column" data-projectkey="' + row.projectKey + '" data-projectname="' + row.projectName + '" data-type="hse"><img src="' + returnIndicatorPath(row.hse) + '" alt="' + row.hse + '">' + '</td>' +
        '<td class="tapForPopover withIndicator indicator-column"  data-projectname="' + row.projectName + '" data-type="schedule"  data-projectkey="' + row.projectKey + '"><img src="' + returnIndicatorPath(row.schedule) + '" alt="' + row.schedule + '">' + '</td>' +
        '<td class="tapForPopover withIndicator indicator-column" data-projectkey="' + row.projectKey + '" data-projectname="' + row.projectName + '" data-type="costpcsb"><img src="' + returnIndicatorPath(row.costPCSB) + '" alt="' + row.costPCSB + '">' + '</td>' +
        '<td class="tapForPopover withIndicator indicator-column" data-projectkey="' + row.projectKey + '"  data-projectname="' + row.projectName + '" data-type="costpmu"><img src="' + returnIndicatorPath(row.costPMU) + '" alt="' + row.costPMU + '">' + '</td>' +
        '<td class="tapForPopover withIndicator indicator-column" data-projectkey="' + row.projectKey + '"  data-projectname="' + row.projectName + '" data-type="manpower"><img src="' + returnIndicatorPath(row.manpower) + '" alt="' + row.manpower + '">' + '</td>' +
        '</tr>');
    });
    $('.tapForPopover').unbind('click', tapEventListener);
    $('.tapForPopover').bind('click', tapEventListener);

	setProperAlignment($('#maintable tr'));
	
	maintable.trigger('update');
	
	headers.unbind('touchend', sortListener);
    headers.bind('touchend', sortListener);
	
  }

  function addClassToProject(identifier){
    if(identifier.toLowerCase() == 'yes'){
	  return ' tapForPopover project';
	} 
	return '';
  }
 
  //Register the listeners on clicking the cells
  function processThePopoverLogic() {
    var self = clickedIndicator;

    var projectname = self.data('projectname');
    var projectkey = self.data('projectkey');
    var type = self.data('type');
    //console.log(projectname+'  '+type);

    //request the json string from Objective-C
    getJsonForPopover(projectkey, projectname, type);

	//----for testing pursposes only
	// displayPopover('[]');
    //Destroy all popovers except for selected one
    $('.tapForPopover').not(self).popover('destroy');
	
	if (type == 'hse') {
	  var noDataAvailableCounter = 0;
	  $('#hseTable tbody tr').each(function (index, row) {
	      var isRowEmpty = true;
	      var tdCounter = 0;
	      $(this).find('td').each(function (innerIndex, innerRow) {
	        if ($(this).text() != 'N/A') {
	          isRowEmpty = false;
	        }
	        tdCounter++;
	      });
	      if (isRowEmpty) {
	        $(this).empty().append('<td colspan="' + tdCounter + '">No Data Available</td>');
	        noDataAvailableCounter++;
	      }
	    
	    
	  });
	  
	  var noDataDuplicateRemoved = false;
	  $('#hseTable tbody tr').each(function (index, row) {
	    if($(this).text() == 'No Data Available' && !noDataDuplicateRemoved && noDataAvailableCounter > 1){
		  $(this).remove();
		  noDataDuplicateRemoved = true;
		}
	    
	  });
	}
	
    console.log('processed the popover');
	if(type !== 'projectname'){
	  // $('.popover').find('.popover-projectname').remove();
	  // $('.popover').prepend('<p class="popover-projectname">'+ (projectname == 'undefined' ? 'N/A' : projectname) +'</p>');
	}
	
  }

  displayTable = showTable;
});

//function to change sorting image on fixed header
function addSortImage(header, isAscending) {
  if (isAscending) {
    header.removeClass('asc-sort-image');
    header.addClass('desc-sort-image');
    return;
  }
  header.removeClass('desc-sort-image');
  header.addClass('asc-sort-image');

}

/*
 * Declare the functions which will prepare the HTML from jsonstrings based on product types
 */

//Provide the proper explanation for the method
//Intented use - request the jsonstring from coredata based on projectname and type of request
function getJsonForPopover(projectkey, projectname, type) {
  var iframe = document.createElement("IFRAME");
  iframe.setAttribute("src", "main:" + "showpopover:" + projectkey + ":" + projectname + ":" + type + ":");
  iframe.setAttribute("height", "1px");
  iframe.setAttribute("width", "1px");
  document.documentElement.appendChild(iframe);
  iframe.parentNode.removeChild(iframe);
  iframe = null;
}

//Called from ObjectiveC to show the popover.
function displayPopover(popoverJson) {
  //var popoverJsonObj = JSON.parse(popoverJson);

  console.log(popoverJson);

  var self = clickedIndicator;
  var projectkey = self.data('projectkey');
  var projectname = self.data('projectname');
  var type = self.data('type');
  //console.log(projectname+'  '+type);


  //Create the popover and show
  self.popover({
    trigger : 'manual',
    placement : getPopoverPlacement,
    html : true,
    animation : false,
    container : 'body',
    content : function () {

      //return popoverJsonObj.name;

      //Commented out this line
      return getHTMLforPopover(type, popoverJson, projectkey);
    }
  })
  .popover('toggle');

  // if(isProductionEmpty){
    // var popoverPosition = $('.popover').position() === undefined ? 0 : $('.popover').position().top;
	// if(!(popoverPosition === 0) && !(popoverPlacement == 'bottomLeft')){
	  // $('.popover').css('top', popoverPosition + 20);
	// }
  // }
}

//Provide the proper explanation for the method
//Intended use - based on type and json string, prepare the required HTML object
function getHTMLforPopover(type, jsonForPopover, projectkey) {
  var toReturn = $('<div>');

  if (type == "projectname") {
    toReturn.append(getHTMLForPopoverProjectName(jsonForPopover));
    return toReturn;
  } else if (type == "schedule") {
    toReturn.append(getHTMLForPopoverSchedule(jsonForPopover));
    return toReturn;
  } else if (type == "production") {
    toReturn.append(getHTMLForPopoverProduction(jsonForPopover));
    return toReturn;
  } else if (type == "hse") {
    toReturn.append(getHTMLForPopoverHSE(jsonForPopover, projectkey));
    return toReturn;
  } else if (type == "costpmu") {
    toReturn.append(getHTMLForPopoverCostPMU(jsonForPopover, projectkey));
    return toReturn;
  } else if (type == "costpcsb") {
    toReturn.append(getHTMLForPopoverCostPCSB(jsonForPopover));
    return toReturn;
  } else if (type == "manpower") {
    toReturn.append(getHTMLForPopoverManpower(jsonForPopover));
    return toReturn;
  }else {
    toReturn.append('Incorrect popover type. Return nothing.');
    return toReturn;
  }
}

//Based on the locatioin of indicator on page, provide the optimal placement for popover
//topleft - top < 300 left <
function getPopoverPlacement(pop, dom_el) {
  var position = $(dom_el).position();

  var top = position.top,
  left = parseInt(position.left);

  console.log('LEFT');
  console.log(left);
  console.log('TOP');
  console.log(top);

  var tableHeight = $(window).height();

  /*
   * !!!!! the values below should be calibrated based on actual ipad use.
   */
  //for production
  if( $(dom_el).data('type') == 'manpower' ){
    if( top < tableHeight )
      return 'bottomRight3';
    else
      return 'topRight3';
  }

  var toreturn = (top < tableHeight && left == 404) ? "bottomLeft"
   : (top >= tableHeight && left == 404) ? "topLeft"
  //schedule
   : (top < tableHeight && left == 604) ? "bottomRightSchedule"
   : (top >= tableHeight && left == 604) ? "topRightSchedule"
  //for pcsb
   : (top < tableHeight && left == 704) ? "bottomRight"
   : (top >= tableHeight && left == 704) ? "topRight"
  //for pmu
   : (top < tableHeight && left == 804) ? "bottomRight2"
   : (top >= tableHeight && left == 804) ? "topRight2"
   : (top < tableHeight && (left == 504 || left == 602 || left == 121)) ? "bottom"
   : "top";

  popoverPlacement = toreturn;
  console.log('PLACEMENT: ' + toreturn);
  console.log('top ' + position.top + ' left ' + position.left + ' chosen side ' + toreturn);
  return toreturn;
}

//added indicator path function
function returnIndicatorPath(indicatorFromJsonStr) {
  var n = null;

  if (indicatorFromJsonStr != n) {
    indicatorFromJsonStr = indicatorFromJsonStr.toLowerCase();
  }
  var indicator = "";

  var cpath = "images/green.png";
  var xpath = "images/red.png";

  // var bluepath = "images/bluelight.png";
  var yellowpath = "images/yellow.png";
  // var graypath = "images/graylight.png";
  // var orangepath = "images/orangelight.png";
  var greenpath = "images/green.png";
  var redpath = "images/red.png";
  var transparentpath = "images/transparent.png";
  var greypath = "images/grey.png";

  var jsonc = "yes";
  var jsonx = "no";
  var jsongreen = "green";
  var jsonred = "red";
  var jsongrey = "grey";
  // var jsonblue = "blue";
  // var jsonorange = "orange";
  var jsony = "yellow";

  //console.log("Indicator(returnIndicatorPath): " + indicatorFromJsonStr);
  if (indicatorFromJsonStr == jsonc || indicatorFromJsonStr == jsonx || indicatorFromJsonStr == jsony || indicatorFromJsonStr == n) // Check if indicatorFromJsonStr is Yes, No, yellow, null or undefined
    indicator = (indicatorFromJsonStr == jsonc) ? cpath :
    // (indicatorFromJsonStr == jsony) ? yellowpath : xpath;
    (indicatorFromJsonStr == jsony) ? yellowpath : 
	(indicatorFromJsonStr == jsongrey || indicatorFromJsonStr == 'NULL' || indicatorFromJsonStr == 'null' || indicatorFromJsonStr == null || indicatorFromJsonStr == 'N/A' || indicatorFromJsonStr == 'n/a') ? greypath : transparentpath;
  else {
    indicator = (indicatorFromJsonStr == jsongreen) ? greenpath :
    (indicatorFromJsonStr == jsonred) ? redpath :
    (indicatorFromJsonStr == jsongrey || indicatorFromJsonStr == 'NULL' || indicatorFromJsonStr == 'null' || indicatorFromJsonStr == null || indicatorFromJsonStr == 'N/A' || indicatorFromJsonStr == 'n/a') ? greypath : transparentpath;
  }
  return indicator;
}

/*
 * Declare the functions which will prepare the HTML from jsonstrings based on product types
 */


function getHTMLForPopoverProjectName(jsonForPopover) {
  var divForPopover = $('<div>');
  var data = JSON.parse(jsonForPopover);
  //var data = '{"chartView":"Chart View", "keyHighlight":"Key Highlights", "projectBackground":"Project Background"}';
  console.log(data);


    var tableProjectName = '<table id="projectTableContainer">' +
		  '<thead>' +
			'<th><center>Project Performance</center></th>' +
		  '</thead>' +
		  '<tbody>' +
			  '<tr>' +
				'<td id="chartView"   ontouchend = "processViewType(this)"> Project Dashboard </td>' +
			  '</tr>' +
			  '<tr>' +
				'<td id="projectView" ontouchend = "processViewType(this)"> Project Background </td>' +
			  '</tr>' +
			  '<tr>' +
    				'<td id="highlightView" ontouchend = "processViewType(this)"> Key Highlights </td>' +
			  '</tr>' +
		  '</tbody>' +
      '</table>';
	  
  //console.log(tableProjectName);
  divForPopover.append(tableProjectName);

  isProductionEmpty = false;
  return divForPopover;
}


function getHTMLForPopoverKeyHighlights() {
  alert("Key Highlights");
}

function getHTMLForPopoverProjectBackground(jsonForPopover) {
  var data = JSON.parse(jsonForPopover);
  alert("ProjectBackground");

}

//generating html for schedule popover
function getHTMLForPopoverSchedule(jsonForPopover) {
  var divForPopover = $('<div class="scheduleDiv"><p class="popover-projectname">' + clickedIndicator.data('projectname') + '</p>');
  var divForTables = $('<div>');
  var divForChart = $('<div class="scheduleDiv" id="scheduleDivForChart">');

  var data = JSON.parse(jsonForPopover);
  // var data = JSON.parse('{"KeyMileStone":{"chartSubtitle":"Project Phase Fid Rev 0","chartContents":[{"data":[{"x":"2023-07-31T00:00:00","name":"Rig Down","y":14},{"x":"2019-02-12T00:00:00","name":"FIR","y":2},{"x":"2017-03-03T00:00:00","name":"FID","y":11},{"x":"2017-02-01T00:00:00","name":"Gate 3","y":9},{"x":"2016-12-20T00:00:00","name":"MR 05","y":8},{"x":"2012-12-11T00:00:00","name":"MR 04","y":7},{"x":"2012-10-31T00:00:00","name":"MR 03b","y":6},{"x":"2017-03-03T00:00:00","name":"FDP\/ADVANCE FUNDING ","y":10},{"x":"2023-08-18T00:00:00","name":"Hand Over Operation","y":1}],"name":"Actual Progress"},{"data":[{"x":"2012-09-01T00:00:00","name":"MR 02","y":4},{"x":"2012-10-01T00:00:00","name":"MR 03a","y":5},{"x":"2020-07-01T00:00:00","name":"Rig Down","y":14},{"x":"2020-02-01T00:00:00","name":"Rig Up","y":12},{"x":"2014-01-01T00:00:00","name":"FID","y":11},{"x":"2012-08-01T00:00:00","name":"MR 01","y":3},{"x":"2020-04-01T00:00:00","name":"1st HC","y":13},{"x":"2013-09-01T00:00:00","name":"Gate 3","y":9},{"x":"2013-07-01T00:00:00","name":"MR 05","y":8},{"x":"2012-11-01T00:00:00","name":"MR 04","y":7},{"x":"2012-10-01T00:00:00","name":"MR 03b","y":6},{"x":"2013-12-02T00:00:00","name":"FDP\/ADVANCE FUNDING ","y":10}],"name":"Original Baseline"},{"data":[{"x":"2011-09-14T00:00:00","name":"MR 02","y":4},{"x":"2019-09-22T00:00:00","name":"Rig Up","y":12},{"x":"2011-09-14T00:00:00","name":"MR 01","y":3},{"x":"2020-04-01T00:00:00","name":"1st HC","y":13}],"name":"Plan"}],"chartTitle":"Key Milestone"},"PlatformSchedule":[{"plannedDt":"2020","platform2":"Facility 1","actualDt":"2020","indicator":"Green"}],"ScheduleVariance":{"indicator":"Gray","actua2l":"0","vsariance":"-7.3392","pla2nned":"7.34"}}')
  // var data = JSON.parse('{"KeyMileStone":"no data"}');
  
  if(data.KeyMileStone == 'no data'){
    data = JSON.parse('{"KeyMileStone":{"chartSubtitle":"N/A","chartContents":[{"data":[],"name":"Actual Progress"},{"data":[],"name":"Original Baseline"},{"data":[],"name":"Plan"}],"chartTitle":"Key Milestone"},"PlatformSchedule":[],"ScheduleVariance":"no data"}')
  }
  
  console.log('data.ScheduleVariance');
  console.log(data.ScheduleVariance);
  var platformList = '';
  if (data.PlatformSchedule.length === 0) {
	platformList += '<tr>' +
						'<td colspan="4" class="noData">No Data Available</td>' +
					'<tr>';
  }
  else {
    //code below is used for populating rows of platform table
    for (var i = 0; i < data.PlatformSchedule.length; i++) {
	  var platformName = validateField(data.PlatformSchedule[i].platform),
	  plannedDate = setCorrectDateFormat(validateField(data.PlatformSchedule[i].plannedDt), 'table'),
	  actualDate = setCorrectDateFormat(validateField(data.PlatformSchedule[i].actualDt), 'table')
      platformList += '<tr>' +
      '<td align="' + setProperColumnAlignment(platformName, 'left') + '">' + platformName + '</td>' +
      '<td align="' + setProperColumnAlignment(plannedDate, 'left') + '">' + plannedDate + '</td>' +
      '<td align="' + setProperColumnAlignment(actualDate, 'left') + '">' + actualDate + '</td>' +
      '<td align="center"><img src="' + returnIndicatorPath(validateField(data.PlatformSchedule[i].indicator)) + '"/></td>' +
      '</tr>';
    }
    //console.log(platformList);
  }

  var varianceBody = '';
  if(data.ScheduleVariance == 'no data' || jQuery.isEmptyObject(data.ScheduleVariance) || data.ScheduleVariance.length === 0){
    varianceBody = '<tbody>' +
					'<td colspan="5" class="noData">No Data Available</td>' +
					'</tbody>';
  } else {
    var plannedPercent = validatePercentField(numberWithCommas(validateNumberField(data.ScheduleVariance.planned))),
	actualPercent = validatePercentField(numberWithCommas(validateNumberField(data.ScheduleVariance.actual))),
	variance_schedule = validatePercentField(numberWithCommas(validateNumberField(data.ScheduleVariance.variance)));
	
	varianceBody = '<tbody>' +
					'<td></td>' +
					'<td class="' + setProperColumnAlignment(plannedPercent, 'right') + '">' + plannedPercent + '</td>' +
					'<td class="' + setProperColumnAlignment(actualPercent, 'right') + '">' + actualPercent + '</td>' +
					'<td class="' + setProperColumnAlignment(variance_schedule, 'right') + '">' + variance_schedule + '</td>' +
					'<td align="center"><img src="' + returnIndicatorPath(validateField(data.ScheduleVariance.indicator)) + '"/></td>' +
					'</tbody>';
  }
  
  //Code below is to define the table required in schedule popover
  divForTables.append('<table id="schedulePlatformTable" class="table table-stripped popoverTable">' + //
    '<thead>' +
    '<tr>' +
    '<th>Platform Name</th>' +
    '<th>Planned</th>' +
    '<th>Actual</th>' +
    '<th>Indicator</th>' +
    '</tr>' +
    '</thead>' +
    '<tbody>' +
    platformList +
	'</tbody>' +
    '</table>' +
    '<table id="scheduleScheduleTable" class="table table-stripped popoverTable">' +
    '<thead>' +
    '<tr>' +
    '<td data-td="small">Schedule Progress (FY ' + reportPeriod + ')</td>' +
    '<th data-outline="1">Planned %</th>' +
    '<th data-outline="2">Actual %</th>' +
    '<th data-outline="3">Var %</th>' +
    '<th data-outline="4">Indicator</th>' +
    '</tr>' +
    '</thead>' +
    varianceBody +
    '</table>');

  var datesArray = [];
  var yearArray = [];
  var monthArray = [];

  $.each(data.KeyMileStone.chartContents, function (i, line) {
    var seriesName = line.name.toLowerCase();
	
    line.data = $.map(line.data, function (data, i) {

        //console.log("Name: "+data.name+" date: "+data.x+" baselineNumbefore: "+data.y);
        //Map the date to Javascript format for Highcharts Consumption
        data.x = xmlDateToJavascriptDate(data.x, true);
        //console.log(data.x);
        data.name = validateField(data.name);
        if (data.x !== null && data.x !== undefined && data.y !== null && data.y !== undefined) {
          // Map baselineNum - height of data point based on the formula provided by FUNC TEAM
          // If baselineNum is smaller than 0 than it is Outlook and has green or red color
          // If baselineNum is larger than 0 that it is Baseline and has blue color
          console.log('name ' + seriesName + ' y value ' + data.y);
          data.y = Math.abs(data.y);
           
          if (seriesName == "actual progress" || seriesName == "plan") {
            data.y = (data.y % 4 == 1 ? -20 : data.y % 4 == 2 ? -50 : data.y % 4 == 3 ? -30 : -70);
          } else if (seriesName == "original baseline") {
            data.y = (data.y % 4 == 1 ? 20 : data.y % 4 == 2 ? 50 : data.y % 4 == 3 ? 30 : 70);
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

  keymilestoneoptions.title = {
    text : data.KeyMileStone.chartTitle + ' (FY ' + reportPeriod + ')',
    style : {
      color : '#02AD9D',
      fontFamily : 'Museo Sans 300',
      fontSize : '15px',
      align : 'center'
    }

  };
  keymilestoneoptions.subtitle = {
    text : data.KeyMileStone.chartSubtitle,
    style : {
      color : '#999',
      fontSize : '13px',
	  fontFamily : 'Museo Sans 300',
    }
  };

  keymilestoneoptions.series = data.KeyMileStone.chartContents;

  keymilestoneoptions.tooltip = {
    shared : false,
	positioner: function () {   //Make the position of tooltip to be fixed on the chart.
      return { x: 80, y: 40 };
    },
    formatter : function () {
      var newdateOfTappedPoint = new Date(this.point.x),
      resultOfTappedPoint = setCorrectDateFormat(newdateOfTappedPoint),
      // matchOfTappedPoint = setCorrectDateFormat(newdateOfTappedPoint),
      matchOfTappedPoint = 'N/A',
      labelNameOfTappedPoint = this.point.name.toLowerCase(),
      titleOfTappedPoint = 'Outlook',
      titleOfMatchPoint = 'Baseline',
      seriesTapped = this.series.name;

      $.each(keymilestoneoptions.series, function (outerIndex, outerRow) {
        if (seriesTapped !== outerRow.name) {
          $.each(outerRow.data, function (innerIndex, innerRow) {
            if (labelNameOfTappedPoint == innerRow.name.toLowerCase()) {
              matchOfTappedPoint = setCorrectDateFormat(new Date(innerRow.x));
            }
          });
        }
      });

      if (seriesTapped == 'Original Baseline') {
        return '<b>'+this.point.name + ' </b>Baseline Date: <b>' + resultOfTappedPoint +
        ' </b>Outlook Date: <b>' + matchOfTappedPoint + '</b>';
      }

      return '<b>'+this.point.name + ' </b>Baseline Date: <b>' + matchOfTappedPoint +
        ' </b>Outlook Date: <b>' + resultOfTappedPoint + '</b>';

    }
  };

  for (var colorIndex = 0; colorIndex < 3; colorIndex++) {
    if (keymilestoneoptions.series[colorIndex].name == "Actual Progress") {
      keymilestoneoptions.series[colorIndex].marker = {
        symbol : 'triangle-down'
      };
      keymilestoneoptions.series[colorIndex].legendIndex = 3;
    } else if (keymilestoneoptions.series[colorIndex].name == "Original Baseline") {
      keymilestoneoptions.series[colorIndex].marker = {
        symbol : 'diamond'
      };
      keymilestoneoptions.series[colorIndex].legendIndex = 1;
    } else {
      keymilestoneoptions.series[colorIndex].marker = {
        symbol : 'triangle'
      };
      keymilestoneoptions.series[colorIndex].legendIndex = 2;
    }
  }

  var keymilestonechart = divForChart.highcharts(keymilestoneoptions);

  //UI Installation Changes 1015
  divForPopover.append(divForChart);
  divForPopover.append(divForTables);

  isProductionEmpty = false;
  
  return divForPopover;
}

//generating html for production popover
function getHTMLForPopoverProduction(jsonForPopover) {
  console.log(jsonForPopover);
  var divForPopover = $('<div id="productionDiv"><p class="popover-projectname">' + clickedIndicator.data('projectname') + '</p>');
  //var data = JSON.parse(jsonForPopover);
  console.log(data);

  var platformNames = [];
  var wells = [];

  var data = JSON.parse(jsonForPopover);
  // var data = JSON.parse('[{"facilityName":"KNJT-C","wellDetails":[{"oilOutlook":0,"oilPlanned":0,"rtbdOutlook":0,"rtbdIndicator":"red","gasOutlook":0,"gasPlanned":0,"gasIndicator":"grey","condyPlanned":0.89,"condyIndicator":"green","condyOutlook":0.89,"sort":1,"oilIndicator":"grey","wellName":"KN-C2","rtbdPlanned":16.2},{"oilOutlook":0,"oilPlanned":0,"rtbdOutlook":0,"rtbdIndicator":"red","gasOutlook":0,"gasPlanned":0,"gasIndicator":"grey","condyPlanned":0.19,"condyIndicator":"green","condyOutlook":0.19,"sort":1,"oilIndicator":"grey","wellName":"KN-C4","rtbdPlanned":19.98},{"oilOutlook":0,"oilPlanned":0,"rtbdOutlook":0,"rtbdIndicator":"red","gasOutlook":146.38,"gasPlanned":146.38,"gasIndicator":"green","condyPlanned":2.37,"condyIndicator":"green","condyOutlook":2.37,"sort":2,"oilIndicator":"grey","wellName":"Total","rtbdPlanned":69.98999999999999},{"oilOutlook":0,"oilPlanned":0,"rtbdOutlook":0,"rtbdIndicator":"red","gasOutlook":146.38,"gasPlanned":146.38,"gasIndicator":"green","condyPlanned":0.75,"condyIndicator":"green","condyOutlook":0.75,"sort":1,"oilIndicator":"grey","wellName":"KNC1-ST1","rtbdPlanned":12.13},{"oilOutlook":0,"oilPlanned":0,"rtbdOutlook":0,"rtbdIndicator":"red","gasOutlook":0,"gasPlanned":0,"gasIndicator":"grey","condyPlanned":0.54,"condyIndicator":"green","condyOutlook":0.54,"sort":1,"oilIndicator":"grey","wellName":"KN-C3","rtbdPlanned":21.68}]},{"facilityName":"KNPG-B","wellDetails":[{"oilOutlook":0,"oilPlanned":0,"rtbdOutlook":0,"rtbdIndicator":"red","gasOutlook":0,"gasPlanned":0,"gasIndicator":"grey","condyPlanned":1.28,"condyIndicator":"green","condyOutlook":1.28,"sort":1,"oilIndicator":"grey","wellName":"KND-3(KN-B3)","rtbdPlanned":28.46},{"oilOutlook":0,"oilPlanned":0,"rtbdOutlook":0,"rtbdIndicator":"red","gasOutlook":0,"gasPlanned":0,"gasIndicator":"grey","condyPlanned":0,"condyIndicator":"grey","condyOutlook":0,"sort":1,"oilIndicator":"grey","wellName":"UUD1 (KN-B4)","rtbdPlanned":12.64},{"oilOutlook":0,"oilPlanned":0,"rtbdOutlook":0,"rtbdIndicator":"red","gasOutlook":0,"gasPlanned":0,"gasIndicator":"grey","condyPlanned":2.61,"condyIndicator":"green","condyOutlook":2.61,"sort":1,"oilIndicator":"grey","wellName":"KND-1(KN-B1)","rtbdPlanned":29.15},{"oilOutlook":0,"oilPlanned":0,"rtbdOutlook":0,"rtbdIndicator":"red","gasOutlook":0,"gasPlanned":0,"gasIndicator":"grey","condyPlanned":1.99,"condyIndicator":"green","condyOutlook":1.99,"sort":1,"oilIndicator":"grey","wellName":"KND-2(KN-B2)","rtbdPlanned":27.25},{"oilOutlook":0,"oilPlanned":0,"rtbdOutlook":0,"rtbdIndicator":"red","gasOutlook":0,"gasPlanned":0,"gasIndicator":"grey","condyPlanned":5.88,"condyIndicator":"green","condyOutlook":5.88,"sort":2,"oilIndicator":"grey","wellName":"Total","rtbdPlanned":97.5}]}]');

  // var data = JSON.parse('[{"platformName":"Platform ABC","wellDetails":[{"wellName2":"Well 1","oilPlanned":"90.000","oilOutlook":"10.00","oilIndicator":"red","gasPlanned":"90.00","gasOutlook2":"80.00","gasIndicator":"red","condyPlanned":"90.00","condyOutlook2":"100.00","condyIndicator":"green","rtbdPlanned":"90.00","rtbdOutlook":"100.00","rtbdIndicator":"green"}]}]');
  // var data = JSON.parse('[{"platformName":"","wellDetails":[]}]');
  //var data = JSON.parse('[]');

  // var table = '<table id="productionTable" class="table table-stripped popoverTable">' +
    // '<th scope="col" colspan="14" class="productionDashedBorder productionMainHeader" style="height: 44px">Production (FY ' + reportPeriod + ')</th>' +
    // '<th scope="col" colspan="5" class="center productionMainHeader">RTBD (FY ' + reportPeriod + ')</th>';

  // if (data.length == 0) {
    // isProductionEmpty = true;
    // table += '<tr class="productionTableHeader2">' +
    // '<th rowspan="2" class="left emptyHeader">&nbsp;</th>' +
    // '<th class="emptyHeader">&nbsp;</th>' +
    // '<th colspan="3">Oil kbd</th>' +
    // '<th class="emptyHeader">&nbsp;</th>' +
    // '<th colspan="3">Gas MMscfd</th>' +
    // '<th class="emptyHeader">&nbsp;</th>' +
    // '<th colspan="3">Condy kboed</th>' +
    // '<th class="emptyHeader productionDashedBorder">&nbsp;</th>' +
    // '<th class="emptyHeader">&nbsp;</th>' +
    // '<th colspan="3">Oil/Gas/Condy MMBOE</th>' +
    // '</tr>' +
    // '<tr class="productionTableHeader2">' +
    // '<th class="emptyHeader">&nbsp;</th><th class="planned">Planned</th>' +
    // '<th>Outlook</th>' +
    // '<th>Ind</th>' +
    // '<th class="emptyHeader">&nbsp;</th>' +
    // '<th class="planned">Planned</th>' +
    // '<th>Outlook</th>' +
    // '<th>Ind</th><th class="emptyHeader">&nbsp;</th>' +
    // '<th class="planned">Planned</th>' +
    // '<th>Outlook</th>' +
    // '<th>Ind</th>' +
    // '<th class="productionDashedBorder emptyHeader">&nbsp;</th>' +
    // '<th class="emptyHeader">&nbsp;</th><th class="planned">Planned</th>' +
    // '<th>Outlook</th>' +
    // '<th>Ind</th>' +
    // '</tr>' +
    // '<tr style="border-top: none">' +
    // '<td colspan="14" class="productionNoData productionDashedBorder">No Data Available</td>' +
    // '<td colspan="5">No Data Available</td>' +
    // '</tr>';
  // }

  // //code below is used for populating rows in production popover
  // for (var a = 0; a < data.length; a++) {
    // var totalRow = '',
	// facilityName = validateField(data[a].facilityName);

    // platformNames[a] = '<tr class="productionTableHeader2">' +
      // '<th rowspan="2" class="emptyHeader facility" style="text-align:' + setProperColumnAlignment(facilityName, 'left') + '">' + facilityName + '</th>' +
      // '<th class="emptyHeader">&nbsp;</th>' +
      // '<th colspan="3">Oil kbd</th>' +
      // '<th class="emptyHeader">&nbsp;</th>' +
      // '<th colspan="3">Gas MMscfd</th>' +
      // '<th class="emptyHeader">&nbsp;</th>' +
      // '<th colspan="3">Condy kboed</th>' +
      // '<th class="emptyHeader productionDashedBorder">&nbsp;</th>' +
      // '<th class="emptyHeader">&nbsp;</th>' +
      // '<th colspan="3">Oil/Gas/Condy MMBOE</th>' +
      // '</tr>' +
      // '<tr class="productionTableHeader2">' +
      // '<th class="emptyHeader">&nbsp;</th><th class="planned-outlook">Planned</th>' +
      // '<th class="planned-outlook">Outlook</th>' +
      // '<th class="ind">Ind</th>' +
      // '<th class="emptyHeader">&nbsp;</th>' +
      // '<th class="planned-outlook">Planned</th>' +
      // '<th class="planned-outlook">Outlook</th>' +
      // '<th class="ind">Ind</th><th class="emptyHeader">&nbsp;</th>' +
      // '<th class="planned-outlook">Planned</th>' +
      // '<th class="planned-outlook">Outlook</th>' +
      // '<th class="ind">Ind</th>' +
      // '<th class="productionDashedBorder emptyHeader">&nbsp;</th>' +
      // '<th class="emptyHeader">&nbsp;</th><th class="planned-outlook">Planned</th>' +
      // '<th class="planned-outlook">Outlook</th>' +
      // '<th class="ind">Ind</th>' +
      // '</tr>';

    // table += platformNames[a];

    // for (var b = 0; b < data[a].wellDetails.length; b++) {
		// var wellName = validateField(data[a].wellDetails[b].wellName),
		// oilPlanned = numberWithCommas(validateNumberField(data[a].wellDetails[b].oilPlanned)),
		// oilOutlook = numberWithCommas(validateNumberField(data[a].wellDetails[b].oilOutlook)),
		// gasPlanned = numberWithCommas(validateNumberField(data[a].wellDetails[b].gasPlanned)),
		// gasOutlook = numberWithCommas(validateNumberField(data[a].wellDetails[b].gasOutlook)),
		// condyPlanned = numberWithCommas(validateNumberField(data[a].wellDetails[b].condyPlanned)),
		// condyOutlook = numberWithCommas(validateNumberField(data[a].wellDetails[b].condyOutlook)),
		// rtbdPlanned = numberWithCommas(validateNumberField(data[a].wellDetails[b].rtbdPlanned)),
		// rtbdOutlook = numberWithCommas(validateNumberField(data[a].wellDetails[b].rtbdOutlook));

      // if (wellName.toLowerCase() == 'total') {
        // totalRow = '<tr>' +
          // '<td class="' + setProperColumnAlignment(wellName, 'left') + '">' + wellName + '</td>' +
          // '<td class="emptyHeader">&nbsp;</td>' +
          // '<td data-planned="oil" class="' + setProperColumnAlignment(oilPlanned, 'right') + ' planned-outlook">' + oilPlanned + '</td>' +
          // '<td data-outlook="oil" class="' + setProperColumnAlignment(oilPlanned, 'right') + ' planned-outlook">' + oilOutlook + '</td>' +
          // '<td class="ind"><img src="' + returnIndicatorPath(validateField(data[a].wellDetails[b].oilIndicator)) + '"/></td>' +
          // '<td class="emptyHeader">&nbsp;</td>' +
          // '<td data-planned="gas" class="' + setProperColumnAlignment(gasPlanned, 'right') + ' planned-outlook">' + gasPlanned + '</td>' +
          // '<td data-outlook="gas" class="' + setProperColumnAlignment(gasOutlook, 'right') + ' planned-outlook">' + gasOutlook + '</td>' +
          // '<td class="ind"><img src="' + returnIndicatorPath(validateField(data[a].wellDetails[b].gasIndicator)) + '"/></td>' +
          // '<td class="emptyHeader">&nbsp;</td>' +
          // '<td data-planned="condy" class="' + setProperColumnAlignment(condyPlanned, 'right') + ' planned-outlook">' + condyPlanned + '</td>' +
          // '<td data-outlook="condy" class="' + setProperColumnAlignment(condyOutlook, 'right') + ' planned-outlook">' + condyOutlook + '</td>' +
          // '<td class="ind"><img src="' + returnIndicatorPath(validateField(data[a].wellDetails[b].condyIndicator)) + '"/></td>' +
          // '<td class="productionDashedBorder emptyHeader">&nbsp;</td>' +
          // '<td class="emptyHeader">&nbsp;</td>' +
          // '<td data-planned="mmboe" class="' + setProperColumnAlignment(rtbdPlanned, 'right') + ' planned-outlook">' + rtbdPlanned + '</td>' +
          // '<td data-outlook="mmboe" class="' + setProperColumnAlignment(rtbdOutlook, 'right') + ' planned-outlook">' + rtbdOutlook + '</td>' +
          // '<td class="ind"><img src="' + returnIndicatorPath(validateField(data[a].wellDetails[b].rtbdIndicator)) + '"/></td>' +
          // '</tr>';
      // } else {

        // wells[b] = '<tr>' +
          // '<td class="' + setProperColumnAlignment(wellName, 'left') + '">' + wellName + '</td>' +
          // '<td class="emptyHeader">&nbsp;</td>' +
          // '<td data-planned="oil" class="' + setProperColumnAlignment(oilPlanned, 'right') + ' planned-outlook">' + oilPlanned + '</td>' +
          // '<td data-outlook="oil" class="' + setProperColumnAlignment(oilPlanned, 'right') + ' planned-outlook">' + oilOutlook + '</td>' +
          // '<td class="ind"><img src="' + returnIndicatorPath(validateField(data[a].wellDetails[b].oilIndicator)) + '"/></td>' +
          // '<td class="emptyHeader">&nbsp;</td>' +
          // '<td data-planned="gas" class="' + setProperColumnAlignment(gasPlanned, 'right') + ' planned-outlook">' + gasPlanned + '</td>' +
          // '<td data-outlook="gas" class="' + setProperColumnAlignment(gasOutlook, 'right') + ' planned-outlook">' + gasOutlook + '</td>' +
          // '<td class="ind"><img src="' + returnIndicatorPath(validateField(data[a].wellDetails[b].gasIndicator)) + '"/></td>' +
          // '<td class="emptyHeader">&nbsp;</td>' +
          // '<td data-planned="condy" class="' + setProperColumnAlignment(condyPlanned, 'right') + ' planned-outlook">' + condyPlanned + '</td>' +
          // '<td data-outlook="condy" class="' + setProperColumnAlignment(condyOutlook, 'right') + ' planned-outlook">' + condyOutlook + '</td>' +
          // '<td class="ind"><img src="' + returnIndicatorPath(validateField(data[a].wellDetails[b].condyIndicator)) + '"/></td>' +
          // '<td class="productionDashedBorder emptyHeader">&nbsp;</td>' +
          // '<td class="emptyHeader">&nbsp;</td>' +
          // '<td data-planned="mmboe" class="' + setProperColumnAlignment(rtbdPlanned, 'right') + ' planned-outlook">' + rtbdPlanned + '</td>' +
          // '<td data-outlook="mmboe" class="' + setProperColumnAlignment(rtbdOutlook, 'right') + ' planned-outlook">' + rtbdOutlook + '</td>' +
          // '<td class="ind"><img src="' + returnIndicatorPath(validateField(data[a].wellDetails[b].rtbdIndicator)) + '"/></td>' +
          // '</tr>';

        // table += wells[b];
      // }
    // }
    // table += totalRow;
	// isProductionEmpty = false;
  // }
  var table = '<table id="productionTable" class="table table-stripped popoverTable">' +
    '<th scope="col" colspan="14" class="productionDashedBorder productionMainHeader" style="height: 44px">Production (FY ' + reportPeriod + ')</th>' +
    '<th scope="col" colspan="5" class="center productionMainHeader">RTBD (FY ' + reportPeriod + ')</th>';

  if (data.length == 0) {
    isProductionEmpty = true;
    table += '<tr class="productionTableHeader2">' +
    '<th rowspan="2" class="left emptyHeader prod-facility">&nbsp;</th>' +
    '<th class="emptyHeader">&nbsp;</th>' +
    '<th colspan="3">Oil kbd</th>' +
    '<th class="emptyHeader">&nbsp;</th>' +
    '<th colspan="3">Gas MMscfd</th>' +
    '<th class="emptyHeader">&nbsp;</th>' +
    '<th colspan="3">Condy kboed</th>' +
    '<th class="emptyHeader productionDashedBorder">&nbsp;</th>' +
    '<th class="emptyHeader">&nbsp;</th>' +
    '<th colspan="3">Oil/Gas/Condy MMBOE</th>' +
    '</tr>' +
    '<tr class="productionTableHeader2">' +
      '<th class="emptyHeader">&nbsp;</th><th class="planned-outlook">Planned</th>' +
      '<th class="planned-outlook">Outlook</th>' +
      '<th class="ind">Ind</th>' +
      '<th class="emptyHeader">&nbsp;</th>' +
      '<th class="planned-outlook">Planned</th>' +
      '<th class="planned-outlook">Outlook</th>' +
      '<th class="ind">Ind</th><th class="emptyHeader">&nbsp;</th>' +
      '<th class="planned-outlook">Planned</th>' +
      '<th class="planned-outlook">Outlook</th>' +
      '<th class="ind">Ind</th>' +
      '<th class="productionDashedBorder emptyHeader">&nbsp;</th>' +
      '<th class="emptyHeader">&nbsp;</th><th class="planned-outlook">Planned</th>' +
      '<th class="planned-outlook">Outlook</th>' +
      '<th class="ind">Ind</th>' +
    '</tr>' +
    '<tr style="border-top: none">' +
    '<td colspan="14" class="productionNoData productionDashedBorder">No Data Available</td>' +
    '<td colspan="5">No Data Available</td>' +
    '</tr>';
  }

  //code below is used for populating rows in production popover
  for (var a = 0; a < data.length; a++) {
    var totalRow = '',
	facilityName = validateField(data[a].facilityName);

    platformNames[a] = '<tr class="productionTableHeader2">' +
      '<th rowspan="2" class="emptyHeader facility" style="text-align:' + setProperColumnAlignment(facilityName, 'left') + '">' + facilityName + '</th>' +
      '<th class="emptyHeader">&nbsp;</th>' +
      '<th colspan="3">Oil kbd</th>' +
      '<th class="emptyHeader">&nbsp;</th>' +
      '<th colspan="3">Gas MMscfd</th>' +
      '<th class="emptyHeader">&nbsp;</th>' +
      '<th colspan="3">Condy kboed</th>' +
      '<th class="emptyHeader productionDashedBorder">&nbsp;</th>' +
      '<th class="emptyHeader">&nbsp;</th>' +
      '<th colspan="3">Oil/Gas/Condy MMBOE</th>' +
      '</tr>' +
      '<tr class="productionTableHeader2">' +
      '<th class="emptyHeader">&nbsp;</th><th class="planned-outlook">Planned</th>' +
      '<th class="planned-outlook">Outlook</th>' +
      '<th class="ind">Ind</th>' +
      '<th class="emptyHeader">&nbsp;</th>' +
      '<th class="planned-outlook">Planned</th>' +
      '<th class="planned-outlook">Outlook</th>' +
      '<th class="ind">Ind</th><th class="emptyHeader">&nbsp;</th>' +
      '<th class="planned-outlook">Planned</th>' +
      '<th class="planned-outlook">Outlook</th>' +
      '<th class="ind">Ind</th>' +
      '<th class="productionDashedBorder emptyHeader">&nbsp;</th>' +
      '<th class="emptyHeader">&nbsp;</th><th class="planned-outlook">Planned</th>' +
      '<th class="planned-outlook">Outlook</th>' +
      '<th class="ind">Ind</th>' +
      '</tr>';

    table += platformNames[a];

    for (var b = 0; b < data[a].wellDetails.length; b++) {
		var wellName = validateField(data[a].wellDetails[b].wellName),
		oilPlanned = numberWithCommas(validateNumberField(data[a].wellDetails[b].oilPlanned)),
		oilOutlook = numberWithCommas(validateNumberField(data[a].wellDetails[b].oilOutlook)),
		gasPlanned = numberWithCommas(validateNumberField(data[a].wellDetails[b].gasPlanned)),
		gasOutlook = numberWithCommas(validateNumberField(data[a].wellDetails[b].gasOutlook)),
		condyPlanned = numberWithCommas(validateNumberField(data[a].wellDetails[b].condyPlanned)),
		condyOutlook = numberWithCommas(validateNumberField(data[a].wellDetails[b].condyOutlook)),
		rtbdPlanned = numberWithCommas(validateNumberField(data[a].wellDetails[b].rtbdPlanned)),
		rtbdOutlook = numberWithCommas(validateNumberField(data[a].wellDetails[b].rtbdOutlook));

      if (wellName.toLowerCase() == 'total') {
        totalRow = '<tr>' +
          '<td class="' + setProperColumnAlignment(wellName, 'left') + '">' + wellName + '</td>' +
          '<td class="emptyHeader">&nbsp;</td>' +
          '<td data-planned="oil" class="' + setProperColumnAlignment(oilPlanned, 'right') + ' planned-outlook">' + oilPlanned + '</td>' +
          '<td data-outlook="oil" class="' + setProperColumnAlignment(oilPlanned, 'right') + ' planned-outlook">' + oilOutlook + '</td>' +
          '<td class="ind"><img src="' + returnIndicatorPath(validateField(data[a].wellDetails[b].oilIndicator)) + '"/></td>' +
          '<td class="emptyHeader">&nbsp;</td>' +
          '<td data-planned="gas" class="' + setProperColumnAlignment(gasPlanned, 'right') + ' planned-outlook">' + gasPlanned + '</td>' +
          '<td data-outlook="gas" class="' + setProperColumnAlignment(gasOutlook, 'right') + ' planned-outlook">' + gasOutlook + '</td>' +
          '<td class="ind"><img src="' + returnIndicatorPath(validateField(data[a].wellDetails[b].gasIndicator)) + '"/></td>' +
          '<td class="emptyHeader">&nbsp;</td>' +
          '<td data-planned="condy" class="' + setProperColumnAlignment(condyPlanned, 'right') + ' planned-outlook">' + condyPlanned + '</td>' +
          '<td data-outlook="condy" class="' + setProperColumnAlignment(condyOutlook, 'right') + ' planned-outlook">' + condyOutlook + '</td>' +
          '<td class="ind"><img src="' + returnIndicatorPath(validateField(data[a].wellDetails[b].condyIndicator)) + '"/></td>' +
          '<td class="productionDashedBorder emptyHeader">&nbsp;</td>' +
          '<td class="emptyHeader">&nbsp;</td>' +
          '<td data-planned="mmboe" class="' + setProperColumnAlignment(rtbdPlanned, 'right') + ' planned-outlook">' + rtbdPlanned + '</td>' +
          '<td data-outlook="mmboe" class="' + setProperColumnAlignment(rtbdOutlook, 'right') + ' planned-outlook">' + rtbdOutlook + '</td>' +
          '<td class="ind"><img src="' + returnIndicatorPath(validateField(data[a].wellDetails[b].rtbdIndicator)) + '"/></td>' +
          '</tr>';
      } else {

        wells[b] = '<tr>' +
          '<td class="' + setProperColumnAlignment(wellName, 'left') + '">' + wellName + '</td>' +
          '<td class="emptyHeader">&nbsp;</td>' +
          '<td data-planned="oil" class="' + setProperColumnAlignment(oilPlanned, 'right') + ' planned-outlook">' + oilPlanned + '</td>' +
          '<td data-outlook="oil" class="' + setProperColumnAlignment(oilPlanned, 'right') + ' planned-outlook">' + oilOutlook + '</td>' +
          '<td class="ind"><img src="' + returnIndicatorPath(validateField(data[a].wellDetails[b].oilIndicator)) + '"/></td>' +
          '<td class="emptyHeader">&nbsp;</td>' +
          '<td data-planned="gas" class="' + setProperColumnAlignment(gasPlanned, 'right') + ' planned-outlook">' + gasPlanned + '</td>' +
          '<td data-outlook="gas" class="' + setProperColumnAlignment(gasOutlook, 'right') + ' planned-outlook">' + gasOutlook + '</td>' +
          '<td class="ind"><img src="' + returnIndicatorPath(validateField(data[a].wellDetails[b].gasIndicator)) + '"/></td>' +
          '<td class="emptyHeader">&nbsp;</td>' +
          '<td data-planned="condy" class="' + setProperColumnAlignment(condyPlanned, 'right') + ' planned-outlook">' + condyPlanned + '</td>' +
          '<td data-outlook="condy" class="' + setProperColumnAlignment(condyOutlook, 'right') + ' planned-outlook">' + condyOutlook + '</td>' +
          '<td class="ind"><img src="' + returnIndicatorPath(validateField(data[a].wellDetails[b].condyIndicator)) + '"/></td>' +
          '<td class="productionDashedBorder emptyHeader">&nbsp;</td>' +
          '<td class="emptyHeader">&nbsp;</td>' +
          '<td data-planned="mmboe" class="' + setProperColumnAlignment(rtbdPlanned, 'right') + ' planned-outlook">' + rtbdPlanned + '</td>' +
          '<td data-outlook="mmboe" class="' + setProperColumnAlignment(rtbdOutlook, 'right') + ' planned-outlook">' + rtbdOutlook + '</td>' +
          '<td class="ind"><img src="' + returnIndicatorPath(validateField(data[a].wellDetails[b].rtbdIndicator)) + '"/></td>' +
          '</tr>';

        table += wells[b];
      }
    }
    table += totalRow;
	isProductionEmpty = false;
  }

  table += '</table>';
  console.log(table);
  
  divForPopover.append(table);
  var divForPopoverContainer = $('<div id="productionDivContainer">');
  divForPopoverContainer.append(divForPopover);
  return divForPopoverContainer;
}

//generating html for hse popover
function getHTMLForPopoverHSE(jsonForPopover) {
  var divForPopover = $('<div>');
  var str = "";
  
  var data = JSON.parse(jsonForPopover);
  // var data = JSON.parse('[{"indicator":"grey","ytdCriteria":"Near Miss","ytdCriteriaValue":2},{"indicator":"grey","ytdCriteria":"FAR","ytdCriteriaValue":10},{"indicator":"grey","ytdCriteria":"LTI","ytdCriteriaValue":2},{"indicator":"grey","ytdCriteria":"FI","ytdCriteriaValue":2},{"indicator":"grey","ytdCriteria":"TRC","ytdCriteriaValue":1},{"indicator":"grey","ytdCriteria":"Testing","ytdCriteriaValue":5}]');
  //var data = JSON.parse('[]');
  // var data = JSON.parse('[{"ytdCriteria":"Testing","indicator":"grey"},{"ytdCriteria":"FAR","indicator":"grey"},{"ytdCriteria":"TRC","indicator":"grey"},{"ytdCriteria":"LTI","indicator":"grey"},{"ytdCriteria":"FI","indicator":"grey"},{"ytdCriteria":"NM","indicator":"grey"}]');
  
  var hseValue = '',
  hseHeader = '',
  hseIndicator = '';

  for (var hseIndex = 0; hseIndex < data.length; hseIndex++) {
    hseHeader += '<td>' + validateField(data[hseIndex].ytdCriteria) + '</td>';
    hseValue += '<td>' + validateField(data[hseIndex].ytdCriteriaValue) + '</td>';
    // hseIndicator += '<td><img src="' + returnIndicatorPath(validateField(data[hseIndex].indicator)) + '" alt="' + validateField(data[hseIndex].indicator) + '"/></td>';
    hseIndicator += '<td class="indicatorsForHSE" style="background-image: url(\'' + returnIndicatorPath(validateField(data[hseIndex].indicator)) + '\');"></td>';
  }

  var tableHSE = '<p class="popover-projectname title-background">' + clickedIndicator.data('projectname') + '</p></div><table id="hseTable" class="table table-stripped popoverTable"><thead><tr>' +
    '<th data-hse="header" colspan="' +data.length+ '">HSE Performance&nbsp;(FY ' + reportPeriod + ')</th>' +
    '</tr></thead>' +
    '<tbody>' +
    '<tr>' +
    hseHeader +
    '</tr>' +
    '<tr>' +
    hseValue +
    '</tr>' +
    '<tr>' +
    hseIndicator +
    '</tr>' +
    '</tbody>' +
    '</table>';

	
  if(data.length == 0){
    tableHSE = '<table id="hseTable" class="table-stripped popoverTable"><thead><tr>' +
    '<th data-hse="header" colspan="10">HSE Performance (FY ' + reportPeriod + ')</th>' +
    '</tr></thead>' +
    '<tr>' +
		'<td colspan="10" style="width: 200px">No Data Available</td>' +
    '</tr>' +
    '</table>';
  }
  
  divForPopover.append(tableHSE);
  
  // divForPopover.append(tableHSEDesc);
  isProductionEmpty = false;
  return divForPopover;
}

//generating html for cost pmu popover
function getHTMLForPopoverCostPMU(jsonForPopover) {
  var divForPopover = $('<div class="pmuDiv"><p class="popover-projectname title-background">' + clickedIndicator.data('projectname') + '</p>');
  var CostPMU1 = "";
  var CostPMU2 = "";
  var data = JSON.parse(jsonForPopover);
  // var data = JSON.parse('{"WPBDetails":[{"wpbIndicator":"red","section":"Common Budget Item","yepG":"1200"},{"wpbIndicator":"red","section":"Common Budget Item","yepG2":"1200"},{"wpbIndicator":"red","wpbVariance":12.897,"section":"Common Budget Item","yepG":"1200"},{"wpbIndicator":"red","section2":"Drilling","yepG":"100"}],"FDPPerformance":[{"vowd":"0","tpFipFdp":"0","afc":"0","fia":"62700000","variance":"0","indicator":"gray"}]}');
  
  //var data = JSON.parse('{"WPBDetails":[],"FDPPerformance":"no data"}');
  console.log(data);

  if(data.FDPPerformance == 'no data' || jQuery.isEmptyObject(data.FDPPerformance) || data.FDPPerformance.length == 0){
    CostPMU1 = CostPMU1 + '<tr>' +
    '<td colspan="7" class="noData">No Data Available</td>' +
    '</tr>';
  } else {
      $.each(data.FDPPerformance, function(index, row){
             var tpFidFdp = numberWithCommasWithoutDecimal(validateNumberField(row.tpFipFdp)),
             fia = numberWithCommasWithoutDecimal(validateNumberField(row.fia)),
             vowd = numberWithCommasWithoutDecimal(validateNumberField(row.vowd)),
             afc = numberWithCommasWithoutDecimal(validateNumberField(row.afc)),
             variance_pmu1 = validatePercentField(numberWithCommas(validateNumberField(row.variance)));
             
             CostPMU1 = CostPMU1 + '<tr>' +
             '<td>&nbsp</td>' +
             '<td class="' + setProperColumnAlignment(tpFidFdp, 'right') + '">' + tpFidFdp + '</td>' +
             '<td class="' + setProperColumnAlignment(fia, 'right') + '">' + fia + '</td>' +
             '<td class="' + setProperColumnAlignment(vowd, 'right') + '">' + vowd + '</td>' +
             '<td class="' + setProperColumnAlignment(afc, 'right') + '">' + afc + '</td>' +
             '<td class="' + setProperColumnAlignment(variance_pmu1, 'right') + '">' + variance_pmu1 + '</td>' +
             '<td class="center"><img width = "30px" src="' + returnIndicatorPath(validateField(row.indicator)) + '"/></td>' +
             '</tr>';
      });
    
	
    
  }
  
  if(data.WPBDetails.length == 0){
    CostPMU2 = CostPMU2 + '<tr>' +
        '<td colspan="8" class="noData">No Data Available</td>' +
      '</tr>';
  }

  for (var i = 0; i < data.WPBDetails.length; i++) {
    var section = validateField(data.WPBDetails[i].section),
	originalWpb = numberWithCommasWithoutDecimal(validateNumberField(data.WPBDetails[i].originalWpb)),
	yepG = numberWithCommasWithoutDecimal(validateNumberField(data.WPBDetails[i].yepG)),
	yerCoApproved = numberWithCommasWithoutDecimal(validateNumberField(data.WPBDetails[i].yerCoApproved)),
	abrApproved = numberWithCommasWithoutDecimal(validateNumberField(data.WPBDetails[i].abrApproved)),
	latestWpb = numberWithCommasWithoutDecimal(validateNumberField(data.WPBDetails[i].latestWpb)),
	variance_pmu2 = validatePercentField(numberWithCommas(validateNumberField(data.WPBDetails[i].wpbVariance)));
	
    // CostPMU2 = CostPMU2 + '<tr>' +
      // '<td class="' + setProperColumnAlignment(section, 'left') + '" data-name="wpb">' + section + '</td>' +
      // '<td class="' + setProperColumnAlignment(originalWpb, 'right') + '">' + originalWpb + '</td>' +
      // '<td class="' + setProperColumnAlignment(yepG, 'right') + '">' + yepG + '</td>' +
      // '<td class="' + setProperColumnAlignment(yerCoApproved, 'right') + '">' + yerCoApproved + '</td>' +
      // '<td class="' + setProperColumnAlignment(abrApproved, 'right') + '">' + abrApproved + '</td>' +
      // '<td class="' + setProperColumnAlignment(latestWpb, 'right') + '">' + latestWpb + '</td>' +
      // '<td class="' + setProperColumnAlignment(variance_pmu2, 'right') + '">' + variance_pmu2 + '</td>' +
      // '<td class="center"><img width = "30px" src="' + returnIndicatorPath(validateField(data.WPBDetails[i].wpbIndicator)) + '"/></td>' +
      // '</tr>';
	  
	  CostPMU2 = CostPMU2 + '<tr>' +
      '<td class="' + setProperColumnAlignment(section, 'left') + '" data-name="wpb">' + section + '</td>' +
      '<td class="' + setProperColumnAlignment(originalWpb, 'right') + '">' + originalWpb + '</td>' +
      '<td class="' + setProperColumnAlignment(yerCoApproved, 'right') + '">' + yerCoApproved + '</td>' +
      '<td class="' + setProperColumnAlignment(abrApproved, 'right') + '">' + abrApproved + '</td>' +
      '<td class="' + setProperColumnAlignment(latestWpb, 'right') + '">' + latestWpb + '</td>' +
      '<td class="' + setProperColumnAlignment(yepG, 'right') + '">' + yepG + '</td>' +
      '<td class="' + setProperColumnAlignment(variance_pmu2, 'right') + '">' + variance_pmu2 + '</td>' +
      '<td class="center"><img width = "30px" src="' + returnIndicatorPath(validateField(data.WPBDetails[i].wpbIndicator)) + '"/></td>' +
      '</tr>';
  }

  var tablePMU_1 = '<table id="pmuTable1" class="table table-stripped popoverTable" ><thead><tr>' +
    '<th>FDP Governance</th>' +
    '<th>TP/FIP/FDP</th>' +
    '<th>FIA</th>' +
    '<th>VOWD</th>' +
    '<th>AFC</th>' +
    '<th>Var %</th>' +
    '<th>Indicator</th>' +
	'</thead>' +
    '</tr>' + CostPMU1 + '</table>';

  // var tablePMU_2 = '<table id="pmuTable2" class="table table-stripped popoverTable"><thead><tr>' +
    // '<th>WPB Governance (FY ' + reportPeriod + ')</th>' +
    // '<th>Original WPB</th>' +
    // '<th>YEP(g)</th>' +
    // '<th>YERCO Approved</th>' +
    // '<th>ABR Approved</th>' +
    // '<th>Latest WPB</th>' +
    // '<th>Var %</th>' +
    // '<th>Indicator</th>' +
	// '</thead>' +
    // '</tr>' + CostPMU2 + '</table>';
	/*a. Original WPB
    b. Approved Carry Over
    c. Approved ABR
    d. Latest WPB
    e. YEP*/
  var tablePMU_2 = '<table id="pmuTable2" class="table table-stripped popoverTable"><thead><tr>' +
    '<th>WPB Governance (FY ' + reportPeriod + ')</th>' +
    '<th>Original WPB</th>' +
    '<th>Approved Carry Over</th>' + // YERCO Approved
    '<th>Approved ABR</th>' +
    '<th>Latest WPB</th>' +
	'<th>YEP</th>' +
    '<th>Var %</th>' +
    '<th>Indicator</th>' +
	'</thead>' +
    '</tr>' + CostPMU2 + '</table>';

  divForPopover.append(tablePMU_1);
  divForPopover.append(tablePMU_2);
  isProductionEmpty = false;
  return divForPopover;
}

//generating html for cost pcsb popover
function getHTMLForPopoverCostPCSB(jsonForPopover) {
  var divForPopover = $('<div id="pcsbDiv"><p class="popover-projectname title-background">' + clickedIndicator.data('projectname') + '</p>');

  var data = JSON.parse(jsonForPopover);
  // var data = JSON.parse('{"APCPerformance":{"latestApc":234510.32,"vowd":19, "afc":12,"apcVariance":32 },"CPBPerformance":{"originalCpb":23400000,"latestCpb":0,"indicator":"green", "variance": 10.89},"AFEPerformance":[{"afeSection":"section", "latestAfe":9283927,"afeVowd":3456,"afeAfc":2342,"afeVariance":7281}]}');
  
  //var data = JSON.parse('{"APCPerformance":[],"CPBPerformance":[],"AFEPerformance":[]}');
  

  var apcTableBody = '';
  
  if(data.APCPerformance == 'no data' || data.APCPerformance.length == 0){
    apcTableBody = 	'<tbody>'+
					'	<tr>' +
						'<td colspan="7" class="noData">No Data Available</td>' +
					'	</tr>' +
					'</tbody>';
  } else {
    apcTableBody = '<tbody>';
	
	var latestApc = numberWithCommasWithoutDecimal(validateNumberField(data.APCPerformance.latestApc)),
	vowd_apc = numberWithCommasWithoutDecimal(validateNumberField(data.APCPerformance.vowd)),
	afc = numberWithCommasWithoutDecimal(validateNumberField(data.APCPerformance.afc)),
	variance_apc = validatePercentField(numberWithCommas(validateNumberField(data.APCPerformance.apcVariance)));
	
//    for(var i=0; i < data.APCPerformance.length; i++){
	apcTableBody += '	<tr>' +
				'		<td colspan="2"></td>' +
				'		<td class="' + setProperColumnAlignment(latestApc, 'right') + '">' + latestApc + '</td>' +
				'		<td class="' + setProperColumnAlignment(vowd_apc, 'right') + '">' + vowd_apc + '</td>' +
				'		<td class="' + setProperColumnAlignment(afc, 'right') + '">' + afc + '</td>' +
				'		<td class="' + setProperColumnAlignment(variance_apc, 'right') + '">' + variance_apc + '</td>' +
				'		<td class="center"><img src="' + returnIndicatorPath(data.APCPerformance.apcIndicator) + '"/></td>' +
				'	</tr>';
//	}
	apcTableBody += '</tbody>';
  }
  divForPopover.append('<table id="pcsbTable1" class="table table-stripped popoverTable">' +
    '<thead>' +
    '	<tr>' +
    '		<th colspan="2">APC Governance (FY ' + reportPeriod + ')</th>' +
    '		<th>Latest APC</th>' +
    '		<th>VOWD</th>' +
    '		<th>AFC</th>' +
    '		<th>Var %</th>' +
    '		<th>Indicator</th>' +
    '	</tr>' +
    '</thead>' +
    apcTableBody +
    '</table>');

  var appendToTable = "";
  
  if (data.AFEPerformance.length == 0) {
    appendToTable =  '	<tr>' +
						'<td colspan="7" style="text-align:center">No Data Available</td>' +
					'	</tr>';
  }
  else {
    for (var i = 0; i < data.AFEPerformance.length; i++) {
	  var afeSection = validateField(data.AFEPerformance[i].afeSection),
	  latestAfe = numberWithCommasWithoutDecimal(validateNumberField(data.AFEPerformance[i].latestAfe)),
	  afe_vowd = numberWithCommasWithoutDecimal(validateNumberField(data.AFEPerformance[i].afeVowd)),
	  afeAfc = numberWithCommasWithoutDecimal(validateNumberField(data.AFEPerformance[i].afeAfc)),
	  afe_variance = validatePercentField(numberWithCommas(validateNumberField(data.AFEPerformance[i].afeVariance)))
	  
      appendToTable += '	<tr>' +
      '		<td colspan="2" style="text-align:' + setProperColumnAlignment(afeSection, 'left') + '">' + afeSection + '</td>' +
      '		<td class="' + setProperColumnAlignment(latestAfe, 'right') + '">' + latestAfe + '</td>' +
      '		<td class="' + setProperColumnAlignment(afe_vowd, 'right') + '">' + afe_vowd + '</td>' +
      '		<td class="' + setProperColumnAlignment(afeAfc, 'right') + '">' + afeAfc + '</td>' +
      '		<td class="' + setProperColumnAlignment(afe_variance, 'right') + '">' + afe_variance + '</td>' +
      '		<td class="center"><img src="' + returnIndicatorPath(validateField(data.AFEPerformance[i].afeIndicator)) + '"/></td>' +
      '	</tr>';
    } 
  }
  
  
  divForPopover.append('<table id="pcsbTable2" class="table table-stripped pcsbTable popoverTable">' +
    '<thead>' +
    '	<tr>' +
    '		<th colspan="2">AFE Governance (FY ' + reportPeriod + ')</th>' +
    '		<th>Latest AFE</th>' +
    '		<th>VOWD</th>' +
    '		<th>AFC</th>' +
    '		<th>Var%</th>' +
    '		<th>Indicator</th>' +
    '	</tr>' +
    '</thead>' +
    '<tbody>' +
    appendToTable +
    '</tbody>' +
    '</table>');

  var cpbTableBody = ''
  if (data.CPBPerformance == 'no data' || data.CPBPerformance.length == 0) {
    cpbTableBody =  '	<tr>' +
						'<td colspan="8" class="noData">No Data Available</td>' +
					'	</tr>';
  }
  else {
    
	  var originalCPB = numberWithCommasWithoutDecimal(validateNumberField(data.CPBPerformance.originalCpb)),
	  latestCPB = numberWithCommasWithoutDecimal(validateNumberField(data.CPBPerformance.latestCpb)),
	  ytdActual = numberWithCommasWithoutDecimal(validateNumberField(data.CPBPerformance.ytdActual)),
	  yepE = numberWithCommasWithoutDecimal(validateNumberField(data.CPBPerformance.yep_e)),
	  variance_cpb = validatePercentField(numberWithCommas(validateNumberField(data.CPBPerformance.variance)));
	  
//    for (var i = 0; i < data.CPBPerformance.length; i++) {
      cpbTableBody += 	'	<tr>' +
						'		<td colspan="2"></td>' +
						'		<td class="' + setProperColumnAlignment(originalCPB, 'right') + '">' + originalCPB + '</td>' +
						'		<td class="' + setProperColumnAlignment(latestCPB, 'right') + '">' + latestCPB + '</td>' +
						'		<td class="' + setProperColumnAlignment(ytdActual, 'right') + '">' + ytdActual + '</td>' +
						'		<td class="' + setProperColumnAlignment(yepE, 'right') + '">' + yepE + '</td>' +
						'		<td class="' + setProperColumnAlignment(variance_cpb, 'right') + '">' + variance_cpb + '</td>' +
						'		<td class="left"><img src="' + returnIndicatorPath(validateField(data.CPBPerformance.indicator)) + '"/></td>' +
						'	</tr>';
//    }
  }
  divForPopover.append('<table id="pcsbTable3" class="table table-stripped pcsbTable popoverTable">' +
    '<thead>' +
    '	<tr>' +
    '		<th colspan="2">CPB Governance (FY ' + reportPeriod + ')</th>' +
    '		<th>Original CPB</th>' +
    '		<th>Latest CPB</th>' +
    '		<th>YTD Actual</th>' +
    '		<th>YEP (E)</th>' +
    '		<th>Var %</th>' +
    '		<th>Indicator</th>' +
    '	</tr>' +
    '</thead>' +
    '<tbody>' +
    cpbTableBody +
    '</tbody>' +
    '</table>');

	isProductionEmpty = false;
  return divForPopover;
}


//generating html for cost manpower popover
function getHTMLForPopoverManpower(jsonForPopover){
  var data = JSON.parse(jsonForPopover);
  // var data = JSON.parse('{"indicatorTotalCriticalBar":"green","indicatorTotalRequirementBar":"green","title":"Manning Status (FY14)","totalCritical":100,"totalRequirement":100}');
  var blue = '#93BEE5', green = '#92D050', yellow = '#FFDC2C', red = '#D7252D';
  // var title = data.title;
  var title = 'Manning Status (FY' + reportPeriod + ')';
  var projectName = clickedIndicator.data('projectname');
  var headerText = projectName + '<br>' + title;
  var popoverLegend = '<tr>'+
                      '    <td>'+
                      '        <div class="mpsPopoverLegend">'+
                      '           <div class="mpsPopoverlegendCircle" style="background-color:'+ green +';"></div>'+
                      '           <div class="mpsPopoverLegendText">≥70% of the Positions are Filled</div>'+
                      '        </div>'+
                      '        <div class="mpsPopoverLegend">'+
                      '           <div class="mpsPopoverlegendCircle" style="background-color:'+ yellow +';"></div>'+
                      '           <div class="mpsPopoverLegendText">≥50% and <70% of the Positions are Filled</div>'+
                      '        </div>'+
                      '        <div class="mpsPopoverLegend">'+
                      '           <div class="mpsPopoverlegendCircle" style="background-color:'+ red +';"></div>'+
                      '           <div class="mpsPopoverLegendText">&lt;50% of the Positions are Filled</div>'+
                      '        </div>'+
                      '    </td>'+
                      '    <td>'+
                      '        <div class="mpsPopoverLegend">'+
                      '           <div class="mpsPopoverlegendCircle" style="background-color:'+ green +';"></div>'+
                      '           <div class="mpsPopoverLegendText">≥85% of the Critical Positions are Filled</div>'+
                      '        </div>'+
                      '        <div class="mpsPopoverLegend">'+
                      '           <div class="mpsPopoverlegendCircle" style="background-color:'+ yellow +';"></div>'+
                      '           <div class="mpsPopoverLegendText">≥70% and &lt;80% of the Critical Positions are Filled</div>'+
                      '        </div>'+
                      '        <div class="mpsPopoverLegend">'+
                      '           <div class="mpsPopoverlegendCircle" style="background-color:'+ red +';"></div>'+
                      '           <div class="mpsPopoverLegendText">&lt;70% of the Critical Positions are Filled</div>'+
                      '        </div>'+
                      '    </td>'+
                      '</tr>';

  if( typeof data.totalRequirement === 'undefined' ){
    return  '<div id="mpsPopoverContainer">'+
            '    <table id="mpsPopoverTable" class="table popovertable">'+
            '        <thead>'+
            '            <tr>'+
            '                <th colspan="2" class="mpsPopoverHeader">'+ headerText +'</th>'+
            '            </tr>'+
            '            <tr>'+
            '                <th>Total Requirements (filled)</th>'+
            '                <th>Critical Position (filled)</th>'+
            '            </tr>'+
            '        </thead>'+
            '        <tbody>'+
            '            <tr>'+
            '                <td colspan="2" style="text-align:center;">No Data Available</td>'+
            '            </tr>'+
            popoverLegend +
            '        </tbody>'+
            '    </table>'+
            '    <div class="mpsPopoverLegend">'+
            '    </div>'+
            '</div>';
  }

  var totalRequirementPercentage = data.totalRequirement;
  var criticalPositionPercentage = data.totalCritical;
  var totalRequirementBarColor = data.indicatorTotalRequirementBar == 'green' ? green : data.indicatorTotalRequirementBar == 'yellow' ? yellow : data.indicatorTotalRequirementBar == 'red' ? red : blue;
  var criticalBarColor = data.indicatorTotalCriticalBar == 'green' ? green : data.indicatorTotalCriticalBar == 'yellow' ? yellow : data.indicatorTotalCriticalBar == 'red' ? red : blue;
  var totalTextColorStyle = ( data.indicatorTotalRequirementBar == 'green' || data.indicatorTotalRequirementBar == 'red' ) ? 'color:#FFF;' : '';
  var criticalTextColorStyle = ( data.indicatorTotalCriticalBar == 'green' || data.indicatorTotalCriticalBar == 'red' ) ? 'color:#FFF;' : '';

  return  '<div id="mpsPopoverContainer">'+
          '    <table id="mpsPopoverTable" class="table popovertable">'+
          '        <thead>'+
          '            <tr>'+
          '                <th colspan="2" class="mpsPopoverHeader">'+ headerText +'</th>'+
          '            </tr>'+
          '            <tr>'+
          '                <th>Total Requirements (filled)</th>'+
          '                <th>Critical Position (filled)</th>'+
          '            </tr>'+
          '        </thead>'+
          '        <tbody>'+
          '            <tr>'+
          '                <td>'+
          '                    <div class="mpsBarContainer">'+
          '                      <div style="background-color:'+ totalRequirementBarColor +';width:'+ totalRequirementPercentage +'%;'+ totalTextColorStyle +'">'+ totalRequirementPercentage +'%</div>'+
          '                    </div>'+
          '                </td>'+
          '                <td>'+
          '                    <div class="mpsBarContainer">'+
          '                      <div style="background-color:'+ criticalBarColor +';width:'+ criticalPositionPercentage +'%;'+ criticalTextColorStyle +'">'+ criticalPositionPercentage +'%</div>'+
          '                    </div>'+
          '                </td>'+
          '            </tr>'+
          popoverLegend+
          '        </tbody>'+
          '    </table>'+
          '</div>';
}

var isActualClicked = false,
isBaselineClicked = false,
isOutlookClicked = false;
var actualVisibility = true,
outlookVisibility = true,
baselineVisibility = true;
//Key Milestone chart chart options
var keymilestoneoptions = {
  chart : {
    type : 'scatter',
    events : {
      load : function () {
        var chart = this;

        chart.renderer.text('Baseline', 20, 50).css({
          fontSize : '13px',
          color : '#000'
        }).add();
        chart.renderer.text('Outlook', 20, 240).css({
          fontSize : '13px',
          color : '#000'
        }).add();

        /**
         * Draw the line
         * The yAxis vertical coordinates is found by checking the location of the label on a plotLine
         */
        $.each(chart.series, function (i, serie) {
          $.each(serie.data, function (i, point) {
            chart.renderer.path([
                'M', point.plotX + 30, point.plotY + 55,
                'L', point.plotX + 30, 140]).
            attr({
              'stroke-width' : 1,
              stroke : point.series.color,
              'class' : 'lines'
            }).add();
          });
        });

        //console.log(chart);

      },
      selection : function (event) {
        if (event.xAxis) {
          $('.lines').hide();
        } else {
          $('.lines').show();
        }
      }
    },
	style : {
      fontFamily : 'Museo Sans 300'
    },
	marginLeft : 30,
	marginRight : 30
  },
  colors : ['#d92329', '#82b4e0', '#92cf51'],
  credits : {
    enabled : false
  },
  xAxis : {
    title : {
      enabled : true,
      text : 'Timeline',
	  style : {
	    color : '#000'
	  }
    },
	labels : {
      style : {
        color : '#000'
      }
    },
    lineWidth : 3,
    startOnTick : true,
    endOnTick : true,
    offset : -100,
    type : 'datetime',
    lineColor : '#02AD9D'
  },
  yAxis : {
    labels : {
      enabled : false
    },
    title : {
      text : ""
    },
    gridLineWidth : 0,
    plotLines : [{
        color : 'transparent',
        value : '0',
        width : '3',
        label : {
          align : 'left',
          text : "0",

          style : {
            color : 'transparent',
            fontWeight : 'bold'
          }
        }
      }
    ],
    min : -80,
    max: 80
  },
  legend : {
    layout : 'horizontal',
	itemStyle : {
      color : '#999',
      font : 'Museo Sans 300',
      fontSize : '12px'
    },
    verticalAlign : 'bottom',
    floating : false,
    borderWidth : 0,
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

          var chart = this,
          length = chart.data.length,
          id = '';

          if (chart.name == 'Actual Progress') {
            id = 'red';
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
            id = 'green';
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
            id = 'blue';
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
            if (actualVisibility && outlookVisibility && baselineVisibility) {
              $('.lines').show();
            }
          }
        }
      },
      showInLegend : true,
      marker : {
        radius : 7,
        states : {
          hover : {
            marker : {
              radius : 12
            }
          }
        }
      },
      dataLabels : {
        enabled : false,
        distance : 30,
        style : {
          color : '#999'
        },
        formatter : function () {
          var name = this.point.name.toLowerCase();
          if (name == '1st hc' || name == '1st ia') {
            var monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
            date = new Date(this.point.x),
            year = date.getFullYear(),
            day = date.getDate(),
            month = date.getMonth();

            return this.point.name + ': ' + day + ' ' + monthNames[month] + ' ' + year;
          }
          return this.point.name;
        }
      }
    }
  },
  tooltip : {
    //crosshairs: true,
    shared : false,
    hideDelay : 0,
    formatter : function () {
      var newdate = new Date(this.point.x);
      var year = newdate.getFullYear();
      var day = newdate.getDate();
      var month = newdate.getMonth() + 1;
      var result = year + '-' + month + '-' + day;

      return '<b>' + this.series.name + '</b><br/>' +
      'Date: ' + result + ' Milestone ' + this.point.name;
    }
  },
  series : []
};

/**
 * Return a Javascript Date for the given XML Schema date string.  Return
 * null if the date cannot be parsed.
 *
 * Does not know how to parse BC dates or AD dates < 100.
 *
 * Valid examples of input:
 * 2010-04-28T10:46:37.0123456789Z
 * 2010-04-28T10:46:37.37Z
 * 2010-04-28T10:46:37Z
 * 2010-04-28T10:46:37
 * 2010-04-28T10:46:37.012345+05:30
 * 2010-04-28T10:46:37.37-05:30
 * 1776-04-28T10:46:37+05:30
 * 0150-04-28T10:46:37-05:30
 */
var xmlDateToJavascriptDate = function (xmlDate) {
  // It's times like these you wish Javascript supported multiline regex specs
  var re = /^([0-9]{4,})-([0-9]{2})-([0-9]{2})T([0-9]{2}):([0-9]{2}):([0-9]{2})(\.[0-9]+)?(Z|([+\-])([0-9]{2}):([0-9]{2}))?$/;
  var match = xmlDate.match(re);
  if (!match)
    return null;

  var all = match[0];
  var year = match[1];
  var month = match[2];
  var day = match[3];
  var hour = match[4];
  var minute = match[5];
  var second = match[6];
  var milli = match[7];
  var z_or_offset = match[8];
  var offset_sign = match[9];
  var offset_hour = match[10];
  var offset_minute = match[11];

  if (offset_sign) { // ended with +xx:xx or -xx:xx as opposed to Z or nothing
    var direction = (offset_sign == "+" ? 1 : -1);
    hour = parseInt(hour, 10) + parseInt(offset_hour, 10) * direction;
    minute = parseInt(minute, 10) + parseInt(offset_minute, 10) * direction;
  }
  var utcDate = Date.UTC(year, month - 1, day, hour, minute, second, (milli || 0));

  //Return the time milliseconds
  return utcDate;

  //Return the date object
  //return new Date(utcDate);
};

//function below is used for setting indicator for production popover
function totalIndicator(outlook, plan) {
  /*
  •   Green : When Outlook ≥ Planned
  •   Red : When Outlook < Planned
  •   Grey : When Outlook = 0 and Planned = 0
   */

  var greenpath = "images/green.png",
  redpath = "images/red.png",
  greypath = "images/grey.png",
  transparentpath = "images/transparent.png";

  if (outlook === 0 && plan === 0) {
    return greypath;
  } else if (outlook >= plan) {
    return greenpath;
  } else if (outlook < plan) {
    return redpath;
  }
  return transparentpath;

}

function processViewType(element) {
  var view = $('#' + element.id).data("view");
  //    alert (element.id);
  var elementName = element.id;
  //    console.log(view)
  var projectKey = $('#' + element.id).data("projectKey");
  callToObjectiveC(view, elementName, projectKey);
}

function callToObjectiveC(viewType, elementName, projectkey) {
  var iframe;
  iframe = document.createElement("IFRAME");
  if (elementName == "chartView") {
    iframe.setAttribute("src", "js-chartView:" + projectkey);
  } else if (elementName == "highlightView") {
    iframe.setAttribute("src", "js-highlightView:showHighlightView");
  } else {
    iframe.setAttribute("src", "js-projectView:showProjectView");
  }
  iframe.setAttribute("height", "1px");
  iframe.setAttribute("width", "1px");
  document.documentElement.appendChild(iframe);
  iframe.parentNode.removeChild(iframe);
  iframe = null;
}



function populateTitleForPortfolio(projectData) {
  var monthNames = ["", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
  var json = JSON.parse(projectData);
  console.log('json.reportingPeriod');
  console.log(json.reportingPeriod);
  console.log(json.reportingPeriod.substring(4, 6));
  console.log(json.reportingPeriod.substring(0, 4));
  reportPeriod = json.reportingPeriod.substring(2, 4);
  console.log(json.reportPeriod);
  $('#report-period').empty().append('Reporting Period: ' + monthNames[Number(json.reportingPeriod.substring(4, 6))] + ' ' + json.reportingPeriod.substring(0, 4));
  $('#operatorship').empty().append('Operatorship: ' + json.operatorship + ' ');
  $('#phase').empty().append('Phase: ' + json.phase);
  $('#update').empty().append('Last Updated on: ' + json.update);
}

//function for correct formatting of date (result = dd mmm yyyy)
function setCorrectDateFormat(date) {
  year = date.getFullYear(),
  day = date.getDate(),
  month = date.getMonth();

  return day + ' ' + monthNames[month] + ' ' + year;
}


function validatePercentField(field){
  return field == 'N/A' ? 'N/A' : (field + '%');
}

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


function setProperColumnAlignment(field, actualAlignment){
  return field === "N/A" ? 'center' : actualAlignment;
}
