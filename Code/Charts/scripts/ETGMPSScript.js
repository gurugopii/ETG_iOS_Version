//method to populate the MPS Chart
function populateMPSChart(mpsData){
  if( typeof mpsData == 'string' ){
    mpsData = JSON.parse(mpsData);
  }
  $('#reportingPeriod').text("Reporting Period: "+mpsData.topInformation.reportingPeriod);
  $('#update').text("Updated: "+mpsData.topInformation.updated);
  var noData = false;

  var MPSStackedChartOptions = setMPSOption();

  if( mpsData.chartdata.series.length == 0){
    noData = true;
    mpsData.chartdata.series = [
                { name : "Filled", data : null },
                { name : "Vacant", data : null }
    ];
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
  MPSStackedChartOptions.title.text = mpsData.chartdata.title;
  MPSStackedChartOptions.xAxis.categories = mpsData.chartdata.categories;
  MPSStackedChartOptions.yAxis.title = { text : mpsData.chartdata.yLabel };
  MPSStackedChart = new Highcharts.Chart(MPSStackedChartOptions);

  if( noData ){
    $('#mpsChart').append('<div id="no-data-banner"> No Data Available </div>');
  }
}// end MPS