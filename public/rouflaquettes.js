$(document).ready(function() {
  $('#del').hide();
  $('input[type=submit]').bind('submit',function() {
       $('#del').show();
     });
 });