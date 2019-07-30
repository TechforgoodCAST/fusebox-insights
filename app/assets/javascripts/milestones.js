// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(function(){
  $('.preset').on('click', function(){
    $('#milestone_title').val($(this).children('h4').html());
    $('#milestone_description').val($(this).children('p').html());
  });
});