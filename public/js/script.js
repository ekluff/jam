var main = function(){

  $('.scrollspy').scrollSpy();
  console.log("Hello World");

  $(window).scroll(function() {
    if ($(this).scrollTop() <= $('.icon-nav').height()) {
      $('.icon-nav').removeClass('fix-icon-nav')
    } else {
      $('.icon-nav').addClass('fix-icon-nav')
    };
  });

};

$(document).ready(main);



// animate({top: 0, left: 0, right: 0}, 500)
// $('.icon-nav').css({"position":"fixed"})
