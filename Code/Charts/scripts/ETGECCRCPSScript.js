

//######################################################################
//DEFINE GLOBAL VARIABLES
var APC_NAME = "APC",
FDP_NAME = "FDP",
CPB_NAME = "CPB",
WPB_NAME = "WPB",
AFE_NAME = "AFE";

var activePosition = 0;
var popoverPlacement = '';
var isPopoverDisplayed = false;
var activeTabName = 'apc';
//Define the Governance Level to be displayed
var governanceLevels = {};
governanceLevels[APC_NAME] = "Level 1 Governance";
governanceLevels[FDP_NAME] = "Level 1 Governance";
governanceLevels[CPB_NAME] = "Level 2 Governance";
governanceLevels[WPB_NAME] = "Level 2 Governance";
governanceLevels[AFE_NAME] = "Level 3 Governance";

//Define the default top information which will be overwritten by passed JSON
var reportTopInfo = {};
reportTopInfo[APC_NAME] = {
  status : "",
  currency : ""
};
reportTopInfo[FDP_NAME] = {
  status : "",
  currency : ""
};
reportTopInfo[CPB_NAME] = {
  status : "",
  currency : ""
};
reportTopInfo[WPB_NAME] = {
  status : "",
  currency : ""
};
reportTopInfo[AFE_NAME] = {
  status : "",
  currency : ""
};

//######################################################################
//STATIC STRINGS

//thead for each report
var apcThead = "<thead><tr><th></th><th>Activity</th><th>APC (Gate 3)</th><th>APC (FID 0)</th><th>APC (Latest)</th><th>CumVOWD</th><th>AFC</th><th>Var(%)</th><th>G Ind</th><th>P Ind</th></tr></thead>";
var fdpThead = "<thead><tr><th></th><th>Activity</th><th>FDP/TP</th><th>FIA</th><th>CumVOWD</th><th>AFC</th><th>Var(%)</th><th>G Ind</th></tr></thead>";
var cpbThead = "<thead><tr><th></th><th>Activity</th><th>Original CPB</th><th>Latest CPB</th><th>YTD Plan</th><th>YTD Actual</th><th>YEP</th><th>Var(%)</th><th>G Ind</th><th>P Ind</th></tr></thead>";
var wpbThead = "<thead><tr><th></th><th>Budget Item</th><th>Original WPB</th><th>Approved Carry Over</th><th>Approved ABR</th><th>Latest WPB</th><th>YTD Actual</th><th>YEP</th><th>Var(%)</th><th>G Ind</th></thead>";
var afeThead = "<thead><tr><th></th><th>AFE Description</th><th>Original AFE</th><th>Latest AFE</th><th>AFC</th><th>Latest AFE Var(%)</th><th>G Ind</th><th>CumVOWD</th></tr></thead>";

var staticTopInfo = JSON.parse('{"status":"", "currency":""}');
var emptyArrayJSON = JSON.parse('[]');

//######################################################################
// REGISTER EVENT LISTENERS

//Variable for cell reference for clicked Activity/BudgetItem
var tappedCell;

//Register the event for tapping on Tabs
// $('#cpsTabs a.tabSwitch').on('touchend', function (e) {
$('#cpsTabs a.tabSwitch').on('click', function (e) {
  if ($(this).parent('li').hasClass('active')) {
    //If the tab is already selected don't do anything
    // $($(this).attr('href')).hide();
  } else {
    e.preventDefault();
    //Set the governance level for the tab
    $('#governanceLevel').text(governanceLevels[$(this).text()]);
    //Set the top info based on the tab selected
    $('#status').text("Status: " + reportTopInfo[$(this).text()].status);
    $('#currency').text("Currency: " + reportTopInfo[$(this).text()].currency);

    $(this).tab('show');

    sendNotificationToIOS('ECCR', 'changetab', $(this).text());
  }

  var activeIndex = $($(this).attr('href')).index();
  console.log(activeIndex)
  window.swiper.slide(activeIndex);
  $('#pagination em span').each(function (index, row) {
    if ($(this).hasClass('filled')) {
      $(this).removeClass('filled').addClass('empty');
    }

    if (index == activeIndex) {
      $(this).removeClass('empty').addClass('filled');
    }
    window.swiper.slide(activeIndex, 100);
    console.log(index)
  });
  $('#resultsTabContent').scrollTop(0);
  $('#swiper').scrollTop(0);
  $('.swipe-wrap').scrollTop(0);

});

//Register the event on tapping the + to expand row
$("body").delegate("td.expandRows", 'touchend', function () {
  // toggleCollapseRow($(this).closest('tbody'));
  toggleCollapseRow($(this).closest('tr'));

  //				if($(this).text() == '+'){
  //				  $(this).text('-');
  //				} else {
  //				   $(this).text('+');
  //				}

  if ($(this).text() == '+' && !($(this).next().text().toLowerCase() == 'total')) {
    $(this).text('-');
  } else if ($(this).text() == '-' && !($(this).next().text().toLowerCase() == 'total')) {
    $(this).text('+');
  }
});

$("body").delegate("td.tapForPopover", "touchend", function (e) {
  console.log($(this));
  //Save the reference for displaying popover
  tappedCell = $(this);
  sendNotificationToIOS("ECCR", "justificationFor" + $(this).data("reportname"), $(this).data("key"));
  //displayPopover(justificationDataForBudgetItem);
  //Destroy all popovers except for selected one
  $('.tapForPopover').not(tappedCell).popover('destroy');
  isPopoverDisplayed = true;
});

//The listener for clicking anyther on the document. To destroy popovers.
$(document).on("touchend", function (e) {
  var $target = $(e.target),
  isPopover = $(e.target).is('.tapForPopover') && !$(e.target).is('#innerPopoverContent'),
  // isPopoverContainer = $(e.target).is('.popover-content'),
  isPopoverContainer = $(e.target).is($('.popover-content')),
  isPopoverInnerContainer = $(e.target).is('#innerPopoverContent'),
  isPopoverInnerContainers = $(e.target).is('#innerPopoverContent > div'),
  inPopover = $(e.target).closest('.popover').length > 0;
  //hide only if clicked on button or inside popover
  if (!isPopover) {
    //alert('destroy')
    //$('.tapForPopover').popover('destroy');
    isPopoverDisplayed = false
  }

});
//####################################
//swiping feature

var tabPositions = ['APC', 'FDP', 'CPB', 'WPB', 'AFE'];
var governanceText = ['Level 1', 'Level 1', 'Level 2', 'Level 2', 'Level 3'];
var tabIdentifiers = ['apcTab', 'fdpTab', 'cpbTab', 'wpbTab', 'afeTab'];

//for swiping feature
var elem = document.getElementById('swiper');

//controlling the nav icons active and inactive state
var bullets = document.getElementById('pagination').getElementsByTagName('em');
window.swiper = new Swipe(elem, {
    speed : 400,
    continuous : false,
    //disableScroll : true,
    callback : function (pos) {
      var i = bullets.length; //Gets the number of items in the var bullets.
      while (i--) {
        // bullets[i].className = 'off'; //Sets the inactive position indicators.
        bullets[i].innerHTML = '<span class="empty">&#8226;</span>'; //Sets the inactive position indicators.
      }
      // bullets[pos].className = 'on'; //Applies styling of .on to active position indicator.
      bullets[pos].innerHTML = '<span class="filled">&#8226;</span>'; //Applies styling of .on to active position indicator.
      $('.popover').remove();

      var newPosition = tabPositions[pos];

      $('#cpsTabs	 a[href="#' + tabIdentifiers[pos] + '"]').tab('show');

      console.log(tabIdentifiers[pos]);
      $('#governanceLevel').text(governanceText[pos] + ' Governance');
      $('#status').text("Status: " + reportTopInfo[newPosition].status);
      $('#currency').text("Currency: " + reportTopInfo[newPosition].currency);
      $('#resultsTabContent').scrollTop(0);
      $('#swiper').scrollTop(0);
      $('.swipe-wrap').scrollTop(0);

      sendNotificationToIOS('ECCR', 'changetab', tabPositions[pos]);
    }
    //$('#resultsTopBar a[href="#replicateTab"]').tab('show');
  });

//######################################################################
//MAIN POPUlATE FUNCTION

//Main Populate method
//populateCps(cpsData);
//populateCps(cpsDec2013);
function populateCps(cpsData) {

  $("#apcCapexTable").empty();
  $("#apcOpexTable").empty();
  $("#fdpCapexTable").empty();
  $("#fdpOpexTable").empty();
  $("#wpbCapexTable").empty();
  $("#wpbOpexTable").empty();
  $("#afeCapexTable").empty();
  $("#afeOpexTable").empty();
  $("#cpbCapexTable").empty();
  $("#cpbOpexTable").empty();
  console.log(cpsData);

  //Populate the reportTopInfo variable

  //null or empty data checks
  cpsData.apc = cpsData.apc === undefined || cpsData.apc === null ? JSON.parse('{"apcTopInformation":{"status":"", "currency":""}, "apcTableDataCapex":[], "apcTableDataOpex":[]}') : cpsData.apc;
  cpsData.fdp = cpsData.fdp === undefined || cpsData.fdp === null ? JSON.parse('{"fdpTopInformation":{"status":"", "currency":""}, "fdpTableDataCapex":[], "fdpTableDataOpex":[]}') : cpsData.fdp;
  cpsData.cpb = cpsData.cpb === undefined || cpsData.cpb === null ? JSON.parse('{"cpbTopInformation":{"status":"", "currency":""}, "cpbTableDataCapex":[], "cpbTableDataOpex":[]}') : cpsData.cpb;
  cpsData.wpb = cpsData.wpb === undefined || cpsData.wpb === null ? JSON.parse('{"wpbTopInformation":{"status":"", "currency":""}, "wpbTableDataCapex":[], "wpbTableDataOpex":[]}') : cpsData.wpb;
  cpsData.afe = cpsData.afe === undefined || cpsData.afe === null ? JSON.parse('{"afeTopInformation":{"status":"", "currency":""}, "afeTableDataCapex":[], "afeTableDataOpex":[]}') : cpsData.afe;

  //TODO Provide some NULL or empty data checks
  reportTopInfo[APC_NAME] = cpsData.apc === undefined ? JSON.parse('{"apcTopInformation":{"status":"", "currency":""}}') :
    cpsData.apc.apcTopInformation === undefined ? staticTopInfo : cpsData.apc.apcTopInformation;
  reportTopInfo[FDP_NAME] = cpsData.fdp === undefined ? JSON.parse('{"fdpTopInformation":{"status":"", "currency":""}}') :
    cpsData.fdp.fdpTopInformation === undefined ? staticTopInfo : cpsData.fdp.fdpTopInformation;
  reportTopInfo[CPB_NAME] = cpsData.cpb === undefined ? JSON.parse('{"cpbTopInformation":{"status":"", "currency":""}}') :
    cpsData.cpb.cpbTopInformation === undefined ? staticTopInfo : cpsData.cpb.cpbTopInformation;
  reportTopInfo[WPB_NAME] = cpsData.wpb === undefined ? JSON.parse('{"wpbTopInformation":{"status":"", "currency":""}}') :
    cpsData.wpb.wpbTopInformation === undefined ? staticTopInfo : cpsData.wpb.wpbTopInformation;
  reportTopInfo[AFE_NAME] = cpsData.afe === undefined ? JSON.parse('{"afeTopInformation":{"status":"", "currency":""}}') :
    cpsData.afe.afeTopInformation === undefined ? staticTopInfo : cpsData.afe.afeTopInformation;

  cpsData.topInformation = cpsData.topInformation === undefined ? JSON.parse('{"project":"", "reportingPeriod":"", "update":""}') : cpsData.topInformation;

  //set active tab
  activeTabName = validateField(cpsData.activeTab).toLowerCase();
  console.log(activeTabName)

  //get active tab
  var tabs = $('#cpsTabs'),
  activeTab = tabs.find('li.active'),
  activeTabText = activeTab.find('a.tabSwitch').text();

  $("#topInformation").empty().append('<div id="projectName">Project Name: <b>' + validateField(cpsData.topInformation.project) + '</b></div>' +
    '<p id="reportingPeriod">Reporting Period: ' + validateField(cpsData.topInformation.reportingPeriod) + '</p>' +
    '<p id="status">Status: ' + validateField(reportTopInfo[activeTabText].status) + '</p>' +
    '<p id="currency">Currency: ' + validateField(reportTopInfo[activeTabText].currency) + '</p>' +
    '<p id="update">Update: ' + validateField(cpsData.topInformation.update) + '</p>');

  //TODO Check if arrays are empty and then replace with empty array message "No data available"
  cpsData.apc.apcTableDataCapex = cpsData.apc.apcTableDataCapex === undefined ||
    cpsData.apc.apcTableDataCapex === "no data" ||
    cpsData.apc.apcTableDataCapex === null ? emptyArrayJSON :
    cpsData.apc.apcTableDataCapex;
  cpsData.apc.apcTableDataOpex = cpsData.apc.apcTableDataOpex === undefined ||
    cpsData.apc.apcTableDataOpex === "no data" ||
    cpsData.apc.apcTableDataOpex === null ? emptyArrayJSON :
    cpsData.apc.apcTableDataOpex;

  cpsData.fdp.fdpTableDataCapex = cpsData.fdp.fdpTableDataCapex === undefined ||
    cpsData.fdp.fdpTableDataCapex === "no data" ||
    cpsData.fdp.fdpTableDataCapex === null ? emptyArrayJSON :
    cpsData.fdp.fdpTableDataCapex;
  cpsData.fdp.fdpTableDataOpex = cpsData.fdp.fdpTableDataOpex === undefined ||
    cpsData.fdp.fdpTableDataOpex === "no data" ||
    cpsData.fdp.fdpTableDataOpex === null ? emptyArrayJSON :
    cpsData.fdp.fdpTableDataOpex;

  cpsData.cpb.cpbTableDataCapex = cpsData.cpb.cpbTableDataCapex === undefined ||
    cpsData.cpb.cpbTableDataCapex === "no data" ||
    cpsData.cpb.cpbTableDataCapex === null ? emptyArrayJSON :
    cpsData.cpb.cpbTableDataCapex;
  cpsData.cpb.cpbTableDataOpex = cpsData.cpb.cpbTableDataOpex === undefined ||
    cpsData.cpb.cpbTableDataOpex === "no data" ||
    cpsData.cpb.cpbTableDataOpex === null ? emptyArrayJSON :
    cpsData.cpb.cpbTableDataOpex;

  cpsData.wpb.wpbTableDataCapex = cpsData.wpb.wpbTableDataCapex === undefined ||
    cpsData.wpb.wpbTableDataCapex === "no data" ||
    cpsData.wpb.wpbTableDataCapex === null ? emptyArrayJSON :
    cpsData.wpb.wpbTableDataCapex;
  cpsData.wpb.wpbTableDataOpex = cpsData.wpb.wpbTableDataOpex === undefined ||
    cpsData.wpb.wpbTableDataOpex === "no data" ||
    cpsData.wpb.wpbTableDataOpex === null ? emptyArrayJSON :
    cpsData.wpb.wpbTableDataOpex;

  cpsData.afe.afeTableDataCapex = cpsData.afe.afeTableDataCapex === undefined ||
    cpsData.afe.afeTableDataCapex === "no data" ||
    cpsData.afe.afeTableDataCapex === null ? emptyArrayJSON :
    cpsData.afe.afeTableDataCapex;
  cpsData.afe.afeTableDataOpex = cpsData.afe.afeTableDataOpex === undefined ||
    cpsData.afe.afeTableDataOpex === "no data" ||
    cpsData.afe.afeTableDataOpex === null ? emptyArrayJSON :
    cpsData.afe.afeTableDataOpex;

  //Sort all report tables by rowSequence ascending
  cpsData.apc.apcTableDataCapex.sort(function (a, b) {
    return a.rowSequence - b.rowSequence;
  });
  cpsData.apc.apcTableDataOpex.sort(function (a, b) {
    return a.rowSequence - b.rowSequence;
  });
  cpsData.fdp.fdpTableDataCapex.sort(function (a, b) {
    return a.rowSequence - b.rowSequence;
  });
  cpsData.fdp.fdpTableDataOpex.sort(function (a, b) {
    return a.rowSequence - b.rowSequence;
  });
  cpsData.cpb.cpbTableDataCapex.sort(function (a, b) {
    return a.rowSequence - b.rowSequence;
  });
  cpsData.cpb.cpbTableDataOpex.sort(function (a, b) {
    return a.rowSequence - b.rowSequence;
  });
  cpsData.wpb.wpbTableDataCapex.sort(function (a, b) {
    return a.rowSequence - b.rowSequence;
  });
  cpsData.wpb.wpbTableDataOpex.sort(function (a, b) {
    return a.rowSequence - b.rowSequence;
  });
  cpsData.afe.afeTableDataCapex.sort(function (a, b) {
    return a.rowSequence - b.rowSequence;
  });
  cpsData.afe.afeTableDataOpex.sort(function (a, b) {
    return a.rowSequence - b.rowSequence;
  });

  //##### POPULATE APC TAB
  //Populate the APC Capex Table
  $("#apcCapexTable").empty().append(populateAPCCPBFDPTableString(APC_NAME, cpsData.apc.apcTableDataCapex));
  //Populate the APC Capex Table
  $("#apcOpexTable").empty().append(populateAPCCPBFDPTableString(APC_NAME, cpsData.apc.apcTableDataOpex));

  // //##### POPULATE FDP TAB
  //Populate the FDP Capex Table
  $("#fdpCapexTable").empty().append(populateAPCCPBFDPTableString(FDP_NAME, cpsData.fdp.fdpTableDataCapex));
  //Populate the FDP Capex Table
  $("#fdpOpexTable").empty().append(populateAPCCPBFDPTableString(FDP_NAME, cpsData.fdp.fdpTableDataOpex));

  // //##### POPULATE CPB TAB
  //Populate the CPB Capex Table
  $("#cpbCapexTable").empty().append(populateAPCCPBFDPTableString(CPB_NAME, cpsData.cpb.cpbTableDataCapex));
  //Populate the CPB Capex Table
  $("#cpbOpexTable").empty().append(populateAPCCPBFDPTableString(CPB_NAME, cpsData.cpb.cpbTableDataOpex));

  // //##### POPULATE WPB TAB
  //Populate the WPB Capex Table
  $("#wpbCapexTable").empty().append(populateWPBTableString(cpsData.wpb.wpbTableDataCapex));
  //Populate the WPB Capex Table
  $("#wpbOpexTable").empty().append(populateWPBTableString(cpsData.wpb.wpbTableDataOpex));

  // //##### POPULATE AFE TAB
  //Populate the AFE Capex Table
  $("#afeCapexTable").empty().append(populateAFETableString(cpsData.afe.afeTableDataCapex));
  //Populate the AFE Capex Table
  $("#afeOpexTable").empty().append(populateAFETableString(cpsData.afe.afeTableDataOpex));

  $('.tab-content').scroll(function () {
    $('.popover').remove();
  });

  $('table tbody tr:last-child td:first-child').each(function (index, row) {
    if ($(this).text() == '+' && $(this).next().text() == 'Total') {
      $(this).text('')
      $(this).next().removeClass('tapForPopover');
    }
  });

  if (activeTabName == 'cpb') {
    $('#cpsTabs a[href="#cpbTab"]').tab('show');
    activePosition = 2;
  } else if (activeTabName == 'apc') {
    $('#cpsTabs a[href="#apcTab"]').tab('show');
    activePosition = 0;
  } else if (activeTabName == 'fdp') {
    $('#cpsTabs a[href="#fdpTab"]').tab('show');
    activePosition = 1;
  } else if (activeTabName == 'wpb') {
    $('#cpsTabs a[href="#wpbTab"]').tab('show');
    activePosition = 3;
  } else if (activeTabName == 'afe') {
    $('#cpsTabs a[href="#afeTab"]').tab('show');
    activePosition = 4;
  }

  setProperIndicator(activePosition);
  window.swiper.slide(activePosition, 100);

  $('body').delegate('*', 'touchend', function (e) {

    var divInsidePopover = $('#innerPopoverContent div');
    if (!$(e.target).is('.popover-content') &&
      !$(e.target).is('.popover') &&
      !$(e.target).is('#innerPopoverContent') &&
      !$(e.target).is(divInsidePopover) &&
      !$(e.target).is('.tapForPopover')) {

      $('.popover').remove();
    }
  });

  setProperAlignment($("#apcCapexTable tr"));
  setProperAlignment($("#apcOpexTable tr"));

  setProperAlignment($("#fdpCapexTable tr"));
  setProperAlignment($("#fdpOpexTable tr"));

  setProperAlignment($("#cpbCapexTable tr"));
  setProperAlignment($("#cpbOpexTable tr"));

  setProperAlignment($("#wpbCapexTable tr"));
  setProperAlignment($("#wpbOpexTable tr"));

  setProperAlignment($("#afeCapexTable tr"));
  setProperAlignment($("#afeOpexTable tr"));

  setParentRowBackground($("#apcCapexTable tr.parentRow"));
  setParentRowBackground($("#apcOpexTable tr.parentRow"));

  setParentRowBackground($("#fdpCapexTable tr.parentRow"));
  setParentRowBackground($("#fdpOpexTable tr.parentRow"));

  setParentRowBackground($("#cpbCapexTable tr.parentRow"));
  setParentRowBackground($("#cpbOpexTable tr.parentRow"));

  setParentRowBackground($("#wpbCapexTable tr.parentRow"));
  setParentRowBackground($("#wpbOpexTable tr.parentRow"));

  setParentRowBackground($("#afeCapexTable tr.parentRow"));
  setParentRowBackground($("#afeOpexTable tr.parentRow"));

}

function setProperAlignment(tableTRs) {

  tableTRs.each(function (index, row) {
    $(this).find('td').each(function (tdIndex, rowCell) {
      if ($(this).text() == 'N/A' && tdIndex !== 1) {
        $(this).css('text-align', 'center');
      }
    });

  });
}

function setProperIndicator(position) {
  $('#pagination em').each(function (index, row) {
    var span = $(this).find('span');

    if (span.hasClass('filled')) {
      span.removeClass('filled');
      span.addClass('empty');
    }

    if (index == position) {
      span.removeClass();
      span.addClass('filled');
    }
  });
}

function setParentRowBackground(tableRows) {
  tableRows.each(function (index, row) {
    console.log('tr parent' + index)

    if (index % 2 == 0) {
      $(this).css('background-color', '#fff');
    } else {
      $(this).css('background-color', '#f0f0f0');
    }
  });
}
//######################################################################
// UTILITY AND HELPER FUNCTIONS

//Called from ObjectiveC to show the popover.
function displayPopover(popoverJson) {
  //var popoverJsonObj = JSON.parse(popoverJson);

  console.log(popoverJson);

  var self = tappedCell;
  var reportname = self.data('reportname');
  var key = self.data('key');

  //Create the popover and show
  self.popover({
    trigger : 'manual',
    placement : getPopoverPlacement,
    html : true,
    animation : false,
    container : 'body',
    content : function () {
      // return "This is the popover";
      return getHTMLforPopover(popoverJson);
    }
  }).popover('toggle');

  $('.popover').css('left', 70);

  if (popoverPlacement == 'topLeft') {
    var top = $('.popover').position() === undefined ? 0 : $('.popover').position().top;
    $('.popover').css('top', top + 30);
  }
  console.log();
}

//Populate the table string for APC, CPB, FDP
function populateAPCCPBFDPTableString(reportName, arrayToProcess) {
  //Prepare the string to populate the table with THead
  if (reportName == APC_NAME) {
    var tableString = apcThead;
  } else if (reportName == FDP_NAME) {
    var tableString = fdpThead;
  } else if (reportName == CPB_NAME) {
    var tableString = cpbThead;
  } else {
    return null;
  }

  if (arrayToProcess.length < 1) {
    var colspan = 1;
    if (reportName == APC_NAME) {
      var colspan = 10;
    } else if (reportName == FDP_NAME) {
      var colspan = 8;
    } else if (reportName == CPB_NAME) {
      var colspan = 10;
    }
    tableString += "<tbody style='display: table-row-group'><tr><td colspan='" + colspan + "' style='text-align:center'>No data available</td></tr></tbody>";

    return tableString;
  } //end no data

  for (var key in arrayToProcess) {
    var row = arrayToProcess[key];

    if (reportName == APC_NAME) {

      var valueColumns =
        "<td>" + numberWithCommas(validateNumberField(row.apcGate3)) + "</td>" +
        "<td>" + numberWithCommas(validateNumberField(row.apcFido)) + "</td>" +
        "<td>" + numberWithCommas(validateNumberField(row.apcAmt)) + "</td>" +
        "<td>" + numberWithCommas(validateNumberField(row.cumVowdAmt)) + "</td>" +
        "<td>" + numberWithCommas(validateNumberField(row.afcAmt)) + "</td>" +
        "<td>" + (numberWithCommas(validateNumberField(row.variance)) == 'N/A' ? 'N/A' : numberWithCommas(validateNumberField(row.variance)) + '%') + "</td>" +
        "<td><img src='" + returnIndicatorPath(validateField(row.gInd)) + "' alt='" + validateField(row.gInd) + "'/></td>" +
        "<td><img src='" + returnIndicatorPath(validateField(row.pInd)) + "' alt='" + validateField(row.pInd) + "'/></td>";
    } else if (reportName == FDP_NAME) {

      var valueColumns =
        "<td>" + numberWithCommas(validateNumberField(row.fdpAmt)) + "</td>" +
        "<td>" + numberWithCommas(validateNumberField(row.fiaAmt)) + "</td>" +
        "<td>" + numberWithCommas(validateNumberField(row.cumVowdAmt)) + "</td>" +
        "<td>" + numberWithCommas(validateNumberField(row.afcAmt)) + "</td>" +
        "<td>" + (numberWithCommas(validateNumberField(row.variance)) == 'N/A' ? 'N/A' : numberWithCommas(validateNumberField(row.variance)) + '%') + "</td>" +
        "<td><img src='" + returnIndicatorPath(validateField(row.gInd)) + "' alt='" + validateField(row.gInd) + "'/></td>";
    } else if (reportName == CPB_NAME) {

      var valueColumns =
        "<td>" + numberWithCommas(validateNumberField(row.cpbAmt)) + "</td>" +
        "<td>" + numberWithCommas(validateNumberField(row.latestCpbAmt)) + "</td>" +

        "<td>" + numberWithCommas(validateNumberField(row.ytdPlan)) + "</td>" +
        "<td>" + numberWithCommas(validateNumberField(row.ytdActual)) + "</td>" +
        "<td>" + numberWithCommas(validateNumberField(row.yep)) + "</td>" +
        "<td>" + (numberWithCommas(validateNumberField(row.variance)) == 'N/A' ? 'N/A' : numberWithCommas(validateNumberField(row.variance)) + '%') + "</td>" +
        "<td><img src='" + returnIndicatorPath(validateField(row.gInd)) + "' alt='" + validateField(row.gInd) + "'/></td>" +
        "<td><img src='" + returnIndicatorPath(validateField(row.pInd)) + "' alt='" + validateField(row.pInd) + "'/></td>";
    }

    if (row.rowName == "activity") {
      //Create new tbody and close previous tbody if required
      // tableString += (row.rowSequence==1 ? "<tbody class='collapsed'>" : "</tbody><tbody class='collapsed'>");
      //tableString += (row.rowSequence==1 ? "<tr class='collapsed parentRow'>" : "</tr><tr class='collapsed parentRow'>");
      //TODO Add the row.key and the link for justification.
      //TODO If FDP no need to activate the activity link.
      // tableString += "<tr><td><a class='expandRows'>+</a></td>";
      tableString += "<tr class='parentRow'><td class='expandRows'><a>+</a></td>";
      // If report is APC or CPB then add the class for Tap for Justification Popover.
      if (reportName == APC_NAME) {
        tableString += "<td class='tapForPopover' data-key=" + validateField(row.key) + " data-reportname=" + APC_NAME + ">" + validateField(row.name) + "</td>";
      } else if (reportName == CPB_NAME) {
        tableString += "<td class='tapForPopover' data-key=" + validateField(row.key) + " data-reportname=" + CPB_NAME + ">" + validateField(row.name) + "</td>";
      } else {
        tableString += "<td data-key=" + validateField(row.key) + " data-reportname=" + FDP_NAME + ">" + validateField(row.name) + "</td>";
      }

      tableString += valueColumns + "</tr>";

    } else if (row.rowName == "facility") {
      //TODO DO proper indents to indicate diffent level as per mockups
      tableString += "<tr style='display: none;' class='childRow'><td></td>" +
      "<td class='facility'>" + validateField(row.name) + "</td>" +
      valueColumns + "</tr>";

    } else if (row.rowName == "structure") {
      //TODO DO proper indents to indicate diffent level as per mockups
      tableString += "<tr style='display: none;' class='childRow'><td></td>" +
      "<td class='structure'>" + validateField(row.name) + "</td>" +
      valueColumns + "</tr>";

    } else if (row.rowName == "costitem") {
      //TODO DO proper indents to indicate diffent level as per mockups
      tableString += "<tr style='display: none;' class='childRow'><td></td>" +
      "<td class='costItem'>" + validateField(row.name) + "</td>" +
      valueColumns + "</tr>";

    } else if (row.rowName == "total") {
      //Last row. Close the tbody and create new one.
      // tableString += "</tbody>";
      // tableString += "<tbody>";
      // tableString += "<tr><td></td><td>"+validateField(row.name)+"</td>"+valueColumns+"</tr>";
      // tableString += "</tbody>";

      tableString += "</tr>";
      tableString += "<tr>";
      tableString += "<tr class=\"parentRow\"><td></td><td>" + validateField(row.name) + "</td>" + valueColumns + "</tr>";
      tableString += "</tr>";
    }
  }
  return tableString;
}

//Populate the table string for WPB
function populateWPBTableString(arrayToProcess) {
  //Prepare the string to populate the table with THead
  var tableString = wpbThead;
  if (arrayToProcess.length < 1) {

    // tableString += "<tbody><tr><td colspan='10'>No data available</td></tr></tbody>";
    tableString += "<tbody  style='display: table-row-group'><tr><td colspan='10'  style='text-align:center'>No data available</td></tr></tbody>";

    return tableString;
  } //end no data
  for (var key in arrayToProcess) {
    var row = arrayToProcess[key];

    // "key":1, "name":"Budget Item ABC", "originalWPB":1, "approvedCO":13.544, "approvedABR":13.544, "latestWPB":13.544, "currentMonthYTDActual":2.44, "currentMonthYEP":1, "variance":13.544, "gInd":"green"},'+
    var valueColumns =
      "<td>" + numberWithCommas(validateNumberField(row.originalWPB)) + "</td>" +
      "<td>" + numberWithCommas(validateNumberField(row.approvedCO)) + "</td>" +
      "<td>" + numberWithCommas(validateNumberField(row.approvedABR)) + "</td>" +
      "<td>" + numberWithCommas(validateNumberField(row.latestWPB)) + "</td>" +
      "<td>" + numberWithCommas(validateNumberField(row.currentMonthYTDActual)) + "</td>" +
      "<td>" + numberWithCommas(validateNumberField(row.currentMonthYEP)) + "</td>" +
      "<td>" + (numberWithCommas(validateNumberField(row.variance)) == 'N/A' ? 'N/A' : numberWithCommas(validateNumberField(row.variance)) + '%') + "</td>" +
      "<td><img src='" + returnIndicatorPath(validateField(row.gInd)) + "' alt='" + validateField(row.gInd) + "'/></td>";

    if (row.rowName == "budget") {
      //Create new tbody and close previous tbody if required
      // tableString += (row.rowSequence==1 ? "<tbody class='collapsed'>" : "</tbody><tbody class='collapsed'>");
      //tableString += (row.rowSequence==1 ? "<tr class='collapsed'>" : "</tr><tr class='collapsed'>");
      //TODO Add the row.key and the link for justification.
      // tableString += "<tr><td><a class='expandRows'>+</a></td>"+
      tableString += "<tr class='parentRow'><td class='expandRows'><a>+</a></td>" +
      "<td class='tapForPopover'  data-key=" + row.key + " data-reportname=" + WPB_NAME + ">" + validateField(row.name) + "</td>" +
      valueColumns + "</tr>";

    } else if (row.rowName == "structure") {
      //TODO DO proper indents to indicate diffent level as per mockups
      tableString += "<tr style='display: none;'><td></td>" +
      "<td class='structure'>" + validateField(row.name) + "</td>" +
      valueColumns + "</tr>";

    } else if (row.rowName == "activity") {
      //TODO DO proper indents to indicate diffent level as per mockups
      tableString += "<tr style='display: none;'><td></td>" +
      "<td class='activity'>" + validateField(row.name) + "</td>" +
      valueColumns + "</tr>";

    } else if (row.rowName == "total") {
      //Last row. Close the tbody and create new one.
      // tableString += "</tbody>";
      // tableString += "<tbody>";
      // tableString += "<tr><td></td> <td>"+validateField(row.name)+"</td>"+valueColumns+"</tr>";
      // tableString += "</tbody>";

      tableString += "</tr>";
      tableString += "<tr>";
      tableString += "<tr class=\"parentRow\"><td></td> <td>" + validateField(row.name) + "</td>" + valueColumns + "</tr>";
      tableString += "</tr>";

    }
  }
  return tableString;
}

//Populate the table string for AFE
function populateAFETableString(arrayToProcess) {
  //Prepare the string to populate the table with THead
  var tableString = afeThead;
  if (arrayToProcess.length < 1) {

    // tableString += "<tbody><tr><td colspan='8' style='text-align:center'>No data available</td></tr></tbody>";
    tableString += "<tbody  style='display: table-row-group'><tr><td colspan='8' style='text-align:center'>No data available</td></tr></tbody>";

    return tableString;
  } //end no data
  for (var key in arrayToProcess) {
    var row = arrayToProcess[key];
    //"key":1, "name":"AFE 1", "originalAfeAmt":1, "latestAfeAmt":13.544, "cumVowdAmt":13.544, "afcAmt":13.544, "latestAfeVar":2.44, "gInd":"green"},'+
    var valueColumns =
      "<td>" + numberWithCommas(validateNumberField(row.originalAfeAmt)) + "</td>" +
      "<td>" + numberWithCommas(validateNumberField(row.latestAfeAmt)) + "</td>" +
      "<td>" + numberWithCommas(validateNumberField(row.afcAmt)) + "</td>" +
      "<td>" + (numberWithCommas(validateNumberField(row.latestAfeVar)) === 'N/A' ? 'N/A' : numberWithCommas(validateNumberField(row.latestAfeVar)) + '%') + "</td>" +
      "<td><img src='" + returnIndicatorPath(validateField(row.gInd)) + "' alt='" + validateField(row.gInd) + "'/></td>" +
      "<td>" + numberWithCommas(validateNumberField(row.cumVowdAmt)) + "</td>";

    if (row.rowName == "afe") {
      //Create new tbody and close previous tbody if required
      // tableString += (row.rowSequence==1 ? "<tbody class='collapsed'>" : "</tbody><tbody class='collapsed'>");
      //tableString += (row.rowSequence==1 ? "<tr class='collapsed'>" : "</tr><tr class='collapsed'>");
      //TODO Add the row.key and the link for justification.
      // tableString += "<tr><td><a class='expandRows'>+</a></td>"+
      // tableString += "<tr><td class='expandRows'><a>+</a></td>"+
      tableString += "<tr class='parentRow'><td class='expandRows'><a>+</a></td>" +
      "<td data-key=" + row.key + " data-reportname=" + AFE_NAME + ">" + validateField(row.name) + "</td>" +
      valueColumns + "</tr>";

    } else if (row.rowName == "wbs") {
      //TODO DO proper indents to indicate diffent level as per mockups
      tableString += "<tr style='display: none;'><td></td>" +
      "<td class='wbs'>" + validateField(row.name) + "</td>" +
      valueColumns + "</tr>";

    } else if (row.rowName == "total") {
      //Last row. Close the tbody and create new one.
      // tableString += "</tbody>";
      // tableString += "<tbody>";
      // tableString += "<tr><td></td> <td>"+row.name+"</td>"+valueColumns+"</tr>";
      // tableString += "</tbody>";

      tableString += "</tr>";
      tableString += "<tr>";
      tableString += "<tr class=\"parentRow\"><td></td> <td>" + validateField(row.name) + "</td>" + valueColumns + "</tr>";
      tableString += "</tr>";
    }
  }
  return tableString;
}

//Prepare the HTML string for Justification popover
function getHTMLforPopover(popoverJson) {
  var popoverHTML = "<div id='innerPopoverContent'>";

  if (popoverJson.length == 0) {
    return "<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;No Data Available&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>"
  }

  //TODO Proper formatting for popover contents
  for (var key in popoverJson) {
    popoverHTML += "<div class='justification'>";
    var row = popoverJson[key];
    popoverHTML += "<div>" + validateField(row.name) + "</div>";
    popoverHTML += "<div><p>Variance</p><p> : </p><p>" + numberWithCommas(validateNumberField(row.varianceAmt)) + "</p></div>";
    popoverHTML += "<div><p>Reason</p><p> : </p><p>" + validateField(row.varianceReasonName) + "</p></div>";
    popoverHTML += "<div><p>Justification Description:</p>" + validateField(row.justificationDesc) + "</div>";
    popoverHTML += "</div>";
  }
  return popoverHTML + "</div>";
}

//Based on the locatioin of indicator on page, provide the optimal placement for popover
function getPopoverPlacement(pop, dom_el) {
  var position = $(dom_el).position();

  var top = position.top,
  left = position.left;

  var documentHeight = $(document).height() / 2;

  //If the tapped cell is above the middle of the page, then position is BottomLeft, else topLeft
  var toreturn = (top < documentHeight) ? "bottomLeft"
   : (top >= documentHeight) ? "topLeft"
   : "bottomLeft";

  console.log('top ' + position.top + ' left ' + position.left + ' chosen side ' + toreturn);
  popoverPlacement = toreturn;
  return toreturn;
}

//Collapse or expand the Collapsible rows in the tables
function toggleCollapseRow(tbodyEl) {
  var myTRs = tbodyEl.children("tr");
  if (tbodyEl.hasClass("collapsed")) {
    tbodyEl.removeClass("collapsed");
    // myTRs.first().children("td").first().text("+");
    //myTRs.show();

    tbodyEl.nextUntil('.parentRow').hide();
  } else {
    tbodyEl.addClass("collapsed");
    myTRs.hide();
    // console.log(myTRs.first().children("td").first());
    myTRs.first().children("td").first().innerText = "-";
    myTRs.first().slideDown();
    tbodyEl.nextUntil('.parentRow').show();
  }
}

function sendNotificationToIOS(module, type, value) {

  console.log('popover notification');
  console.log(module + " " + type + " " + value)
  //call to objective c with project name parameter and type of chart to link to pap screen
  var iframe = document.createElement("IFRAME");
  iframe.setAttribute("src", "ETG?module=\"" + module + "\"&type=\"" + type + "\"&value=\"" + value + "\"");
  iframe.setAttribute("height", "1px");
  iframe.setAttribute("width", "1px");
  document.documentElement.appendChild(iframe);
  iframe.parentNode.removeChild(iframe);
  iframe = null;
}

jQuery(function ($) {

});