# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $('.chzn-search').chosen()

  if $('.pagination').length
    $(window).scroll ->
      url = $('.pagination .next_page').attr('href')
      if url && $(window).scrollTop() > $(document).height() - $(window).height() - 50
        $('.pagination').text("Getting more awesome musicians, Hold The Line!")
        $.getScript(url)
    $(window).scroll()

$(document).ready(ready)
$(document).on('page:load', ready)