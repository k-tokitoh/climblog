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
        t = this;

    // 画像ファイル以外の場合は何もしない
    if(file.type.indexOf("image") < 0){
      return false;
    }

    // ファイル読み込みが完了した際のイベント登録
    reader.onload = (function(file) {
      console.log(file);
      return function(e) {
        //既存のプレビューを削除
        $preview.empty();
        .prevewの領域の中にロードした画像を表示するimageタグを追加
        $preview.append($('<img>').attr({
                  src: e.target.result,
                  width: "150px",
                  class: "preview",
                  title: file.name
        // $preview.append($('<canvas>').attr({
        //           src: e.target.result,
        //           width: "150px",
        //           class: "preview",
        //           title: file.name
        //       }));
        // $preview.append($('</canvas>'));
      };
    })(file);

    reader.readAsDataURL(file);
  });
});

