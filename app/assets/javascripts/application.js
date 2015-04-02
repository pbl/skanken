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

		$('.worker_column').on('click', function(e){
			e.preventDefault();
			var self = this;

			var $workerRow = $(this).parent();
			var id = $workerRow.attr('id');
			var $workerContacted = $("#contacted" + id);
			var $workerWorked = $("#worked" + id);
			var $workerInfo = $("#info" + id);

			if($workerContacted.css("display") === 'none'){

				$workerRow.addClass("info");

				$workerContacted.css("display", "inline");
				$workerContacted.before("<h4 class='workerTableHeader'>Contacted</h4>");	

				$workerWorked.css("display", "inline");
				$workerWorked.before("<h4 class='workerTableHeader'>Worked</h4>");

				
				$workerInfo.css("display", "inline");
				$workerRow.after($workerInfo);
			} else{
				$workerRow.removeClass("info");
				$workerContacted.css("display", "none");
				$workerWorked.css("display", "none");
				$workerInfo.css("display", "none");
				$('.workerTableHeader').remove();
			}
			

			// alert($workerRow)
			// var id = $workerRow.attr('id');
			// var $workerAdditionalInfo = $("#info" + id);
			// var $personContacted = $("#contacted" + id);
			// var personWorked = $("#worked" + id);

			// if($workerAdditionalInfo.css("display") === 'none'){
			// 	$workerRow.addClass("info");
			// 	$workerAdditionalInfo.css("display", "block");
			// 	$personContacted.css("display", "block");
			// 	// personWorked.css("display", "block");

			// 	$person.after($workerAdditionalInfo);
			// } else{
			// 	$workerRow.removeClass("info");
			// 	$workerAdditionalInfo.css("display", "none");
			// 	$personContacted.css("display", "none");
			// 	// personWorked.css("display", "none");
			// }
		});

});

function showInfo(){

	var id = $(this).attr('id');
	var showId = "#info" + id;
	alert(showId);

	// $('#1').insertAfter('#test')
  // @members[]

  // $('#info1').css("display", "block")
  // var info = $('#info1');
  // $('#1').after(info)

  // alert( $(this).attr('id'));
  // alert( $(this).attr('id'));
}

