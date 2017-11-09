$(document).on('turbolinks:load', function(){
  $(".confirm-field-save").click(function() {
    var fieldId = $(this)[0].name.replace("update-field", "");
    var fieldName = $("#field-name"+fieldId).val();
    var fieldOrder = $("#field-order"+fieldId).val();
    $("#field-name"+fieldId).addClass("hidden");
    $("#field-order"+fieldId).addClass("hidden");
    $.ajax({
      data: {
        name: fieldName,
        menu_order: fieldOrder
      },
      type: "PATCH",
      url: "fields/" + fieldId
    }).done(function(response) {
      $("#field-table .alert-success").removeClass("hidden");
      $("#field-table .alert-danger").addClass("hidden");
      $("#p-field-name"+fieldId).removeClass("hidden");
      $("#p-field-order"+fieldId).removeClass("hidden");
      $("#p-field-name"+fieldId)[0].innerHTML = response.name;
      $("#p-field-order"+fieldId)[0].innerHTML = response.menu_order;
    }).fail(function(errors) {
      $("#field-table .alert-danger").removeClass("hidden");
      $("#field-table .alert-success").addClass("hidden");
    });
  });

  $(".td-field-name, .td-field-order").click(function() {
    var fieldId = $(this)[0].parentElement.id.replace("field", "");
    var inputClass = $(this)[0].className.replace("td-", "");
    $("#p-"+inputClass+fieldId).addClass("hidden");


    searchInput = $("#"+inputClass+fieldId)
    searchInput.removeClass("hidden");
    var strLength = $("#"+inputClass+fieldId).val().length * 2;

    searchInput.focus();
    searchInput[0].setSelectionRange(strLength, strLength);
  });
});
