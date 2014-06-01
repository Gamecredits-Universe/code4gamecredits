$(document).on "page:change", ->
  input = $("#add-recipients-input")
  suggestions = $("#recipient-suggestions")
  target = $("#recipients")

  timer = null
  request = null
  updateSuggestions = (text) ->
    if timer
      clearTimeout(timer)
      timer = null

    if request
      request.abort()
      request = null

    suggestions.html("<div class=\"loading\">Loading...</div>")

    timer = setTimeout ->
      request = $.ajax
        type: 'GET'
        url: input.data('suggestion-url')
        data:
          text: text
        success: (data) ->
          suggestions.hide().html(data).slideDown("fast")
          suggestions.find(".add-recipient-button").click ->
            recipients = $(this).data("recipients")
            target.append(recipients)
            suggestions.html("")
            input.val("")
            false
        error: ->
          suggestions.html("An error occured.")
    , 200

  input.on "input", ->
    updateSuggestions(input.val())

