jQuery(function ($) {

  var notInfoButton = $('body').not('.info-button');
  notInfoButton.on('touchend', function () {
    $('.popover').remove();
  });
});

var clickedIndicator, level;

// populateAllCharts(data);
// populateAllCharts(noData);

function populateAllCharts(jsonData) {
    currentLevel = 1;
  var level = 1,
  first_page = $('#first-page'),
  pageCount = 0,
  id = 0,
  timeStampJson = jsonData.topInformation === undefined ? 'no data' : jsonData.topInformation,
  gateHTMLContent = '<div id="gate-chart-container" class="div"></div>',
  gateJson = jsonData.gate === undefined ? 'disabled' : jsonData.gate,
  matrixHTMLContent = '<div id="matrix-chart-container" class="div"></div>',
  matrixJson = jsonData.matrix === undefined ? 'disabled' : jsonData.matrix;

  populateTimestamp(timeStampJson);

  if (gateJson == 'disabled') {}
  else if (gateJson == 'no data') {
    first_page.append(gateHTMLContent);
    pageCount++;
    popupateGateChart(gateNoData.gate, level, id);
    // alert(id);
    id++;
  } else {
    first_page.append(gateHTMLContent);
    pageCount++;
    popupateGateChart(gateJson, level, id);
    // alert(id);
    id++;
  }

  if (matrixJson == 'disabled') {}
  else if (matrixJson == 'no data') {
    first_page.append(matrixHTMLContent);
    pageCount++;
    popupateMatrixChart(matrixNoData.matrix, level, id);
    id++;

  } else {
    first_page.append(matrixHTMLContent);
    pageCount++;
    popupateMatrixChart(matrixJson, level, id);
    id++;
  }
  // popupateMatrixChart(jsonData.matrix, level);
    
    
//    $('body').delegate('*','touchend', function(e){
//                       if(isPopoverDisplayed && !$(e.target).is('.info-button')){
//                       $('.popover').remove()
//                       isPopoverDisplayed =  false;
//                       }
//                       });
    
    $('.info-button').on('click', function(){
                         $('.popover').remove();
                         clickedIndicator = $(this);
                         
                         if(clickedIndicator.data('chart') == 'PEM'){
                         description = level1PopoverForPEM;
                         } else {
                         description = level1PopoverForPGD;
                         }
                         displayPopover(description, 'bottomRightDescription');
                         isPopoverDisplayed = true;
                         });

}



