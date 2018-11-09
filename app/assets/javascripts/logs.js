// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

function refeed(){
    var i = $('#filter')[0].selectedIndex
    console.log($('#filter')[0].options[i].value)
    var xhr= new XMLHttpRequest();
    xhr.open("GET", "/login" );
    xhr.send();
}

