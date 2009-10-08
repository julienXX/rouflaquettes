$(document).ready(function() {
  $('div.delicious_credentials').hide();
  $('input[type=submit]').click('submit',function() {
     $('div.delicious_credentials').show();
   });
 });