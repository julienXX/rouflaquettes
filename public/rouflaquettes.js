$(document).ready(function() {
  
  $('#del').hide();
  $('input[submit]').bind("click", function() {
           $('#del').show();
         });
});