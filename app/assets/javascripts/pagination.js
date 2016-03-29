$(document).ready(function(){
  window.i = true
  $(window).on('scroll', function(e) {
    handlePagination()
  })

  handlePagination()

  function handlePagination() {
    setTimeout(function(){
      if($('.pagination-helper').visible(true)) {
        if(window.i) {
          var pageCount = $('.pagination-helper').data('page');
          $.get('/tracks?page=' + pageCount)
          window.i = false;
          setTimeout(function() {
            i = true
          }, 1500)
        }
      }
    }, 1000) // add a little delay for the style during the demo
  }
})