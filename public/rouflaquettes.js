$(document).ready(function() {
  
  $('#del').hide();
  $('input[id='bookmark']').click(function() {
           $('#del').show();
         });
     });
  
  $('form').submit(function(){  
     $(':submit', this).click(function() {  
         return false;  
     });  
  });
  
});