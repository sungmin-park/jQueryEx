$.fn.formify = ->
  @click ->
    data = $(@).data()
    if data.confirm
      if not confirm data.confirm
        return
    form = $('<form>').attr('method', 'post').attr('action', @href)
    form.submit()

await $ defer()

$('.formify').formify()
