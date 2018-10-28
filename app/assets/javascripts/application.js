// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
//= require jquery
//= require bxslider

$(document).on('turbolinks:load',function(){
  // 画像の横スライド表示
  $('.bxslider').bxSlider({
      pager: false,
  });
  
  var menuBottom;
  
  // ナビバーのスクロール後上部固定
  $(window).on('scroll',function(){     
      menuBottom = $('#menu').height();
      if($(window).scrollTop() > menuBottom){
          $('#menu').addClass('fixed');   
      }
      else{
          $('#menu').removeClass('fixed');   
      }
  });
   
  $(window).trigger('scroll');
  
  // フォーム画面での画像のプレヴュー表示
  $('form').on('change', 'input[type="file"]', function(e) {
    var file = e.target.files[0],
        reader = new FileReader(),
        $preview = $("#preview");
        
    // 画像ファイル以外の場合は何もしない
    if(file.type.indexOf("image") < 0){
      return false;
    }

    // ファイル読み込みが完了した際のイベント登録
    reader.onload = (function(file) {
      return function(e) {
        //既存のプレビューを削除
        $preview.empty();

        // canvasのサイズを設定
        var canvas_width;
        if (window.parent.screen.width < 400){
          canvas_width = window.parent.screen.width; 
        } else {
          canvas_width = 400;
        }

        // canvas要素を追加
        $preview.append($('<canvas>').attr({
          id: 'canvas',
          width: canvas_width 
        }));
        
        var canvas = document.getElementById('canvas');
        var context = canvas.getContext('2d');
        var img = new Image();
        
        // 画像のソースを取得
        img.src = e.target.result;
        
        // 画像のロードが終わってから以下の処理をする
        img.addEventListener("load", function() {
          var img_width = canvas_width;
          var img_height = img_width*img.height/img.width;
          $('#canvas').attr({
            height: img_height
          });
          
          // 画像を描画する
          context.drawImage(img, 0, 0, img_width, img_height);
          
          // 画像データを取得する
          var color_image = context.getImageData(0, 0, canvas.width, canvas.height);
          
          // 白黒に変換する
          console.log(color_image);
          // console.log(color_image.data);
          // var toString = Object.prototype.toString

          // console.log(toString.call(color_image.data));
          
          // console.log(color_image.data).class;
          mono_image = new ImageData(
            new Uint8ClampedArray(color_image.data),
            color_image.width,
            color_image.height
          );
          // console.log(color)
          for (var i = 0; i < mono_image.data.length; i+=4) {
            var g = mono_image.data[i] * 0.2126 + mono_image.data[i+1] * 0.7152 + mono_image.data[i+2] * 0.0722;
            mono_image.data[i] = mono_image.data[i+1] = mono_image.data[i+2] = g;
            // d[i+3]に格納されたα値は変更しない
          }
          
          // 計算結果でCanvasの表示内容を更新する。
          // color_image.data = mono
          context.putImageData(mono_image, 0, 0);
          
          // マウスがクリックされている/いないという状態を取得する
          var mousedown_flag = false;
          $('#canvas').on('mousedown', function(){
            mousedown_flag = true;
          });
          $('#canvas').on('mouseup', function(){
            mousedown_flag = false;
          });
          
          // マウスの位置情報を取得する
          $('#canvas').on('mousemove',function(e){
            console.log(e.pageX, e.pageY, mousedown_flag)
          });
          
          
          
        }, false);
        
      }})(file);

    reader.readAsDataURL(file);
  });
});

