jQuery(function ($) {
  //for swiping feature
  var elem = document.getElementById('swiper');

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
      }
    });
});

// populateAllChartsAtLevel1(sampleData);
// populateAllChartsAtLevel1(sampleData2);
// populateAllChartsAtLevel1(newJSON);
// populateAllChartsAtLevel1(json1215);

function populateAllChartsAtLevel1(contentJSONStr) {
  var contentJSONObj = JSON.parse(contentJSONStr);

  populateTitleForPortfolio(contentJSONObj.projectDetails === undefined ? 'no data' : contentJSONObj.projectDetails);
   var isProjectEnabled = validateField(contentJSONObj.projectDetails === undefined ? '{"isProjectEnabled":"no"}' : validateField(contentJSONObj.projectDetails.isProjectEnabled));
  var module = 'portfolio',
  firstPage = $('#first-page'),
  secondPage = $('#second-page'),
  /*
  counter for charts that could be included in a page, max of 4
  if page count reaches 4, the next chart to be displayed will be appended to the next page
   */
  firstPageCount = 0,
  secondPageCount = 0,
  id = 0,
  classToAdd = '';

  firstPage.empty();
  secondPage.empty();
    
  var hydroData = contentJSONObj.hydro === undefined ? 'no data' : contentJSONObj.hydro,
  isHydroDisabled,
  contentHydro = '<div id="hydroMainContainer" class="div table-dimension">' +
    '<div id="hydro-title" class="title div"></div>' +
    '<div id="tableHydroContainer" class="div"></div>' +
    '</div>',
  contentHydroLegend = '<div id="legend" class="div">' +
    '<div id="hydro_legend">' +
    '<span><img class="indicator" src="images/bluediamond.png" alt="blue"/></span><span>&nbsp;Plan</span>' +
    '<span><img class="indicator" src="images/greentriangle.png" alt="red"/></span><span>Actual/Forecast earlier than Plan&nbsp;&nbsp;</span>' +
    '<span><img class="indicator" src="images/redtriangle.png" alt="green"/></span><span>Actual/Forecast later than Plan</span>' +
    '</div>' +
    '</div>';

  if (hydroData == 'disabled') {
    isHydroDisabled = true;
  } else if (hydroData == 'no data') {
    firstPage.append(contentHydro);
    firstPageCount += 2;

    var hydroNoData = JSON.parse('{"hydro":' +
        '[' +
        ']}');
    populateHydroTable(hydroNoData.hydro, 1, id);
    var hydroMainContainer = $('#hydroMainContainer');
    hydroMainContainer.append(contentHydroLegend);
    id++;

  } else {
    firstPage.append(contentHydro);
    firstPageCount += 2;
    populateHydroTable(hydroData, 1, id);
    var hydroMainContainerWithData = $('#hydroMainContainer');
    hydroMainContainerWithData.append(contentHydroLegend);
    id++;
  }

  if (isHydroDisabled) {
    classToAdd = 'first-chart';
  } else {
    classToAdd = 'withHydroTable';
  }

  var rtbdData = contentJSONObj.rtbd === undefined ? 'no data' : contentJSONObj.rtbd,
  contentRTBD = '<div id="RTBDChart" class="div chart-dimension ' + classToAdd + '"></div>',
  cpbData = contentJSONObj.cpb === undefined ? 'no data' : contentJSONObj.cpb,
  contentCPB = '<div id="cpbChart" class="div chart-dimension ' + classToAdd + '"></div>';

  if (rtbdData == 'disabled') {}
  else if (rtbdData == 'no data') {
    firstPage.append(contentRTBD);

    firstPageCount++;

    var rtbdNoData = JSON.parse('{' +
        '"chartdata":{' +
        '"newproduction":[' +
        '{"name":"YEP", "data":[0, 0, 0, 0]},' +
        '{"name":"CPB", "data":[0, 0, 0, 0]}' +
        '],' +
        '"rtbd":[' +
        '{"name":"YEP", "data":[0, 0, 0]},' +
        '{"name":"CPB", "data":[0, 0, 0]}' +
        ']' +
        '},' +
        '"tabledata":[' +
        ']' +
        '}');
    populateRTBDChart(rtbdNoData, 1, id);
    id++;
  } else {
    firstPage.append(contentRTBD);
    populateRTBDChart(rtbdData, 1, id);
    id++;
    firstPageCount++;
  }

  if (cpbData == 'disabled') {}
  else if (cpbData === 'no data') {
    firstPage.append(contentCPB);

    firstPageCount++;

    var cpbNoData = JSON.parse('{' +
        '"tabledata":' +
        '[' +
        '],' +
        '"chartdata":' +
        '[{"name":"FY YTD Actual Equity","data":[]},{"name":"Approved CPB Equity","data":[]},{"name":"FY YEP Equity",	"data":[]}]' +
        '}');
    populateCPBChart(cpbNoData, 1, id);
    id++;
  } else {
    firstPage.append(contentCPB);
    populateCPBChart(cpbData, 1, id);
    id++;
    firstPageCount++;
  }

  var apcData = contentJSONObj.apc === undefined ? 'no data' : contentJSONObj.apc;
  var apcClass = '';
  if (apcData == 'disabled') {}
  else if (apcData === 'no data') {
    if (firstPageCount < 4) {
      if (!isHydroDisabled) {
        apcClass = 'withHydroTable';
      } else {
        apcClass = 'first-chart';
      }
      firstPage.append('<div id="apcChart" class="div chart-dimension ' + apcClass + '"></div>');
      firstPageCount++;
    } else {
      secondPage.append('<div id="apcChart" class="div chart-dimension first-chart"></div>');
      secondPageCount++;
    }

    var apcNoData = JSON.parse('{' +
        '"tabledata":' +
        '[' +
        '],' +
        '"chartdata":[{"data":[0, 0, 0, 0, 0]}]' +
        '}');
    populateAPCChart(apcNoData, 1, id);
    id++;
  } else {
    if (firstPageCount < 4) {
      if (!isHydroDisabled) {
        apcClass = 'withHydroTable';
      } else {
        apcClass = 'first-chart';
      }
      firstPage.append('<div id="apcChart" class="div chart-dimension ' + apcClass + '"></div>');
      firstPageCount++;
    } else {
      secondPage.append('<div id="apcChart" class="div chart-dimension first-chart"></div>');
      secondPageCount++;
    }
    populateAPCChart(apcData, 1, id);
    id++;
  }

  var hseData = contentJSONObj.hse === undefined ? 'no data' : contentJSONObj.hse;
  var hseClass = '';
  if (hseData == 'disabled') {}
  else if (hseData === 'no data') {
    if (firstPageCount < 4) {
      if (!isHydroDisabled) {
        hseClass = 'withHydroTable';
      } else {
        hseClass = 'first-chart';
      }
      firstPage.append('<div id="hseChart" class="div chart-dimension ' + hseClass + '"></div>');
      firstPageCount++;
    } else {
      secondPage.append('<div id="hseChart" class="div chart-dimension first-chart"></div>');
      secondPageCount++;
    }

    var hseNoData = JSON.parse('{' +
        '"tabledata":' +
        '[' +
        '],' +
        '"chartdata":[{"name":"LTI","data":[null, null, null, null]}]' +
        '}');
    populateHSEChart(hseNoData, 1, id);
    id++;
  } else {
    if (firstPageCount < 4) {
      if (!isHydroDisabled) {
        hseClass = 'withHydroTable';
      } else {
        hseClass = 'first-chart';
      }
      firstPage.append('<div id="hseChart" class="div chart-dimension ' + hseClass + '"></div>');
      firstPageCount++;
    } else {
      secondPage.append('<div id="hseChart" class="div chart-dimension first-chart"></div>');
      secondPageCount++;
    }
    populateHSEChart(hseData, 1, id);
    id++;
  }

  var wpbData = contentJSONObj.wpb === undefined ? 'no data' : contentJSONObj.wpb;
  var wpbClass = '';
  if (wpbData == 'disabled') {}
  else if (wpbData === 'no data') {
    if (firstPageCount < 4) {
      if (!isHydroDisabled) {
        wpbClass = 'withHydroTable';
      } else {
        wpbClass = 'first-chart';
      }
      firstPage.append('<div id="wpbChart" class="div chart-dimension ' + wpbClass + '"></div>');
      firstPageCount++;
    } else {
      secondPage.append('<div id="wpbChart" class="div chart-dimension first-chart"></div>');
      secondPageCount++;
    }

    var wpbNoData = JSON.parse('{' +
        '"tabledata":' +
        '[' +
        '],' +
        '"chartdata":' +
        '[{"name":"ABRApproved","data":[null, null, null,null,null,null, null, null,null,null,null,null]},{"name":"ABRSubmitted","data":[null, null, null,null,null,null, null, null,null,null,null,null]}]' +
        '}');
    populateWPBChart(wpbNoData, 1, id);
    id++;
  } else {
    if (firstPageCount < 4) {
      if (!isHydroDisabled) {
        wpbClass = 'withHydroTable';
      } else {
        wpbClass = 'first-chart';
      }
      firstPage.append('<div id="wpbChart" class="div chart-dimension ' + wpbClass + '"></div>');
      firstPageCount++;
    } else {
      secondPage.append('<div id="wpbChart" class="div chart-dimension first-chart"></div>');
      secondPageCount++;
    }
    populateWPBChart(wpbData, 1, id);
    id++;
  }

  //MPS Section
  //TODO:: Check to make sure the key name is correct.
  var mpsData = contentJSONObj.mps === undefined ? 'no data' : contentJSONObj.mps;
  var mpsClass = '';
  if( mpsData == 'disabled'){}
  else if( mpsData === 'no data'){
    if (firstPageCount < 4) {
      if (!isHydroDisabled) {
        mpsClass = 'withHydroTable';
      } else {
        mpsClass = 'first-chart';
      }
      firstPage.append('<div id="mpsChart" class="div chart-dimension ' + mpsClass + '"></div>');
      firstPageCount++;
    } else {
      secondPage.append('<div id="mpsChart" class="div chart-dimension first-chart"></div>');
      secondPageCount++;
    }

    //TODO:: Set the empty data properly
    var mpsNoData = {
      tabledata : [],
      chartdata : {
        categories : [],
        series: [
                { name : "Filled", data : null },
                { name : "Vacant", data : null }
      ]
    } };
    populateMPSChart(mpsNoData, 1, id);
    id++;
  }else{
    if (firstPageCount < 4) {
      if (!isHydroDisabled) {
        mpsClass = 'withHydroTable';
      } else {
        mpsClass = 'first-chart';
      }
      firstPage.append('<div id="mpsChart" class="div chart-dimension ' + mpsClass + '"></div>');
      firstPageCount++;
    } else {
      secondPage.append('<div id="mpsChart" class="div chart-dimension first-chart"></div>');
      secondPageCount++;
    }
    populateMPSChart(mpsData, 1, id);
    id++;
  }

  if (secondPageCount === 0) {
    secondPage.remove();
  }

  //adding the nav icons
  $('#pagination').empty();
  if (secondPageCount > 0) {
    $('#pagination').append('<em><span class="filled">&#8226;</span></em> <em><span class="empty">&#8226;</span></em>');
  } else {
    $('#pagination').append('<em><span class="filled">&#8226;</span></em>');
  }

  if(validateField(isProjectEnabled).toLowerCase() == 'no' || validateField(isProjectEnabled).toLowerCase() == 'n/a'){
    $('.project').css({'text-decoration': 'none', 'color': '#000'});
  } else {
    setEventListenerToProjectName(1);
  }
}
