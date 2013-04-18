$ = jQuery

if window.ko
	ko.bindingHandlers.youtube = 
		update: (element, valueAccessor) ->
			id = ko.utils.unwrapObservable valueAccessor()
			$(element).youtube id: id

class $.YouTube
	_page: "https://www.youtube.com"

	constructor: (@id) ->
		@url = "#{@_page}/watch?#{$.param v: @id}"
		@thumbnail = "https://img.youtube.com/vi/#{@id}/0.jpg"
		@embed = "#{@_page}/embed/#{@id}"

$.fn.youtube = ({id}) ->
	yt = new $.YouTube id
	@empty().append $('<iframe>')
		.attr('src', yt.embed).css('width', '100%').css('height', '100%')

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
