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
//= require jquery3
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require popper
//= require bootstrap
//= require trix
//= require_tree .

document.addEventListener('turbolinks:load', function() {

    $(function() {
        if($('#response_type_comment').is(':checked')) {
            $('.input.string.optional.response_title').hide();
            $('.input.radio_buttons.optional.response_confidence').hide();
        }
    });

    $('input[type=radio]').on("change", function(){
        if($(this).prop('id') == "response_type_comment") {
            $('#response_title').hide();
            $('#confidence_fields').hide();
        }
        else if($(this).prop('id') == "response_type_insight"){
            $('#response_title').show();
            $('#confidence_fields').show();
        }
    });

    $(function () {
      $('[data-toggle="tooltip"]').tooltip()
    })

});
