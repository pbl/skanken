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
	  console.log(val);
    $rows.show().filter(function() {
      var text = $(this).find("td:first-child").text().replace(/\s+/g, ' ').toLowerCase();
      return !~text.indexOf(val);
	    }).hide();
	});

  $('#new_worker_button').on('click', function(e){
		e.preventDefault();
		$('#new_worker').css("display", "block");
	});

	$('#cancel_worker_button').on('click', function(e){
		e.preventDefault();
		$('#new_worker').css("display", "none");
	});
});

function addHTMLToForm(member_id, modal_id, type){
	var $form = $("#add_" + type + "_form" + member_id).html();
	$('#' + modal_id).empty();
	$('#' + modal_id).append($form);
}