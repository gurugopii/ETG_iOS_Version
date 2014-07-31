var returnIndicatorPath = function (indicator) {

  if (indicator === null || (indicator === undefined)) {
    return "images/transparent.png";
  } else if (indicator.toLowerCase() == "green") {
    return "images/green.png";
  } else if (indicator.toLowerCase() == "red") {
    return "images/red.png";
  } else if (indicator.toLowerCase() == "grey") {
    return "images/grey.png";
  } else if (indicator.toLowerCase() == "yellow") {
    return "images/yellow.png";
  }
  return "images/transparent.png";
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
  var match = validateField(xmlDate).match(re);
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

function noDataAvailable(containerArray, module, type, level) {
  var chartTitle = '';

  if (module == 'portfolio') {
    switch (type) {
    case 'hydro':
      chartTitle = 'First Hydrocarbon';
      if (level == 2) {
        $('#hydro-title').remove();
        $('#hydro_legend_container').remove();
        $(containerArray[0]).css({
          'margin-top' : '10px'
        });
      }
      break;
    case 'rtbd':
      chartTitle = 'Production and RTBD Performance';
      break;
    case 'cpb':
      chartTitle = 'CPB Performance';
      break;
    case 'apc':
      chartTitle = 'APC Performance';
      break;
    case 'hse':
      chartTitle = 'HSE Performance';
      break;
    case 'wpb':
      chartTitle = 'WPB Performance';
      break;
    }
    $(containerArray[0]).empty().append('<p>' + chartTitle + ' Chart</p><p>No data available</p>').addClass('nodata');
    $(containerArray[1]).empty().append('<p>' + chartTitle + ' Table</p><p>No data available</p>').addClass('nodata');
  } else {
    switch (type) {
    case 'keyMilestone':
      chartTitle = 'Key Milestone';
      $(containerArray[0]).css({
        'background' : 'transparent'
      });
      break;
    case 'schedule':
      chartTitle = 'Schedule';
      break;
    case 'budget':
      chartTitle = 'Budget Performance';
      break;
    case 'afe':
      chartTitle = 'AFE Governance';
      $(containerArray[0]).css({
        'background' : 'transparent'
      });
      break;
    case 'rtbd':
      chartTitle = 'New Production and RTBD';
      break;
    case 'risk':
      chartTitle = 'Risk and Opportunity';
      $('#opportunity-chart-subtitle').empty();
      $('#opportunity-table-subtitle').empty();
      $(containerArray[0]).css({
        'background' : 'transparent'
      });
      break;
    case 'hse':
      chartTitle = 'HSE';
      break;
    case 'ppms':
      chartTitle = 'PPMS Review';
      $(containerArray[0]).css({
        'background' : 'transparent'
      });
      break;
    }

    $(containerArray[0]).empty().append('<p>' + chartTitle + ' Chart</p><p>No data available</p>').addClass('nodata');
    $(containerArray[1]).empty().append('<p>' + chartTitle + ' Table</p><p>No data available</p>').addClass('nodata');
  }

}

var noDataDisplay = function (id) {
  $(id + ' tbody').addClass('no-data-display');
  $(id + ' tbody td').css({'text-align': 'center'});
  $(id + ' thead').css('display', 'table-header-group');
};

var setHighlightOnTouch = function (id) {
  $(id).delegate('tr', 'touchend', function (e) {
    var state = $(this).hasClass('highlighted');
    $('.highlighted').removeClass('highlighted');
    if (!state) {
      $(this).addClass('highlighted');
    }
  });
};

function numberWithCommas(x) {
  if ((typeof x === 'undefined') || x === '(null)%' || x === null || x === undefined) {
    return 'N/A';
  }
  var newNumber = 0;
  x = x.toString();
  var stringNum = x.replace(/,/g,'');
  
  if(stringNum.indexOf('(') !=-1 && stringNum.indexOf(')') !=-1 && stringNum.indexOf('null') === -1){
    stringNum = stringNum.replace(/\(/g,'');
    stringNum = stringNum.replace(/\)/g,'');
	newNumber = parseFloat(stringNum).toFixed(2) *-1.00;
  } else {
    newNumber = parseFloat(stringNum).toFixed(2);
  }
  
  //check if the it's not a number
  if(isNaN(newNumber)){
    return 'N/A';
  }
  
  //Seperates the components of the number
  var n = newNumber.toString().split(".");
  //adding commas to the first part
  n[0] = n[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");

  //Combines the two sections
  return n.join(".");

}

function numberWithCommasWithoutDecimal(x) {
  if ((typeof x === 'undefined') || x === '(null)%' || x === null || x === undefined) {
    return 'N/A';
  }
  var newNumber = 0;
  x = x.toString();
  var stringNum = x.replace(/,/g,'');
  
  if(stringNum.indexOf('(') !=-1 && stringNum.indexOf(')') !=-1 && stringNum.indexOf('null') === -1){
    stringNum = stringNum.replace(/\(/g,'');
    stringNum = stringNum.replace(/\)/g,'');
	newNumber = parseFloat(stringNum).toFixed(2) *-1.00;
  } else {
    newNumber = parseFloat(stringNum).toFixed(2);
  }
  
  //check if the it's not a number
  if(isNaN(newNumber)){
    return 'N/A';
  }
  
  //Seperates the components of the number
  var n = newNumber.toString().split(".");
  //adding commas to the first part
  n[0] = n[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");

  //Combines the two sections
  return n[0];

}


function validateField(field){
  return field === undefined ||
	field === null ||
	field === 'null' ? 'N/A'
	: field;
}

function validateNumberField(field){
    return field === undefined ||
	field === null ||
	field === 'null' ? null
	: field;
}

function removeTableDuplicates(table){
  var seen = {};
  table.each(function () {
    var txt = $(this).text();
    if (seen[txt])
      $(this).remove();
    else
      seen[txt] = true;
  });
}

//function to set N/A text align to center 
function setProperAlignment(tableTRs) {

  tableTRs.each(function (index, row) {
    $(this).find('td').each(function (tdIndex, rowCell) {
      if ($(this).text() == 'N/A') {
        $(this).css('text-align', 'center');
      }
    });
	
	$(this).find('th').each(function (tdIndex, rowCell) {
      if ($(this).text() == 'N/A') {
        $(this).css('text-align', 'center');
      }
    });

  });
}