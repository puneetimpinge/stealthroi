// JavaScript Document
// Anchor Scroll//
$(function() {
  $('a[href*=#]:not([href=#carousel-example-generic])').click(function() {
    if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
      var target = $(this.hash);
      target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
      if (target.length) {
        $('html,body').animate({
          scrollTop: target.offset().top-100
        }, 1000);
        return false;
      }
    }
  });
});

// Header Shrink//
$(function() {
    var header = $(".header");
    $(window).scroll(function() {    
        var scroll = $(window).scrollTop();
    
        if (scroll >= 150) {
            header.addClass("shrink");
        } else {
            header.removeClass("shrink");
        }
    });
});

// Multiple Modal//
$(function(){
	$(".links-popup a").click(function(){
			
		$('body').addClass('modal-open-custom');
	});
	$(".close").click(function(){
		$('body').removeClass('modal-open-custom');
	});
});



// Closes the Responsive Menu on Menu Item Click
$('.navbar-collapse ul li a').click(function() {
    $('.navbar-toggle:visible').click();
});