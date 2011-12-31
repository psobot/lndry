# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  window.scrollTo(0,1)
  $('.busy .time').each (i, e) ->
    done = new Date($(e).data('time'))
    $(e).data('interval', setInterval(->
      if done < new Date()
        window.location.reload()
      words = done.untilInWords()
      $(e).html words
    , 5000))
