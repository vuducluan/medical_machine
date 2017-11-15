$(document).on('turbolinks:load', function(){
  var selectedCategory = {};
  $("#upload-product-image-1, #upload-product-image-2").change(function() {
    var imgId = $(this)[0].id.replace("upload-product-image-", "");
    var input = this;
    var url = $(this).val();
    var ext = url.substring(url.lastIndexOf('.') + 1).toLowerCase();
    if (input.files && input.files[0] && (ext == "png" || ext == "jpeg" || ext == "jpg")) {
      var reader = new FileReader();
      reader.onload = function (e) {
        $('#product-new .preview-product-image-'+imgId).attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    } else {
      $('#product-new .preview-product-image-'+imgId).attr('src', '/preview_no_image.jpg');
    }
  });

  $('#dataTables-product').DataTable({
    responsive: true
  });

  $(".sub-category-select").change(function() {
    var categoryId = $(this)[0].id.replace("select", "");
    var subCategoryName = getSelectedText($(this)[0].id);
    var subCategoryId = $(this)[0].value;
    var childNodes = $(".sub-category"+categoryId)[0].children;
    if (childNodes.length > 0) {
      for (var i = 0; i < childNodes.length; ++i) {
        var item = childNodes[i];
        if (!item.classList.contains("hidden")) {
          item.classList.add("hidden");
        };
      }
      $("#select"+subCategoryId)[0].classList.remove("hidden");
    }
    setSelectedCategoryName(categoryId, subCategoryName, "");
  });

  $(".sub-sub-category-select").change(function() {
    var subSubCategoryId = getSelectedText($(this)[0].id);
    var parentSelect = $(this).parent()[0].previousElementSibling.children[0];
    var categoryId = parentSelect.id.replace("select", "");
    var subCategoryId = getSelectedText(parentSelect.id);
    setSelectedCategoryName(categoryId, subCategoryId, subSubCategoryId);
  });

  function getSelectedCategoryName() {
    selectedName = [];
    for (var key in selectedCategory){
      if (selectedCategory[key][1] != "") {
        selectedName.push(selectedCategory[key][1]);
      } else {
        selectedName.push(selectedCategory[key][0]);
      }
    }
    return selectedName.join();
  }

  function setSelectedCategoryName(g, p, c) {
    selectedCategory[g] = [p, c];
  }

  function getSelectedText(elementId) {
    var elt = document.getElementById(elementId);
    if (elt.selectedIndex == -1)
      return null;
    return elt.options[elt.selectedIndex].text;
  }

  $("#add-param-product").click(function(){
    var row = '<tr>' +
                '<td><input type="text" class="form-control"/></td>' +
                '<td><input type="text" class="form-control"/></td>' +
                '<td><button type="button" class="btn btn-danger delete-param-product">Xóa</button></td>' +
              '</tr>'
    $("#product-parameter-table").append(row);
  });

  $("#product-parameter-table").on('click','.delete-param-product',function(){
    $(this).parent().parent()[0].remove();
  });

  $("#confirm-param-product").click(function() {
    var isParamTable = $("#product_is_parameter_table")[0].value;
    if (isParamTable == "true") {
      var oTable = $("#product-parameter-table")[0];
      var rowLength = oTable.rows.length;
      var parameter = [];
      for (i = 1; i < rowLength; i++){
        var oCells = oTable.rows.item(i).cells;
        var key = oCells.item(0).children[0].value;
        var value = oCells.item(1).children[0].value;
        if (key != "") {
          parameter.push(key+":"+value);
        }
      }
      $("#product_parameter").val(parameter.join());
    }
    $(".product-parameter-span")[0].innerHTML = $("#product_parameter").val();
  });

  $("#comfirm-category-product").click(function() {
    $(".selected-category-product")[0].innerHTML = getSelectedCategoryName();
  })

  $("#product_is_parameter_table").change(function() {
    getParameterProduct();
  });

  function getParameterProduct() {
    var isParamTable = $("#product_is_parameter_table")[0].value;
    if (isParamTable == "true") {
      $("#product-parameter-table-div")[0].style.display = 'block';
      $("#product_parameter")[0].classList.add("hidden");
    } else {
      $("#product-parameter-table-div")[0].style.display = 'none';
      $("#product_parameter")[0].classList.remove("hidden");
    };
  }

  getParameterProduct();
});
