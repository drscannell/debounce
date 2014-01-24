
# Based on JavaScript by John Hann
# http://unscriptable.com/2009/03/20/debouncing-javascript-methods/

class DebounceTest
	constructor: ->
		@resultSlowEl = (document.querySelectorAll '.js-sidebar-text-slow')[0]
		@resultFastEl = (document.querySelectorAll '.js-sidebar-text-fast')[0]
		@textInputsSlow = document.querySelectorAll '.js-text-input-slow'
		for textInput in @textInputsSlow
			textInput.addEventListener 'focus', @handleFocusSlow, false
		@textInputsFast = document.querySelectorAll '.js-text-input-fast'
		for textInput in @textInputsFast
			textInput.addEventListener 'focus', @handleFocusFast, false

	reportValueSlow: (val) ->
		@resultSlowEl.innerHTML = val

	reportValueFast: (val) ->
		@resultFastEl.innerHTML = val

	handleFocusSlow: (event) =>
		@debounce 2000, false, =>
			@reportValueSlow event.target.value

	handleFocusFast: (event) =>
		@debounce 500, false, =>
			@reportValueFast event.target.value

	# John Hann's debounce technique, modified to
	# employ callback style
	debounce: (threshold, execAsap, callback) =>
		@debounceTimeout ?= {}
		if @debounceTimeout[callback]
			clearTimeout @debounceTimeout[callback]
		else if execAsap
			callback()
		@debounceTimeout[callback] = setTimeout callback, threshold

window.addEventListener 'load', ->
	debounceTest = new DebounceTest()
, false
