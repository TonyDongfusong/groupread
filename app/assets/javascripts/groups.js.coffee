# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $("#more").addClass("invisible")

  $("#show_more_toggle").click ->
    if("显示全部" == $(this).text())
      $(this).text("收起")
      $("#more").removeClass("invisible")
    else
      $(this).text("显示全部")
      $("#more").addClass("invisible")
