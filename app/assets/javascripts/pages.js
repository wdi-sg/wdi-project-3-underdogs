$(document).on('turbolinks:load', function () {
  //parallax for homepage
  $('.parallax').parallax()
  // mobile responsive sideNav
  $('.button-collapse').sideNav()

  // back to to btn for homepage

  $('#tpBtn').click(function(){
    $("body, html").animate({
    scrollTop: $("body").position().top
},500)
  })

 $('.modal').modal();


})
