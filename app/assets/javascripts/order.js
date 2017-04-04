jQuery(function() {
   $('#order_user_name').autocomplete({
    source: $('#order_user_name').data('autocomplete-source'),

  });
  $("#ui-id-1").on('click', function(event) {
    $("#added").append('<li>'+$("#order_user_name").val()+'</li>');
    $("#order_user_name").val("");

  });
  $('#new_order').submit(function(event) {
    event.preventDefault();
    var dataToSubmit = $(this).serialize();
    var users = $("#added li");
    var usersToSend=[];
    for (var i = 0; i < users.length; i++) {
      usersToSend[i]=users[i].innerText;
    }

    // alert(JSON.stringify(usersToSend));

    dataToSubmit += "&users_to_send="+usersToSend;

    // alert(dataToSubmit);

    $.post($(this).attr('action'),dataToSubmit);

    // $.ajax({
    //   url: '/ordermembers/new',
    //   type: 'GET',
    //
    //   data: {usersInvited: JSON.stringify(usersToSend)},
    //   success: function(){
    //     alert("success!!");
    //   }
    // });


    // this.submit();
  });
});
