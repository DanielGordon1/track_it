$('#ti').on('click', '.modal-show', function(e){
  $('.modal-show-container').stopPropagation();
})


// $('#ti').click(function(event) {
//     event.stopPropagation();
//     $('.modal-show').modal('show');
//     console.log('le show')
// });

$(document).on('click', '.modal-show-container', function(){
  $('.modal-show-container').removeClass('is-active')
  $('.modal-show').html('')
  window.history.pushState('',"", '/');
})