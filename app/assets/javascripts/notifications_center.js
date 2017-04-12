$( document ).on('turbolinks:load', function() {

    // open notification center on click
    $("#open_notification").click(function()
    {
        $("#notificationContainer").fadeToggle(300);
        $("#notification_count").fadeOut("fast");
        return false;
    });

    // hide notification center on click
    $(document).click(function()
    {
        $("#notificationContainer").hide();
    });


    $("#notificationContainer").click(function()
    {
        // return false;
    });
    // $("#notificationList").on('click', 'li', function(event) {
    //   // alert($('.orderId').html());
    // });
    $("#notificationList").on('mouseenter', 'li', function(event) {
      $(this).css({"cursor":"pointer"});
      /* Act on the event */
    });
    $("#notificationList").on('mouseleave', 'li', function(event) {
      $(this).css({"cursor":"default"});
      /* Act on the event */
    });

});
