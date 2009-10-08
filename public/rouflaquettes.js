$(document).ready(function() {
  $('#del').hide();
  $('input[type=submit]').click('submit',function() {
     $('#del').show();
   });
 });