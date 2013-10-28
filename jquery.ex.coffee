$ = jQuery


if window.ko
	ko.bindingHandlers.youtube = 
		update: (element, valueAccessor) ->
			id = ko.utils.unwrapObservable valueAccessor()
			$(element).youtube id: id

	ko.bindingHandlers.facebook_like =
		update: (element, valueAccessor) ->
			fb = ko.utils.unwrapObservable valueAccessor()
			$(element).facebook_like fb


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


$.fn.facebook_like = ({href, show_faces, send}) ->
	send ?= false
	show_faces ?= false
	@each ->
		$(@).empty().append(
			$('<div>')
				.addClass('fb-like')
				.attr('data-show-faces', show_faces)
				.attr('data-send', send)
				.attr('data-href', href)
		)
		# XFBML.parse recive parent dom object, not itself.
		window['FB']?['XFBML'].parse @


$.fn.formify = ->
  @click ->
    data = $(@).data()
    if data['confirm']
      if not confirm data['confirm']
        return no
    form = $('<form>').attr('method', 'post').attr('action', @href)
    form.submit()
    # prevent to handle click event
    return no


$.fn.confirmify = ->
  handler = ->
    if confirm $(@).data()['confirm']
      return yes
    return no
  @each ->
    if $(@).is 'form'
      $(@).submit handler
    else
      $(@).click handler


$.fn.anchorify = ->
  @css 'cursor', 'pointer'
  @each ->
    $(@).click ->
      window.location = $(@).data 'href'
      no

$.fn.replacer = ->
  @click ->
    location.replace $(@).attr 'href'
    no


$.Event.ArrowKeys = [
  $.Event.LEFT, $.Event.UP, $.Event.RIGHT, $.Event.DOWN
] = [37..40]

$.Event::isArrowKey = ->
  @which in $.Event.ArrowKeys

$.Event::toChar = ->
  String.fromCharCode @which


class AjaxError extends Error
  constructor: (@xhr)->
    @message = @xhr.responseText


$.fn.post = (cb) ->
  $.ajax @attr('action'), {
    type: 'POST'
    processData: false,
    contentType: false,
    data: new FormData @[0]
    dataType: 'JSON'
    success: (data) ->
      cb null, data
    error: (xhr, status, error) ->
      cb new AjaxError xhr
  }
  @

$.image = (source, cb) ->
  img = new Image
  img.onload = ->
    cb null, img
    img.onerror = img.onload = null
  img.onerror = (error) ->
    img.onerror = img.onload = null
    cb error
  img.src = source


# streamlinjs

$.getJSON_ = ({url, data}, callback) ->
  $.ajax url, {
    type: 'GET', dataType: 'JSON', data: _.extend {_ts: $.now()}, data
    success: (data) ->
      callback null, data
    error: (xhr, status, error) ->
      callback new AjaxError xhr
  }

$ ->
  $('.formify').formify()
  $('.confirmify').confirmify()
  $('.anchorify').anchorify()
  $('.fb-share').popupWindow? width: 626, height: 346, centerBrowser: 1
  $('.focused').select()
  $('.replacer').replacer()
