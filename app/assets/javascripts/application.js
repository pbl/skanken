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
	
	var $rows = $('#worker_table tbody .worker_row');
	$(".activities_filter").on('click', function(e){
		var val = $(this).text().toLowerCase();
		if(val !== 'show all'){
			// console.log("clicked value: " + val)
			$rows.show().filter(function() {
		    var text = $(this).find("#members_list_work").text().replace(/\s+/g, ' ').toLowerCase();
		    return !~text.indexOf(val);
	    }).hide();
		} else{
			$rows.show();
		}
	});

});

function show_worker(show_url){
	window.open(show_url, "_self");
}


function formActionValue(id, type){
	// console.log("id:" + id)
	// console.log("type:" + type)
	// console.log("form" + $('#modal_form_' + type).find('form'))
	$('#modal_form_' + type).find('form').attr('action', 'members/' + id + '/' + type);	
}

// function addHTMLToForm(member_id, type){
// 	var $form = $("#add_" + type + "_form" + member_id).html();
// 	$('#modal_form').empty();
// 	$('#modal_form').append($form);
// }