# We need to instantiate the app here
define ['jquery', 'jqm', 'backbone','marionette' ], ($, jqm, Backbone, Marionette) ->  

	#$.support.cors = true
	#$.mobile.allowCrossDomainPages = true

	Meshable = new Backbone.Marionette.Application()
	
	Meshable.rooturl = "http://devbuildinglynx.apphb.com"

	Meshable.addRegions
		loginRegion: "#login"
		mainRegion: "#mainR"
		searchRegion: "#searchR"
		menuRegion: "#menuR"
	
		
	#$(document).on "click", "#menu-btn", ->
  		#Meshable.vent.trigger "click:menu"

	
	$(document).on "click", "#back-btn", ->
  		window.history.back()
	
	$(document).bind('pagechange', ->
		$('.ui-page-active .ui-listview').listview('refresh')
		$('.ui-page-active :jqmData(role=content)').trigger('create')
		
		)

	
	
	Meshable.on "initialize:after", (options) ->
		$.mobile.ajaxEnabled = false
		$.mobile.linkBindingEnabled = false
		$.mobile.hashListeningEnabled = false
		$.mobile.pushStateEnabled = false
		$.mobile.loader.prototype.options.text = "loading"
		$.mobile.loader.prototype.options.textVisible = false
		$.mobile.loader.prototype.options.theme = "a"
		$.mobile.loader.prototype.options.html = ""
		
		#$("div[data-role=\"page\"]").live "pagehide", (event, ui) ->
		#$(event.currentTarget).remove()
		
		Backbone.history.start
			root: window.location.protocol + "//" + window.location.host

	Meshable.chooseLight = (light) -> 
		if light == "green"
			return "https://s3.amazonaws.com/LynxMVC4-Bucket/green-light.png"
		else if light == "yellow" 
			return "https://s3.amazonaws.com/LynxMVC4-Bucket/yellow-light.png"
		else if light == "red"
			return "https://s3.amazonaws.com/LynxMVC4-Bucket/red-light.png"
		else 
			return "https://s3.amazonaws.com/LynxMVC4-Bucket/no-light.png"

	return Meshable