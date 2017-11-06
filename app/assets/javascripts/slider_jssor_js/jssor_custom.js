$(document).on('turbolinks:load', function(){
  jssor_1_slider_init = function() {
    var jssor_1_options = {
      $AutoPlay: 1,
      $SlideHeight: 240,
      $Cols: 2,
      $ArrowNavigatorOptions: {
        $Class: $JssorArrowNavigator$
      },
      $BulletNavigatorOptions: {
        $Class: $JssorBulletNavigator$
      }
    };

    var jssor_1_slider = new $JssorSlider$("jssor_1", jssor_1_options);

    function ScaleSlider() {
      var containerElement = jssor_1_slider.$Elmt.parentNode;
      var containerWidth = containerElement.clientWidth;

      if (containerWidth) {
        jssor_1_slider.$ScaleWidth(containerWidth - 30);
      }
      else {
        window.setTimeout(ScaleSlider, 10);
      }
    }

    ScaleSlider();

    $Jssor$.$AddEvent(window, "load", ScaleSlider);
    $Jssor$.$AddEvent(window, "resize", ScaleSlider);
    $Jssor$.$AddEvent(window, "orientationchange", ScaleSlider);
  };

  jssor_1_slider_init();
});
