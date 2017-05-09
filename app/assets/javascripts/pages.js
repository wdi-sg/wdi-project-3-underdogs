$(document).on('turbolinks:load', function () {
  $('.parallax').parallax()
  $('.button-collapse').sideNav()
  $('#tpBtn').click(function(){
    $("body, html").animate({
    scrollTop: $("body").position().top
},500)
  })
})
