var level1PopoverForPGD = 'This radar chart displays how far along a phase each project is in. The more reviews a project has completed, the closer it is to execution. <br/><br/>Different colours are used to indicate if a project is on schedule (refer to chart legend).',
  level2PopoverForPGD = 'Displays all projects in FDP stage. If Duration to Handover is “N/A”, data is not available for that project and is not shown in the chart. Duration is calculated using FDPRC-FDP/Advance Funding Forecast Date. <br/><br/>Tap on an individual project name to proceed to the PAP Screen.',
  level1PopoverForPEM = 'This chart displays the distribution of projects based on its FDP and Execution speed, giving an overview of a project’s performance. <br/><br/>Only projects that have completed FDPRC-FDP/Advance Funding are shown here.',
  level2PopoverForPEM = 'Displays all projects that have completed FDPRC-FDP/Advance Funding and is currently in Execution phase. <br/>If Execution speed is “N/A”, data is not available for that project and will be shown as a red dot in Project Execution Matrix.<br/>Tap on an individual project name to proceed to the PAP Screen.',
  level2PopoverForPEMB = 'Displays the percentage of projects for each of the four quadrants in Project Execution Matrix.',
  level2PopoverForPEMFE = 'Displays the percentage of projects’ justification (by category) which are ahead of schedule in Execution phase.',
  level2PopoverForPEMSE = 'Displays the percentage of projects’ justification (by category) which are behind schedule in Execution phase.',
  gateHTMLContent = '<div id="first-page">' +
  	'<div id="gate-tooltip-container" class="tooltip-container">a</div>' +
    '<div id="gate-chart-main-container" class="chart">' +
	'<p id="gate-title" class="chart-title">Portfolio Gate Distribution Chart</p>' + 
    '<img class="close-button" src="images/close.png"/>' +
	'<div id="gate-chart-container"></div>' +
//	'<p id="gate-legend" class="legend">' +
//	'<span><img src="images/PGDBluePoint.png"/></span>&nbsp;On Time/Ahead of Schedule' +
//	'<span><img src="images/PGDYellowPoint.png"/></span>&nbsp;Overdue' +
//	'<span><img src="images/PGDRedPoint.png"/></span>&nbsp;FDPRC – FDP/Adv Funding Overdue' +
//	'</p>' +
	'</div>' +
    '<div id="gate-table-container" class="table-div"></div>' +
    '</div>',
  matrixHTMLContent = '<div id="second-page">' +
		'<div id="matrix-tooltip-container" class="tooltip-container"></div>' +
		'<p id="matrix-title" class="chart-title">Project Execution Matrix Chart</p>' + 
		'<div id="matrix-chart-main-container" class="chart">' +
			'<img class="close-button" src="images/close.png">' +
			'<div id="matrix-chart-container" class="matrix-chart"></div>' +
			'<p id="matrix-legend" class="legend">' +
				'<span><img src="images/PEMRedPoint.png"/></span>&nbsp;Projects with insufficient data' +
			'</p>' +
			'<div id="matrix-breakdown-container" class="matrix-chart">' +
				'<div id="percent-breakdown-container" class="breakdown-charts">sdads</div>' +
				'<div id="fast-execution-container" class="breakdown-charts">sdads</div>' +
				'<div id="slow-execution-container" class="breakdown-charts">sdads</div>' +
			'</div>' +
		'</div>' +
		'<div id="matrix-table-container" class="table-div"></div>' +
    '</div>';
  