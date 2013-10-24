// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require uservoice
//= require typeahead.min
//= require highcharts
//= require highcharts/highcharts-more
//= require highcharts/adapters/standalone-framework
//= require highcharts/themes/grid

$(document).ready(function() {
  var usersInput = $('input#users');
  (usersInput.length) && $('#accomplishment_receiver_username').typeahead({
    name: 'username', local: usersInput.val().split(',')
  });

  buildAccomplishmentChart();
  buildTagsChart();
  buildGivenTagsChart();
});

function buildAccomplishmentChart() {
  var view = $('#trends-chart');
  if(!view) return;

  var accData = eval(view.data('accomplishments'));
  var postData = eval(view.data('posts'));
  var categories = accData.map(function(e) { return e.shift(); });

  view.highcharts({
    title: { text: 'Monthly Accomplishment Trends' },
    chart: { type: 'line', zoomType: 'x' },
    xAxis: { categories: categories },
    yAxis: { title: { text: 'Count' }, min: 0, allowDecimals: false },
    series:[ 
      { name: 'Posted', data: postData, color: 'blue' },
      { name: 'Received', data: accData, color: 'green' }
    ],
    plotOptions: {
      line: { marker: { enabled: false }, connectNulls: true },
      series: { lineWidth: 3 }
    }
  });
}

function buildTagsChart() {
  var view = $('#tags-chart');
  if(!view) return;
  var data = eval(view.data('counts'));
  if(data.length == 0)  {
    view.remove();
    return;
  }

  view.highcharts({
    chart: { plotBackgroundColor: null, plotBorderWidth: null, plotShadow: false },
    title: { text: 'Accomplishments by Tag' },
    tooltip: { pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>' },
    plotOptions: {
      pie: {
        allowPointSelect: true,
        cursor: 'pointer',
        dataLabels: {
          enabled: true,
          color: '#000000',
          connectorColor: '#000000',
          format: '<b>#{point.name}</b>: {point.percentage:.1f} %'
        }
      }
    },
    series: [{ type: 'pie', name: 'Accomplishments', data: data }]
  });
}

function buildGivenTagsChart() {
  var view = $('#tags-given-chart');
  if(!view) return;
  var data = eval(view.data('counts'));
  if(data.length == 0)  {
    view.remove();
    return;
  }

  view.highcharts({
    chart: { plotBackgroundColor: null, plotBorderWidth: null, plotShadow: false },
    title: { text: 'Posts by Tag' },
    tooltip: { pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>' },
    plotOptions: {
      pie: {
        allowPointSelect: true,
        cursor: 'pointer',
        dataLabels: {
          enabled: true,
          color: '#000000',
          connectorColor: '#000000',
          format: '<b>#{point.name}</b>: {point.percentage:.1f} %'
        }
      }
    },
    series: [{ type: 'pie', name: 'Posts', data: data }]
  }); 
}
