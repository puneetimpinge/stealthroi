$(document).ready(function() {
  $('a.popup').click(function(e) {
    id = $(this).attr("id")
    var width = 600, height = 450;
    var left = (screen.width / 2) - (width / 2);
    var top = (screen.height / 2) - (2 * height / 3);
    var features = 'menubar=no,toolbar=no,status=no,width=' + width + ',height=' + height + ',toolbar=no,left=' + left + ',top=' + top;
    var loginWindow = window.open('/users/auth/'+id, '_blank', features);
    loginWindow.focus();
    e.preventDefault();
    return false;
  });
});
