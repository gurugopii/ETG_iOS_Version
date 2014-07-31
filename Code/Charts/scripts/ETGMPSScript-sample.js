function getRandomInt (min, max) {
    return Math.floor(Math.random() * (max - min + 1)) + min;
}
var total = 12*7;
var data1 = [], data2 = [];
for (var i = 0; i < total; i++) {
  data1.push(getRandomInt(8,15));
  data2.push(getRandomInt(0,7));
};

var sample1 = JSON.stringify(
    {
        topInformation:
            {
                reportingPeriod: 'March 2013',
                updated :'13 Sep 2013'
            },
        chartdata:
            {
                title: 'Yearly Average Headcount Requirement',
                categories :  [
                                'Jan 2006', 'Feb 2006', 'Mar 2006', 'Apr 2006', 'May 2006', 'Jun 2006', 'Jul 2006', 'Aug 2006', 'Sep 2006', 'Oct 2006', 'Nov 2006', 'Dec 2006',
                                'Jan 2007', 'Feb 2007', 'Mar 2007', 'Apr 2007', 'May 2007', 'Jun 2007', 'Jul 2007', 'Aug 2007', 'Sep 2007', 'Oct 2007', 'Nov 2007', 'Dec 2007',
                                'Jan 2008', 'Feb 2008', 'Mar 2008', 'Apr 2008', 'May 2008', 'Jun 2008', 'Jul 2008', 'Aug 2008', 'Sep 2008', 'Oct 2008', 'Nov 2008', 'Dec 2008',
                                'Jan 2009', 'Feb 2009', 'Mar 2009', 'Apr 2009', 'May 2009', 'Jun 2009', 'Jul 2009', 'Aug 2009', 'Sep 2009', 'Oct 2009', 'Nov 2009', 'Dec 2009',
                                'Jan 2010', 'Feb 2010', 'Mar 2010', 'Apr 2010', 'May 2010', 'Jun 2010', 'Jul 2010', 'Aug 2010', 'Sep 2010', 'Oct 2010', 'Nov 2010', 'Dec 2010',
                                'Jan 2011', 'Feb 2011', 'Mar 2011', 'Apr 2011', 'May 2011', 'Jun 2011', 'Jul 2011', 'Aug 2011', 'Sep 2011', 'Oct 2011', 'Nov 2011', 'Dec 2011',
                                'Jan 2012', 'Feb 2012', 'Mar 2012', 'Apr 2012', 'May 2012', 'Jun 2012', 'Jul 2012', 'Aug 2012', 'Sep 2012', 'Oct 2012', 'Nov 2012', 'Dec 2012',
                                'Jan 2013', 'Feb 2013', 'Mar 2013', 'Apr 2013', 'May 2013', 'Jun 2013', 'Jul 2013', 'Aug 2013', 'Sep 2013', 'Oct 2013', 'Nov 2013', 'Dec 2013',
                              ],
                yLabel : 'Headcount',
                series :
                    [
                        { name : "Filled", data: data1},
                        { name : "Vacant", data: data2}
                    ]
            },
        tabledata :
            {
                header: 'Year',
                body:
                [
                    {name : 2012, filled: 10, vacant: 3},
                    {name : 2013, filled: 9, vacant: 1},
                    {name : 2014, filled: 13, vacant: 2}
                ]
            }
    }
    );

var sample2 ='{'+
              '               "chartdata": {'+
              '               "title": "Yearly Average Headcount Requirement",'+
               '              "categories": [ '+
                '                            "2012", '+
                 '                           "2013", '+
                  '                          "2014" '+
                   '                         ], '+
                    '         "yLabel": "Headcount", '+
                     '        "series": [ '+
                      '                  { '+
                       '                 "name": "Filled", '+
                        '                "data": [ '+
'                        10, '+
 '                                                9, '+
  '                                               13 '+
   '                                              ] '+
    '                                    }, '+
     '                                   {'+
      '                                  "name": "Vacant", '+
       '                                 "data": [ '+
        '                                         3, '+
         '                                        1, '+
          '                                       2 ' +
           '                                      ]' +
            '                            } '+
             '                           ]'+
              '               },'+
               '              "topInformation": { '+
                '             "reportingMonth": "Jan-2014", '+
                 '            "updated": "28 Feb 2014" '+
                  '           } '+
                   '          } ';

var sampleNoData = JSON.stringify(
    {
        topInformation:
            {
                reportingPeriod: 'March 2013',
                updated :'13 Sep 2013'
            },
        chartdata:
            {
                title: 'Yearly Average Headcount Requirement',
                yLabel : 'Headcount',
                categories : [null],
                series : [
                    { name : "Filled", data: [null]},
                    { name : "Vacant", data: [null]}
                ]
            },
        tabledata :
            {
                header : 'Year',
                body: [ null ]
            }
    }
    );


var samplePortfolio = JSON.stringify(
    {
        topInformation:
            {
                reportingPeriod: 'March 2013',
                updated :'13 Sep 2013'
            },
        chartdata:
            {
                title: 'Yearly Average Headcount Requirement',
                categories : ['2012', '2013', '2014'],
                yLabel : 'Headcount',
                series :
                    [
                        { name : "Filled", data: [ 10, 9, 13]},
                        { name : "Vacant", data: [ 3, 1, 2, 3, 1, 2, 3, 1, 2, 3, 1, 2, 3, 1, 2, 3, 1, 2, 3, 1, 2, 3, 1, 2 ]}
                    ]
            },
        tabledata :
            {
                header: ['Jan 2013', 'Feb 2013', 'Mar 2013', 'Apr 2013', 'May 2013', 'Jun 2013'],
                body:
                [
                    {
                      region: 'Region I',
                      projects: [
                                  {name: 'Project A', filled: [1,2,3,4,5,6], vacant: [6,5,4,3,2,1]} ,
                                  {name: 'Project B', filled: [9,8,7,6,5,4], vacant: [3,4,2,1,3,4]}
                                ]
                    },
                    {
                      region: 'Region II',
                      projects: [
                                  {name: 'Project C', filled: [1,2,3,4,5,6], vacant: [6,5,4,3,2,1]} ,
                                  {name: 'Project D', filled: [9,8,7,6,5,4], vacant: [3,4,2,1,3,4]}
                                ]
                    },
                ]
            }
    }
    );

