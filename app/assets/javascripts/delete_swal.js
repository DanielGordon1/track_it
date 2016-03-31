$("[data-behavior='delete']").on("click", function(e) {
  e.preventDefault();

  var that = $(this)
  var path = $(this).data("path");

  swal({
    title: "Are you sure?",
    text: "You will not be able to recover this track!",
    showCancelButton: true,
    confirmButtonColor: "#DD6B55",
    confirmButtonText: "Yes, delete that awful track!",
    cancelButtonText: "No, cancel please!",
    closeOnConfirm: false,
    closeOnCancel: false },
    function(isConfirm){
      if (isConfirm) {
        that.parent().parent().parent().fadeOut()
        swal("Deleted!", "Your awful track has been deleted.", "success");
        $.ajax({
          url: path,
          method: "DELETE",
          success: function() {
          }
        });
      } else {
        swal("Cancelled", "Your track is safe :)", "error");
      }
    });
});
