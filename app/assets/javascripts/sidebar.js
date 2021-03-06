var sidebarBox = document.querySelector('#box'),
sidebarBtn = document.querySelector('#btn'),
pageWrapper = document.querySelector('#page-wrapper');

sidebarBtn.addEventListener('click', function(event) {
  sidebarBtn.classList.toggle('active');
  sidebarBox.classList.toggle('active');
});

window.addEventListener('keydown', function(event) {
  if (sidebarBox.classList.contains('active') && event.keyCode === 27) {
    sidebarBtn.classList.remove('active');
    sidebarBox.classList.remove('active');
  }
});