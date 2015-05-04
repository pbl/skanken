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
  // Jquery datatable code
  $('#worker_table').DataTable( {
    initComplete: function () {
      this.api().columns().every( function () {
        var column = this;
        // only create a filter for the column activities
        if($(column.footer())[0].textContent === "Activities"){
          var select = $('<select><option value=""></option></select>')
            .appendTo( $(column.footer()).empty() )
            .on( 'change', function () {
              var val = $.fn.dataTable.util.escapeRegex(
                $(this).val()
              );

              column
                .search( val ? '^'+val+'$' : '', true, false )
                .draw();
            } );

          var unique_activities = []
          
          column.data().unique().sort().each( function ( d, j ) {
            var activities = d.split("\, ")
            for (var i = 0; i < activities.length; i++) {
              // see if the activity option is already added
              if(unique_activities.indexOf(activities[i]) === -1 ){
                unique_activities.push(activities[i])
              }
            }  
          } );
          for (var i = 0; i < unique_activities.length; i++) {
            select.append( '<option value="'+unique_activities[i]+'">'+unique_activities[i]+'</option>' )
          }
        } else{
          // clear away the datatable footer
          $(column.footer()).empty()
        }
      } );
    }
  } );


  function show_worker(show_url){
    window.open(show_url, "_self");
  }

  function formActionValue(id, type){
    $('#modal_form_' + type).find('form').attr('action', 'members/' + id + '/' + type);
  }
});

