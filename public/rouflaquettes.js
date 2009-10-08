$(document).ready(function() {
  
  $('#del').hide();
  $('input[id=bookmark]').bind("click", function() {
           $('#del').show();
         });
});