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

  function showCategoryMenu() {
    var categoryId = getParameterByName("category_id");
    if (categoryId) {
      var parentId = $("#parent-" + categoryId).val();
      var grandParentId = $("#parent-" + parentId).val();

      $("#group-" + grandParentId).prop('checked', true);
      $("#sub-group-" + parentId).prop('checked', true);
    }
  }

  showCategoryMenu();
});
