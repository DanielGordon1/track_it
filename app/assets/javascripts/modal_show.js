$(document).on('click', '.modal-show', function(e){
  $('.modal-show-container').stopPropagation();
})

$(document).on('click', '.modal-show-container', function(){
  $('.modal-show-container').removeClass('is-active')
  $('.modal-show').html('')
  window.history.pushState('',"", '/');
})
