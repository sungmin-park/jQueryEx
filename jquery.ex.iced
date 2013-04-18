$.fn.formify = ->
  @click ->
    data = $(@).data()
    if data.confirm
      if not confirm data.confirm
        return no
    form = $('<form>').attr('method', 'post').attr('action', @href)
    form.submit()
    # prevent to handle click event
    return no

await $ defer()

$('.formify').formify()
