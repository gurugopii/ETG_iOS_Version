
//the next line of code is for testing purposes only
// populatePLLWelcome(lessonsCountData);
//Populate method for the whole Welcome Screen
function populatePLLWelcome(lessonsCountData) {
  //Populate Project lesson count
   var tableRows = '';
  if (lessonsCountData.projects.length < 1) {
    tableRows = '<tr>' +
      '<td colspan="3">No data available</td>' +
      '</tr>';
  } else {
    $.each(lessonsCountData.projects, function (index, row) {
      tableRows += '<tr>' +
      '<td><a class="toProjectResults" href="#" data-key="' + validateField(row.projectKey) + '">' + validateField(row.projectName) + '</a></td>' +
      '<td>' + validateField(row.replicateLessons) + '</td>' +
      '<td>' + validateField(row.avoidLessons) + '</td>' +
      '<td>' + (validateNumberField(row.replicateLessons) + validateNumberField(row.avoidLessons)) + '</td>' +
      '</tr>';
    });
  }
  var projectsCountTable = '<table id="projectsTable">' +
    '<thead>' +
    '<tr>' +
    '<th>Project</th>' +
    '<th>Lessons To Be Replicated</th>' +
    '<th>Lessons To Be Avoided</th>' +
    '<th>Total</th>' +
    '</tr>' +
    '</thead>' +
    '<tbody>' +
    tableRows +
    '</tbody>' +
    '</table>';

  $('#projectsCountTab').empty().append(projectsCountTable);
  setProperAlignment($('#projectsTable tr'));
  $('#projectsTable').tablesorter({
    sortList : [[3, 1]], headers : { 0: {sorter : false}, 1: {sorter : false}, 2: {sorter : false}}
  });

  //Populate PLL Review lesson count
  tableRows = '';
  if (lessonsCountData.pllReviews.length < 1) {
    tableRows = '<tr>' +
      '<td colspan="3">No data available</td>' +
      '</tr>';
  } else {
    $.each(lessonsCountData.pllReviews, function (index, row) {
      tableRows += '<tr>' +
      '<td><a class="toPllReviewResults" href="#" data-key="' + validateField(row.pllReviewKey) + '">' + validateField(row.pllReview) + '</a></td>' +
      '<td>' + validateField(row.replicateLessons) + '</td>' +
      '<td>' + validateField(row.avoidLessons) + '</td>' +
      '<td>' + (validateNumberField(row.replicateLessons) + validateNumberField(row.avoidLessons)) + '</td>' +
      '</tr>';
    });
  }
  var pllReviewsCountTable = '<table  id="reviewsTable">' +
    '<thead>' +
    '<tr>' +
    '<th>PLL Review</th>' +
    '<th>Lessons To Be Avoided</th>' +
    '<th>Lessons To Be Replicated</th>' +
    '<th>Total</th>' +
    '</tr>' +
    '</thead>' +
    '<tbody>' +
    tableRows +
    '</tbody>' +
    '</table>';

  $('#pllReviewsCountTab').empty().append(pllReviewsCountTable);
  setProperAlignment($('#reviewsTable tr'));
  $('#reviewsTable').tablesorter({
    sortList : [[3, 1]], headers : { 0: {sorter : false}, 1: {sorter : false}, 2: {sorter : false}}
  });
  $('td:nth-child(4)').hide();
  $('th:nth-child(4)').hide();

}
$('#tbSearchBar').css('border-radius', '4px !important');
//Register all the delegates START

//Add the logic to switch the tab for Projects and Pll Reviews
$('#lessonsCountSwitch').delegate("a", "touchend", function (e) {
  if ($(this).parent('li').hasClass('active')) {
    //If the tab is already selected don't do anything
    // $($(this).attr('href')).hide();
  } else {
    e.preventDefault();
    $(this).tab('show');
    //Move the search app, show back button, hide the logo and welcome
    moveUpSearch();
  }
});

//Once the data is in the tables, add the listeners to on click event
$("#lessonsCountContent").delegate("a.toProjectResults", "touchend", function () {
  sendNotificationToIOS("pll", "projectcount", $(this).data('key'));

  //the next line of code is for testing purposes only
  //document.location = 'ETGPLLResults.html';
});

$("#lessonsCountContent").delegate("a.toPllReviewResults", "touchend", function () {
  sendNotificationToIOS("pll", "pllreviewcount", $(this).data('key'));
  //the next line of code is for testing purposes only
  //document.location = 'ETGPLLResults.html';
});

//Handle the click on search submit
$('body').delegate("#searchForm", "submit", function (e) {
  e.preventDefault();
  sendNotificationToIOS("pll", "searchlesson", $('#tbSearchBar').val());

  //the next line of code is for testing purposes only
  //document.location = 'ETGPLLResults.html';
});

//Move the search bar app on focus
$('body').delegate("#tbSearchBar", "focus", function (e) {
  moveUpSearch();
});

////added actions for moving of the search bar
$('body').delegate("#backButtonContainer", "touchend", function (e) {
  moveBackSearch();
});
//Register all the delegates FINISH

function moveUpSearch() {
  //moving of search bar
$('#pllWelcomeContainer').hide();
//  $('#pllWelcomeContainer').css('margin-top', '-128px');
  $('#searchForm').css('margin-top', '1%');
  $('#backButtonContainer').show();
  // $('#backButtonContainer').css('opacity', '1');
}
function moveBackSearch() {
  $('#pllWelcomeContainer').show();
  $('#pllWelcomeContainer').css('margin-top', '13%');
  $('#backButtonContainer').hide();
  // $('#backButtonContainer').css('opacity', '0');
  $('#lessonsCountContent div').removeClass('active');
  $('.nav-pills li').removeClass('active');
}
