!function ($) {
  $(function(){
    window.prettyPrint && prettyPrint();
    var $window = $(window)

    // side bar
    $('.bs-docs-sidenav').affix({
      offset: {
        top: function () { return $window.width() <= 980 ? 290 : 210 }
      , bottom: 270
      }
    })
  })
}(window.jQuery)

$(document).ready(function() {
    var pathname = window.location.pathname;

    $("#navlist li").each(function(index) {
      var href = $(this).find("a").attr("href");
      if (href != "/" && pathname.toUpperCase().indexOf(href.toUpperCase()) != -1) {
        $(this).addClass("active");
      }
    });

    if ($("li.active").length == 0)
      $("li#navindex").addClass("active");
});