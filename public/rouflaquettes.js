$(document).ready(function() {
  $('form').submit(function(){  
      $(':submit', this).click(function() {  
          return false;  
      });  
  });
  $('#del').hide();
  $('input[type=submit]').click(function() {
           $('#del').show();
         });
     });
  
});