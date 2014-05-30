$(document).on "page:change", ->
  input = $("#add-recipients-input")
  suggestions = $("#recipient-suggestions")

  updateSuggestions = (text) ->
    $.ajax
      type: 'GET'
      url: input.data('suggestion-url')
      data:
        text: text
      success: (data) ->
        suggestions.html(data)
        suggestions.find(".add-recipient-button").click ->
          recipients = $(this).data("recipients")
          $("#recipients").append(recipients)
          false

  input.on "input", ->
    updateSuggestions(input.val())

