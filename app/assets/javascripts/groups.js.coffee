# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

togglize = (content_selector, toggle_selector, collapse_text) ->
  $(content_selector).addClass("invisible")

  $(toggle_selector).click ->
    if(collapse_text == $(this).text())
      $(this).text("收起")
      $(content_selector).removeClass("invisible")
    else
      $(this).text(collapse_text)
      $(content_selector).addClass("invisible")

$(document).ready ->
  togglize("#more_books", "#show_more_books_toggle", "显示全部")
  $(".book-read-users").each ->
    togglize($(this).find(".read_users")[0], $(this).find(".show_read_users_toggle")[0], "点此查看谁读过")