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

  $('select').material_select();

  $('#fullpage').fullpage();

  $('.modal-trigger').leanModal({
    dismissible: true, // Modal can be dismissed by clicking outside of the modal
    opacity: .3, // Opacity of modal background
    in_duration: 300, // Transition in duration
    out_duration: 200, // Transition out duration
    }
  );

};

$(document).ready(main);
