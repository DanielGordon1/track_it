window.i = true
$(window).on('scroll', function(e) {
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
})
