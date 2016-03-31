$(document).ready(function(){
  itsTheOnlyProblem()
});

function itsTheOnlyProblem() {
  var player = SC.Widget($('iframe.sc-widget')[0]);
  var pOffset = $('.player').offset();
  var pWidth = $('.player').width();
  var scrub;
  
  player.bind(SC.Widget.Events.READY, function() {
    setInfo();
    player.play();
  }); //Set info on load

  player.bind(SC.Widget.Events.PLAY, function() {
    console.log('is playing')
    $('.play i').attr('class', 'fa fa-pause')

  })

  player.bind(SC.Widget.Events.PAUSE, function() {
    $('.play i').attr('class', 'fa fa-play')
  })
  
  player.bind(SC.Widget.Events.PLAY_PROGRESS, function(e) {
    if( e.relativePosition < 0.003 ) { setInfo(); }
    //Event listener when track is playing
    $('.position').css('width', ( e.relativePosition*100)+"%");
  });
  
   $('.player').mousemove(function(e){ //Get position of mouse for scrubbing
    scrub = (e.pageX-pOffset.left);
  });

  // pauses on space
  $(document).on('keydown', function(e){
    switch(e.keyCode){
      case 32:
        player.toggle(); 
      break;
    }
  });

  // play/pauses player
  $(".play").click(function () {
      player.play();
  })

  $('.player').click(function(){ //Use the position to seek when clicked
    $('.position').css('width',scrub+"px");
    var seek = player.duration*(scrub/pWidth); 
    
    //Seeking to the start would be a previous?
    if ( seek < player.duration * .05 ) {
      player.prev();
    } else if ( seek > player.duration * .99 ) {
      player.next();
    } else {      
      player.seekTo(seek);
    }
    
  });
  
   function setInfo() {
    player.getCurrentSound(function(song) {
      
        // Soundcloud just borked this api endpoint, hence this hack :/
        var waveformPng =
            song.waveform_url
                .replace('json', 'png')
                .replace('wis', 'w1');
        
        var artworkUrl = song.artwork_url || '';
        
       console.log(song);
      
      $('.waveform').css('background-image', "url('" + waveformPng + "')");    
      
      var info = song.title;
      $('.info').html(info);
      
      player.current = song;
    });
    
    player.getDuration(function(value){
      player.duration = value;
    });

    player.isPaused(function(bool){
      player.getPaused = bool;
    });
  }   
}
