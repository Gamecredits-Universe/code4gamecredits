$(document).on "page:change", ->
  root = $("#add-recipient-panels")
  recipients = $("#recipients")

  root.find("form").submit ->
    form = $(this)
    form.find(".alert").remove()
    panel = form.closest(".panel")
    $.ajax
      type: 'GET'
      url: form.attr("action")
      data: form.serialize()
      success: (data) ->
        if data.error
          form.append($("<div>").addClass("alert alert-danger").text(data.error))
        else
          recipients.append(data.result)
          form[0].reset()
        false
      error: ->
        form.append($("<div>").addClass("alert alert-danger").text("An error occured."))
    false
