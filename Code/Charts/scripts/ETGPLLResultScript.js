var pageFunction = '';
$('#resultsTopBar a .resultsSwitch').click(function (e) {
  alert('click on tab')
  if ($(this).parent('li').hasClass('active')) {
    //If the tab is already selected don't do anything
    // $($(this).attr('href')).hide();
  } else {
    e.preventDefault();
    $(this).tab('show');
  }

  sendNotificationToIOS("pll", "changetab", setTabData($(this).attr('href')));
  console.log(setTabData($(this).attr('href')));
});

$('.resultsSwitch').on('click', function () {
  console.log('change tab');
  sendNotificationToIOS("pll", "changetab", setTabData($(this).attr('href')));
  console.log(setTabData($(this).attr('href')));
});

function setTabData(attribute) {
  if (attribute == '#avoidTab') {
    return 'avoid';
  }
  return 'replicate'

}
//the next line of code is for testing purposes only
// populatePLLResults(pllResultsData);
//Populate method for the whole Results page
function populatePLLResults(pllResultsData) {

  pllResultsData = pllResultsData === undefined || pllResultsData === null ? JSON.parse('{"searchBarContent":"","searchResults":[],"pageFunction":"search", "activeTab":"replicate"}') : pllResultsData;

  if (validateField(pllResultsData.activeTab) == "avoid") {
    $('#resultsTopBar a[href="#avoidTab"]').tab('show');
  } else if (validateField(pllResultsData.activeTab) == "replicate") {
    $('#resultsTopBar a[href="#replicateTab"]').tab('show');
  }

  pageFunction = validateField(pllResultsData.pageFunction);
  
  //Populate searchBar if anything passed
  if (validateField(pllResultsData.searchBarContent) != "" && validateField(pllResultsData.searchBarContent) != null) {

    $('#tbSearchBar').val(validateField(pllResultsData.searchBarContent).replace(/%20/g, ' '));
  }
  //Populate the to be Replicated and to be avoided tables


  //Populate Project lesson count
  var tableRowsReplicate = '',
  tableRowsAvoid = '',
  isDataLengthGreaterThanZero = true,
  replicateCount = 0,
  avoidCount = 0;

  if (pllResultsData.searchResults.length < 1) {

    isDataLengthGreaterThanZero = false;

  } else {

    var replicateNumber = 1;
    var avoidNumber = 1;
    $.each(pllResultsData.searchResults === undefined || pllResultsData.searchResults === null ? JSON.parse('[]') : pllResultsData.searchResults, function (index, row) {
      if (validateField(row.replicateInd) != null) {
        var tableRow = '<tr>' +
          //          '<td>' + validateField(row.projectLessonDetailKey) + '</td>' +
          '<td>' + (row.replicateInd == 'Y' ? replicateNumber++ : avoidNumber++) + '</td>' +
          '<td><a class="toLessonDetail" data-key="' + validateField(row.projectLessonDetailKey) + '">' + setProperDataFormat(validateField(row.lessonDesc)) + '</a></td>' +
          '<td>' + setProperDataFormat(validateField(row.impactDesc)) + '</td>' +
          '<td>' + setProperDataFormat(validateField(row.recommendationDesc)) + '</td>' +
          '<td>' + numberWithCommas(validateField(row.potentialValueConverted)) + '</td>' +
          '<td>' + validateField(row.projectName) + '</td>' +
          // '<td><a class="bookmarkLesson" data-bookmarkind="' + validateField(row.bookmarkInd) +
          // '" data-key="' + validateField(row.projectLessonDetailKey) + '"><img src="' + getBookmark(validateField(row.bookmarkInd)) + '"/></a></td>' +
          '<td><a class="bookmarkLesson" data-bookmarkind="' + validateField(row.bookmarkInd) +
          '" data-key="' + validateField(row.projectLessonDetailKey) + '"><div class="bookmark ' + addBookmarkClass(validateField(row.bookmarkInd)) + '"></div></a></td>' +
          '<td>' + validateField(row.projectLessonDetailID) + '</td>' +
          '</tr>';
        if (validateField(row.replicateInd) == "Y") {
          tableRowsReplicate += tableRow;
          replicateCount++;
        } else {
          tableRowsAvoid += tableRow;
          avoidCount++;
        }
      }
    });
  }
  var replicateTable = '<table id="replicateTable" class="petronas">' +
    '<thead>' +
    '<tr>' +
    '<th>No.</th>' +
    '<th>What actually<br/>happened?</th>' +
    '<th>Impact</th>' +
    '<th>What can we learn from this?</th>' +
    '<th>Potential Value (RM)</th>' +
    '<th>Project</th>' +
    '<th>Book<br/>mark</th>' +
    '<th>key</th>' +
    '</tr>' +
    '</thead>' +
    '<tbody>' +
    tableRowsReplicate +
    '</tbody>' +
    '</table>';

  var avoidTable = '<table id="avoidTable" class="petronas">' +
    '<thead>' +
    '<tr>' +
    '<th>No.</th>' +
    '<th>What actually<br/>happened?</th>' +
    '<th>Impact</th>' +
    '<th>What can we learn from this?</th>' +
    '<th>Potential Value (RM)</th>' +
    '<th>Project</th>' +
    '<th>Book<br/>mark</th>' +
    '<th>key</th>' +
    '</tr>' +
    '</thead>' +
    '<tbody>' +
    tableRowsAvoid +
    '</tbody>' +
    '</table>';

  var noResultStringSearch = '<div class="no-result">Your search did not match any documents.<br/>' +
    '<br/>Suggestions:<br/>' +
    '&bull;&nbsp;Make sure that all words are spelled correctly<br/>' +
    '&bull;&nbsp;Try different keywords<br/>' +
    '&bull;&nbsp;Try more general keywords<br/></div>';

  var noResultStringBookmarks = '<div class="no-result"><p></p><p></p><p></p>No data available</div>';

  console.log(validateField(pllResultsData.isNoConnection))
  if (validateField(pllResultsData.isNoConnection).toLowerCase() == 'y') {

    noResultStringBookmarks = '<div class="no-result"><p></p><p></p><p></p>Server could not be reached. Please check your network connection.</div>';
    noResultStringSearch = noResultStringBookmarks;

  }

  //checking if there are search results
  if (isDataLengthGreaterThanZero) {
    if (replicateCount > 0) {
		var sortListForReplicate = [7,0];
		if(pllResultsData.sortListForReplicate !== null || pllResultsData.sortListForReplicate !== undefined){
			sortListForReplicate = pllResultsData.sortListForReplicate;
		}
      $('#replicateTab').empty().append(replicateTable);
	  setProperAlignment($('#replicateTable tr'));
      $('#replicateTable').tablesorter({
        // sortList : [[7, 0]],
        sortList : [sortListForReplicate],
        headers : {
          0 : {
            sorter : false
          },
          6 : {
            sorter : false
          }
        }
      }).bind("sortEnd", function (sorter) {
        var currentSort = sorter.target.config.sortList;
		console.log(currentSort[0]);
		
		sendNotificationToIOS('pll', 'sortForReplicate', currentSort[0]);
      });

    } else {
      if (validateField(pllResultsData.pageFunction).toLowerCase() == 'search') {
        $('#replicateTab').empty().append(noResultStringSearch);
      } else {
        $('#replicateTab').empty().append(noResultStringBookmarks);
      }

    }

    if (avoidCount > 0) {
      $('#avoidTab').empty().append(avoidTable);
	  var sortListForAvoid = [7,0];
		if(pllResultsData.sortListForAvoid !== null || pllResultsData.sortListForAvoid !== undefined){
			sortListForAvoid = pllResultsData.sortListForAvoid;
		}
	  setProperAlignment($('#avoidTable tr'));
      $('#avoidTable').tablesorter({
        sortList : [sortListForAvoid],
        headers : {
          0 : {
            sorter : false
          },
          6 : {
            sorter : false
          }
        }
      }).bind("sortEnd", function (sorter) {
        var currentSort = sorter.target.config.sortList;
		console.log(currentSort[0]);
		sendNotificationToIOS('pll', 'sortForAvoid', currentSort[0]);
      });

      $('#avoidTable tr td:first-child').each(function (index, value) {
        $(this).html(++index);

      });
      $('#replicateTable tr td:first-child').each(function (index, value) {
        $(this).html(++index);

      });

    } else {
      if (validateField(pllResultsData.pageFunction).toLowerCase() == 'search') {
        $('#avoidTab').empty().append(noResultStringSearch);
      } else {
        $('#avoidTab').empty().append(noResultStringBookmarks);
      }
    }

    $('.petronas th:first-child').removeClass('tablesorter-headerAsc');
    $('#avoidTable td:nth-child(8)').hide();
    $('#replicateTable th:nth-child(8)').hide();
    $('#avoidTable th:nth-child(8)').hide();
    $('#replicateTable td:nth-child(8)').hide();

  } else {
    if (validateField(pllResultsData.pageFunction).toLowerCase() == 'search') {
      $('#avoidTab').empty().append(noResultStringSearch);
      $('#replicateTab').empty().append(noResultStringSearch);
    } else {
      $('#replicateTab').empty().append(noResultStringBookmarks);
      $('#avoidTab').empty().append(noResultStringBookmarks);
    }

  }
}

function addBookmarkClass(indicator) {
  if (indicator.toLowerCase() == 'y') {
    return 'bookmarked';
  }
  return 'notBookmarked'
}

//Once the data is in the tables, add the listeners to on click event
$("#resultsTabContent").delegate("a.toLessonDetail", "touchend", function () {
  //			e.preventDefault();
  sendNotificationToIOS("pll", "showlesson", $(this).data('key'));

  //the next line of code is for testing purposes only
  //document.location = 'ETGPLLDetail.html';
});

$("#resultsTabContent").delegate("a.bookmarkLesson", "touchend", function () {
  //            e.preventDefault();
  sendNotificationToIOS("pll", "savelesson", $(this).data('key'));

  console.log($(this).data('bookmarkind'));
  //Update the icon for bookmark
  // Update the icon for bookmark. Toggle the indicator
  if ($(this).data('bookmarkind') == "Y") {
    $(this).data('bookmarkind', "N");
    //Replace with logic for changing the icon below
    $(this).find('div').removeClass('bookmarked');
    $(this).find('div').addClass('notBookmarked');
  } else {
    $(this).data('bookmarkind', "Y");
    //Replace with logic for changing the icon below
    $(this).find('div').removeClass('notBookmarked');
    $(this).find('div').addClass('bookmarked');
    $('#bookmarkCaption').text('Bookmarked');
  }
});

//Handle the click on search submit
$('#searchForm').submit(function (e) {
  e.preventDefault();
  sendNotificationToIOS("pll", "searchlesson", $('#tbSearchBar').val());

  //the next line of code is for testing purposes only
  //document.location = 'ETGPLLResults.html';
});


$('#backButtonForResult').on('touchend', function () {
  console.log('back button click');
  // sendNotificationToIOS("pll", "changetab", setTabData($(this).attr('href')));\
  
  if(pageFunction.toLowerCase() != 'search'){
	sendNotificationToIOS("pll", "searchhistory", "");
  } else {
	window.location = "ETGPLLWelcome.html";
  }
});

function setProperDataFormat(string) {
  if (string.length > 75) {
    return string.substring(0, 74) + '...';
  }
  return string;
}


