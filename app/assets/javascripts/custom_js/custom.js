$(document).on('turbolinks:load', function(){
  function getParameterByName(name, url) {
    if (!url) url = window.location.href;
    name = name.replace(/[\[\]]/g, "\\$&");
    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, " "));
  }

  function removeParam(key, sourceURL) {
    var rtn = sourceURL.split("?")[0],
      param,
      params_arr = [],
      queryString = (sourceURL.indexOf("?") !== -1) ? sourceURL.split("?")[1] : "";
    if (queryString !== "") {
      params_arr = queryString.split("&");
      for (var i = params_arr.length - 1; i >= 0; i -= 1) {
          param = params_arr[i].split("=")[0];
          if (param === key) {
              params_arr.splice(i, 1);
          }
      }
      rtn = rtn + "?" + params_arr.join("&");
    }
    return rtn;
  }

  $(".woocommerce-orderby").on("change", function() {
    var sortParam = $(this).val() == "default" ? "" : ("&sort_by=" + $(this).val());
    var url = removeParam("sort_by", location.href) + sortParam;
    location.href = url;
  });

  function sortByPrice() {
    var url = removeParam("min_price", removeParam("max_price", location.href));
    var minPriceParam = $("#min_price").val() ? ("&min_price=" + $("#min_price").val()) : "";
    var maxPriceParam = $("#max_price").val() ? ("&max_price=" + $("#max_price").val()) : "";
    location.href  = url + minPriceParam + maxPriceParam;
  }

  $("#min_price").val(getParameterByName("min_price"));
  $("#max_price").val(getParameterByName("max_price"));

  $('#min_price, #max_price').focusout(function() {
    sortByPrice();
  });

  $("#min_price, #max_price").on('keyup', function (e) {
    if (e.keyCode == 13) {
      sortByPrice();
    }
  });

  $("#min_price, #max_price").keydown(function (e) {
    // Allow: backspace, delete, tab, escape, enter and .
    if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) !== -1 ||
         // Allow: Ctrl/cmd+A
        (e.keyCode == 65 && (e.ctrlKey === true || e.metaKey === true)) ||
         // Allow: Ctrl/cmd+C
        (e.keyCode == 67 && (e.ctrlKey === true || e.metaKey === true)) ||
         // Allow: Ctrl/cmd+X
        (e.keyCode == 88 && (e.ctrlKey === true || e.metaKey === true)) ||
         // Allow: home, end, left, right
        (e.keyCode >= 35 && e.keyCode <= 39)) {
             // let it happen, don't do anything
             return;
    }
    // Ensure that it is a number and stop the keypress
    if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
        e.preventDefault();
    }
  });
});
