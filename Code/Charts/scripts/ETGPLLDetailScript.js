$('body').css('display', 'none')
//the next line of code is for testing purposes only
// populatePLLDetail(pllDetailData);
//Populate method for the whole Welcome Screen
function populatePLLDetail(pllDetailData) {
  $('body').css('display', 'block')
    
  if (!jQuery.isEmptyObject(pllDetailData)) {

      if(validateField(pllDetailData.replicateInd).toLowerCase() == 'y'){
          $('h4').empty().append('To-Be Replicated');
      } else if(validateField(pllDetailData.replicateInd).toLowerCase() == 'n'){
          $('h4').empty().append('To-Be Avoided');
      }
    //Populate Project lesson count
    var bookmarkLesson = $('#bookmarkLesson');
    //Update the bookmark button
    bookmarkLesson.attr('data-bookmarkind', validateField(pllDetailData.bookmarkInd));
    bookmarkLesson.attr('data-key', validateField(pllDetailData.projectLessonDetailKey));

    $('#searchDetail').empty().append('<p>Search Detail</p>' +
      '<p><span>Project Name: </span><span>' + validateField(pllDetailData.projectName) + '</span></p>' +
      '<p><span>PLL Review: </span><span>' + validateField(pllDetailData.reviewItemName) + '</span></p>' +
      '<p><span>Created By: </span><span>' + validateField(pllDetailData.createUserId) + ' ' + setTimestamp(validateField(pllDetailData.createDttm)) + '</span></p>' +
      '<p><span>Last Modified: </span><span>' + validateField(pllDetailData.updateUserId) + ' ' + setTimestamp(validateField(pllDetailData.updateDttm)) + '</span></p>' +
      '<p><span>Status: </span><span>' + validateField(pllDetailData.approvalStatus) + '</span></p>');

    $('#pllCategories').empty().append('<p>PLL Categories</p>' +
      '<p><span>PPMS Activity: </span><span>' + validateField(pllDetailData.activity) + '</span></p>' +
      '<p><span>PRA Elements: </span><span>' + validateField(pllDetailData.riskCategoryName) + '</span></p>' +
      '<p><span>Area: </span><span>' + validateField(pllDetailData.areaName) + '</span></p>' +
      '<p><span>Discipline: </span><span>' + validateField(pllDetailData.disciplineName) + '</span></p>');

    $('#pllDescription').empty().append('<p>PLL Detail Description</p>' +
      '<p><span>Impact Levels: </span><span>' + validateField(pllDetailData.projectLessonImpactNm) + '</span></p>' +
      '<p><span>Rating: </span><span>' + validateField(pllDetailData.projectLessonRatingNm) + '</span></p>' +
      '<p><span>Currency & Rate: </span><span>' + validateField(pllDetailData.currencyName) + ' ' + (validateNumberField(pllDetailData.usdRate)) + '</span></p>' +
      '<p><span>Potential Value: </span><span>' + numberWithCommas(validateField(pllDetailData.potentialValue)) + ' (' + validateField(pllDetailData.currencyName) + ' ' + numberWithCommas(validateField(pllDetailData.potentialValueConverted)) + ')</span></p>');


      $('#pllLessons').empty().append('<div>' +
                                      '	<p>What was supposed to happen?</p>' +
                                      '	<p>' + validateField(pllDetailData.baselineDesc) + '</p>' +
                                      '</div>' +
                                      '<div>' +
                                      '	<p>What actually happened?</p>' +
                                      '	<p>' + validateField(pllDetailData.lessonDesc) + '</p>' +
                                      '</div>' +
                                      '<div>' +
                                      '	<p>Why were there differences?</p>' +
                                      '	<p>' + validateField(pllDetailData.causeDesc) + '</p>' +
                                      '</div>' +
                                      '<div>' +
                                      '	<p>What can we learn from this?</p>' +
                                      '	<p>' + validateField(pllDetailData.recommendationDesc) + '</p>' +
                                      '</div>' +
                                      '<div>' +
                                      '	<p>Impact</p>' +
                                      '	<p>' + validateField(pllDetailData.impactDesc) + '</p>' +
                                      '</div>' +
                                      '<div>' +
                                      '	<p>Basis of Potential Value</p>' +
                                      '	<p>' + validateField(pllDetailData.potentialValueBasis) + '</p>' +
                                      '</div>');
    if (validateField(pllDetailData.bookmarkInd).toLowerCase() == 'y') {
      $('#headerButtons span:first-child a').data('bookmarkind', 'Y');
      $('#headerButtons span:first-child div').addClass('bookmarked');
      $('#bookmarkCaption').text('Bookmarked');
      $('#bookmarkCaption').css('left', '-37px');
    } else {
      $('#headerButtons span:first-child a').data('bookmarkind', 'N');
      $('#headerButtons span:first-child div').addClass('notBookmarked');
      $('#bookmarkCaption').text('Bookmark');
      $('#bookmarkCaption').css('left', '-25px');
    }
  } else {
    var noResultString = '<div id="no-data-close-button"><a href="ETGPLLResults.html"><figure><img src="images/close.png"><figcaption>Close</figcaption></figure></a></div>' +
	'<div class="no-result"><br/>' +
    '<br/><br/>No data available</div>';
    $('body').empty().append(noResultString);
  }
}

$("body").delegate("#bookmarkLesson", "touchend", function (e) {
  e.preventDefault();
  sendNotificationToIOS("pll", "savelesson", $(this).data('key'));

  // Update the icon for bookmark. Toggle the indicator
  if ($(this).data('bookmarkind') == "Y") {
    $(this).data('bookmarkind', "N");
    //Replace with logic for changing the icon below
    $(this).find('div').removeClass('bookmarked');
    $(this).find('div').addClass('notBookmarked');
    $('#bookmarkCaption').text('Bookmark');
    $('#bookmarkCaption').css('left', '-25px');
  } else {
    $(this).data('bookmarkind', "Y");
    //Replace with logic for changing the icon below
    $(this).find('div').removeClass('notBookmarked');
    $(this).find('div').addClass('bookmarked');
    $('#bookmarkCaption').text('Bookmarked');
    $('#bookmarkCaption').css('left', '-37px');
  }

});

function setTimestamp(date) {
  var monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
//  date = new Date(date*1000);
    date = new Date(date*1000);

    //    alert(date);
  var hours = date.getHours(),
  dayOrNight = 'AM';
  if (hours > 12) {
    dayOrNight = 'PM';
    hours = hours - 12;
  }

    //alert(date);
  return date.getDate() + ' ' +
  monthNames[date.getMonth()] + ' ' +
  date.getFullYear() + ' ' +
  hours + ':' +
  date.getMinutes() + ' ' +
  dayOrNight;
}
