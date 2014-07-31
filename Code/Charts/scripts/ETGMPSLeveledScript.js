//method to populate the MPS Chart
function populateMPSChart(mpsData, level, id){
  var MPSStackedChartOptions = setMPSOption();
  if( level == 2){
    if( typeof setMarginForLevel2 == 'function' ){
      setMarginForLevel2(MPSStackedChartOptions);
    }
    else{
      MPSStackedChartOptions.chart.marginRight = margin;
      MPSStackedChartOptions.chart.marginLeft = margin;
    }
  }

  if( mpsData.chartdata.categories.length > 0 ){
    if( mpsData.chartdata.categories.length > 72 )
    {
      MPSStackedChartOptions.xAxis.labels = { step :3, maxStaggerLines: 1, showLastLabel: true, rotation: -90, y: 25 };
      MPSStackedChartOptions.legend.y += 15;
    }
    else if( mpsData.chartdata.categories.length > 48 )
    {
      MPSStackedChartOptions.xAxis.labels = { step :2, maxStaggerLines: 1, showLastLabel: true, rotation: -90, y: 25 };
      MPSStackedChartOptions.legend.y += 15;
    }
    else if( mpsData.chartdata.categories.length > 16)
    {
      MPSStackedChartOptions.xAxis.labels = { step :1, maxStaggerLines: 1, showLastLabel: true, rotation: -90, y: 25 };
      MPSStackedChartOptions.legend.y += 15;
    }
  }

  // TODO:: Check if the data is okay.
  MPSStackedChartOptions.series = mpsData.chartdata.series;
  MPSStackedChartOptions.xAxis.categories = mpsData.chartdata.categories;
  MPSStackedChartOptions.yAxis.title = {text: 'Total Loading'};
  MPSStackedChartOptions.title.text = 'Project Manpower Loading Requirement';
  MPSStackedChart = new Highcharts.Chart(MPSStackedChartOptions);

  if(level == 1){
    nextPage(MPSStackedChart, id);
  }
  else{
    backImage(MPSStackedChart);
  }
}// end MPS


//method to populate the detailed MPS Chart
function populateMPSProjectTable(mpsData){
  var MPStabledata = mpsData.tabledata;
  var container = $('#tableMPSContainer');
  var tableRows = '';

  if (MPStabledata.length === 0) {
    tableRows += '<tr>' +
    '<td colspan="4">No Data Available</td>' +
    '</tr>';
  }
  else{ //TODO:: Generate the table rows.
    $.each(MPStabledata.body, function (i, row) { //TODO:: Generate the proper table structure
      var grandTotal = (row.filled == 'N/A' || row.vacant == 'N/A') ? 'N/A' : formatNumber(row.filled + row.vacant);
      tableRows += '<tr>' +
      '<td class="center period-column">' + row.name + '</td>' +
      '<td class="center filled-column">' + row.filled + '</td>' +
      '<td class="center vacant-column">' + row.vacant + '</td>' +
      '<td class="center total-column">' + grandTotal + '</td>' +
      '</tr>';
    });
  }
  var table = '<table id="MPStable" class="petronas zebra">' +
    '<thead class="fixedHeader">' +
    '<tr>' +
    '<th rowspan="2" class="period-column sorter-false"><span class="th-inner">Month</span></th>' +
    '<th colspan="3" class="sorter-false"><span class="th-inner">Total Requirements</span></th>' +
    '</tr>' +
    '<tr>' +
    '<th class="filled-column"><span class="th-inner">Filled</span></th>' +
    '<th class="vacant-column"><span class="th-inner">Vacant</span></th>' +
    '<th class="total-column"><span class="th-inner">Grand Total</span></th>' +
    '</tr>' +
    '</thead>' +
    '<tbody>' + // Override the height because the header of this table consists of 2 rows
    tableRows +
    '</tbody>' +
    '</table>';

  container.empty().append(table);

  if (MPStabledata.length === 0){
    noDataDisplay('#MPStable');
  }

  $('#MPStable').tablesorter({
    textExtraction : function(s) {
      if ($(s).find('img').length === 0)
        return $(s).text();
      return $(s).find('img').attr('alt');
    }
  });

  $('.sorter-false').removeClass('tablesorter-header');

  setHighlightOnTouch('#MPStable');
}


//method to populate the detailed MPS Chart
function populateMPSPortfolioTable(mpsData){
  var MPStabledata = mpsData.tabledata;
  var container = $('#tableMPSContainer');
  var tableRows = '';
  var year = '';

  if ( MPStabledata == 'no data' ) {
    tableRows += '<tr>' +
    '<td colspan="15">No Data Available</td>' +
    '</tr>';
    year = 'Year';
  }
  else if (typeof MPStabledata === 'string' || MPStabledata.length === 0){
   tableRows += '<tr>' +
    '<td colspan="15">No Data Available</td>' +
    '</tr>';
    year = MPStabledata;
  }
  else{ //TODO:: Generate the table rows.
    var spanClass = '';
    $.each(MPStabledata.body, function (projectIndex, project) { //TODO:: Generate the proper table structure
      if( projectIndex % 2 == 0){
        spanClass = 'span-odd';
      }
      else{
        spanClass = 'span-even';
      }

      var entry = '<tr>'+
      '<td rowspan="2" class="region-column '+ spanClass +'">'+project.region+'</td>';
      entry += '<td rowspan="2" class="project-column '+ spanClass +'">'+project.name+'</td>';
      entry += '<td class="status-column">Filled</td>';
      $.each(MPStabledata.header, function(i, head){
        entry += '<td>'+ formatNumber( head.filled[projectIndex] ) +'</td>';
      });
      entry += '</tr>'
      entry += '<tr><td class="status-column">Vacant</td>';
      $.each(MPStabledata.header, function(i, head){
        entry += '<td>'+ formatNumber( head.vacant[projectIndex] )+'</td>';
      });
      entry += '</tr>';
      tableRows += entry;
    });
    year = MPStabledata.header[0].period.substr(4,4);
  }

  var table = '<table id="MPStable" class="petronas zebra" class="table-layout-fixed">' +
    '<thead class="fixedHeader">' +
    '<tr>' +
    '   <th class="region-column" rowspan="2"><span class="th-inner">Region</span></th>' +
    '   <th class="project-column" rowspan="2"><span class="th-inner">Project</span></th>' +
    '   <th class="status-column" rowspan="2"><span class="th-inner">Staffing Status</span></th>' +
    '   <th colspan="12">'+ year +'</th>' +
    '</tr>' +
    '<tr>'+
    '   <th><span class="th-inner">Jan</span></th>' +
    '   <th><span class="th-inner">Feb</span></th>' +
    '   <th><span class="th-inner">Mar</span></th>' +
    '   <th><span class="th-inner">Apr</span></th>' +
    '   <th><span class="th-inner">May</span></th>' +
    '   <th><span class="th-inner">Jun</span></th>' +
    '   <th><span class="th-inner">Jul</span></th>' +
    '   <th><span class="th-inner">Aug</span></th>' +
    '   <th><span class="th-inner">Sep</span></th>' +
    '   <th><span class="th-inner">Oct</span></th>' +
    '   <th><span class="th-inner">Nov</span></th>' +
    '   <th><span class="th-inner">Dec</span></th>' +
    '</tr>' +
    '</thead>' +
    '<tbody>' +
    tableRows +
    '</tbody>' +
    '</table>';

  container.empty().append(table);

  if (MPStabledata.length === 0){
    noDataDisplay('#MPStable');
  }

  setHighlightOnTouch('#MPStable');
}


function formatNumber(number){
  if( number == 'N/A' ) return number;

  if( number == null || typeof number == 'undefined' ) return 'N/A';

  return Math.round( number * 100 ) / 100;
}