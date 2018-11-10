// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

// 未実装
function refeed(){
    var i = $('#filter')[0].selectedIndex;
    var filter = $('#filter')[0].options[i].value;
    console.log(filter)
    $.ajax({
      async:        true,
      type:         "GET",
      url:          "/",
      data:         {filter: filter},
      dataType:     'html',
      context:      this,
    //   success:      (event) ->
    //     # debugger
    //     $('#hit_'+_post_id).text(String(event)+' views')
    });
}

