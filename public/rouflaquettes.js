$(document).ready(function() {
  $('#del').hide();
  // $('input[type=submit]').click(function() {
  //        $('#del').show();
  //      });
  //  });
  $('form').submit(function(){  
      $(':submit', this).click(function() {  
          $('#del').show();
      });  
  });
});