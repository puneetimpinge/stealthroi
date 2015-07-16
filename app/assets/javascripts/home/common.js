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

function alert_box(msg){

    // var s=""
    // $.each(msg, function(key, element) {
    //     s=s+"<br/>"+element.toSource().replace('{','').replace('}','').replace('(','').replace(')','')
    //     // alert('key: ' + key + '\n' + 'value: ' + element);
    // });

    $(".alert_message").html(msg)
    $('#alertModal').css("z-index","1041").modal('show')
    setTimeout(function(){
        $('#alertModal').modal('hide')
    }, 10000);
  }

  function notice_box(msg){
    $(".notice_message").html(msg)
    $('#noticeModal').css("z-index","1041").modal('show')
    setTimeout(function(){
        $('#noticeModal').modal('hide')
    }, 3000);
  }
