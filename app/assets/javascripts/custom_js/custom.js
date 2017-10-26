$(function() {
  $(".woocommerce-orderby").on("change", function() {
    var url = $(this).val();
    var trueParam = url.substring(url.length - 15, url.length);
    var tempUrl = url;
    while (tempUrl.indexOf("&sort_by") != -1) {
      var indexSortParam = url.indexOf("&sort_by");
      tempUrl = tempUrl.replace(tempUrl.substring(indexSortParam, indexSortParam + 15), "");
    }
    if (trueParam == "&sort_by=defaul") {
      trueParam = "";
    }
    location.href = tempUrl + trueParam;
  });
});
