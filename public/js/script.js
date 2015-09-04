var main = function(){

  console.log("Hello World");

  $(window).scroll(function() {
    if ($(this).scrollTop() <= $('.icon-nav').height()) {
      $('.icon-nav').removeClass('fix-icon-nav')
    } else {
      $('.icon-nav').addClass('fix-icon-nav')
    };
  });

  $('.dropdown-button').dropdown({
      inDuration: 300,
      outDuration: 225,
      constrain_width: false, // Does not change width of dropdown to that of the activator
      hover: false, // Activate on hover
      gutter: 0, // Spacing from edge
      belowOrigin: true // Displays dropdown below the button
    }
  );

  $('#pick-a-time').lolliclock({autoclose:true});

  $('select').material_select();

  $('#fullpage').fullpage();

  $('.modal-trigger').leanModal({
    dismissible: true, // Modal can be dismissed by clicking outside of the modal
    opacity: .3, // Opacity of modal background
    in_duration: 300, // Transition in duration
    out_duration: 200, // Transition out duration
    }
  );

  $('select').material_select();

  $('.datepicker').pickadate({
  selectMonths: true, // Creates a dropdown to control month
  selectYears: 15 // Creates a dropdown of 15 years to control year
  });

};

$(document).ready(main);



// animate({top: 0, left: 0, right: 0}, 500)
// $('.icon-nav').css({"position":"fixed"})
