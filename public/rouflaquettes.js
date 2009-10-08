$(document).ready(function() {
  $('#del').hide();
  $('form').submit(function() { $('#del').show(); });
  $('input[type=submit]').click();
 });