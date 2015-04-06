// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$( document ).ready(function() {

	// Filter function for workers
	var $rows = $('#worker_table tbody .member_row');
	$('#search_worker').keyup(function() {
    var val = $.trim($(this).val()).replace(/ +/g, ' ').toLowerCase();
  	console.log("clicked value: " + val)
    $rows.show().filter(function() {
      var text = $(this).find("td:first-child").text().replace(/\s+/g, ' ').toLowerCase();
      console.log("rows: " + text)
      return !~text.indexOf(val);
    }).hide();
	});

	$(".options_filter").on('click', function(e){
		var val = $(this).text().toLowerCase();
		if(val !== 'show all'){
			console.log("clicked value: " + val)
			$rows.show().filter(function() {
		    var text = $(this).find("#members_list_work").text().replace(/\s+/g, ' ').toLowerCase();
		    console.log("rows: "+ text);
		    return !~text.indexOf(val);
	    }).hide();
		} else{
			$rows.show();
		}
	});

	$('#members_list_contacted').on('click', function(){

	});

});

function sortTable(){
  var tbl = document.getElementById("worker_table").tBodies[0];
  var store = [];
  for(var i=0, len = tbl.rows.length; i<len; i++){
    var row = tbl.rows[i];
    if(row.classList.contains("member_row")) {
    	info_rows = [];
    	var k = 1;
  		while(!row.classList.contains("member_row")){
  			var row = tbl.rows[i+k];
  			info_rows.push(row);
  			k = k+1;
  		}
		    var sortnr = parseFloat(row.cells[3].textContent || row.cells[3].innerText);
		    if(!isNaN(sortnr)){
		    	store.push([sortnr, row, info_rows]);
		    } 
		}
  }
  store.sort(function(x,y){
    return x[0] - y[0];
  });

  for(var i=0, len=store.length; i<len; i++){
    tbl.appendChild(store[i][1]);
  }
  store = null;
}

function addHTMLToForm(member_id, type){
	var $form = $("#add_" + type + "_form" + member_id).html();
	$('#modal_form').empty();
	$('#modal_form').append($form);
}