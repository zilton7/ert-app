// Hide notice
$(document).ready(() => {
  setTimeout(function () {
    $("#notice_wrapper").fadeOut("slow", function () {
      $(this).remove();
    });
  }, 3500);
});
