// $(document).ready(function() {
//   
//   $('#del').hide();
//   $('input[submit]').bind("click", function() {
//            $('#del').show();
//          });
// });

$(document).ready(function(){

  $('#del').hide();

  $('a').click(function(){
    $('#del').show('slow');
  })

  // $('a#close').click(function(){
  //     $('#del').hide('slow');
  //   })

});