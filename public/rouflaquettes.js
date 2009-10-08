$(document).ready(function() {
  $('div[id=delicious_credentials]').hide();
  $('input[type=submit]').bind('submit',function() {
     $('div[id=delicious_credentials]').show();
   });
 });