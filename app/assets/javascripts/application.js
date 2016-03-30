//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require comments
//= require sidebar
//= require tabs
//= require modal_show
//= require track_item
//= require pagination
//= require visibility.min.js
//= require alert
//= require customplayer

//Override the default confirm dialog by rails
// $.rails.allowAction = function(link){
//   if (link.data("confirm") == undefined){
//     return true;
//   }
//   $.rails.showConfirmationDialog(link);
//   return false;
// }
// //User click confirm button
// $.rails.confirmed = function(link){
//   link.data("confirm", null);
//   link.trigger("click.rails");
// }
// //Display the confirmation dialog
// $.rails.showConfirmationDialog = function(link){
//   var message = link.data("confirm");
//   $.fn.SimpleModal({
//     model: "modal",
//     title: "Are you sure you want to delete this track?",
//     contents: message
//   }).addButton("Confirm", "button alert", function(){
//     $.rails.confirmed(link);
//     this.hideModal();
//   }).addButton("Cancel", "button secondary").showModal();
// }
