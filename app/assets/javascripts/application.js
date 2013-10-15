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

  $('.plus-one-givers-link').on('click', function() {
    $('.plus-one-givers[data-acc='+$(this).data('acc')+']').toggle();
  });

  $('.plus-one-givers').on('mouseleave', function() {
    $(this).hide();
  });

  buildAccomplishmentChart();
});

function buildAccomplishmentChart() {
  var view = $('#accomplishments-chart');
  if(!view) return;

  var data = eval(view.data('counts'));
  var categories = data.map(function(e) { return e.shift(); });

  view.highcharts({
    title: { text: 'Accomplishments last 12 months' },
    chart: { type: 'line', zoomType: 'x' },
    xAxis: { categories: categories },
    yAxis: { title: { text: 'Count' }, min: 0, allowDecimals: false },
    series:[ { name: 'Accomplishments', data: data} ],
    credits: { enabled: false },
    plotOptions: {
      line: { marker: { enabled: false }, connectNulls: true },
      series: { lineWidth: 5 }
    }
  });
}
