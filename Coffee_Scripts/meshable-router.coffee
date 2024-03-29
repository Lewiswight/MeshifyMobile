define ['jquery','jqm', 'backbone','underscore','marionette', 'Meshable', 'Events', 'login', 'dashboard', 'search'], ($, jqm, Backbone, _, Marionette, Meshable, Events, login, dashboard, search) ->  




	
	
	Routing = Backbone.Router.extend
		routes:
			"gateway/:macaddress": "gateway"
			"": "home"
			"dashboard": "dashboard"
			"menu": "menu"
			"back": "back"
			"popupPanel": "popupPanel"
			"menu_back_btn": "menu_back_btn"
			"search": "search"
			"gateways": "gateways"
			
			
		
		
		gateway: (macaddress) ->
			Meshable.currentMac = macaddress
			Meshable.vent.trigger "goto:nodes", macaddress
				
		gateways: ->
			Meshable.vent.trigger "goto:gateways"	
				
		search: ->
			Meshable.vent.trigger "goto:search"
			
			
		menu_back_btn: ->
			$("#popupPanel").popup("close")
			
			
		popupPanel: ->
			#Meshable.router.navigate "#&ui-state=dialog", trigger: true
			$("#popupPanel").popup("open")
			
			
		back: ->
			
			window.history.back()
		
			#Meshable.vent.trigger "go:back"
			
			
		home: ->
			$.mobile.changePage $('#splash'), changeHash: false,  transition: 'none', showLoadMsg: false
			Meshable.loginRegion.show(login)
			$("#password-input").hide()
			@changePage login, false
			
		
		
		dashboard: ->
			#Meshable.vent.trigger "goto:menu"
			Meshable.vent.trigger "goto:dashboard"
			
			
			

		menu: ->
			
			$("#popupPanel").on popupbeforeposition: ->
			h = $(window).height()
			$("#popupPanel").css "height", h
				
			$("#popupPanel").bind popupafterclose:  ->
				Meshable.vent.trigger "menu:close"
	
			$("#popupPanel").popup("open")
		
			$("#menu_back_btn").tap ->
				$("#popupPanel").popup("close")
	
				
			$("#menu_search_btn").tap ->
				$("#popupPanel").popup("close")
				
				window.setTimeout (->
					Meshable.vent.trigger "open:search"
				), 600
			
			#Meshable.vent.trigger "click:menu"
		
				
		
				
				
					
			
				
			
		
			
				
		changePage: (page, direction) ->
			$(page.el).attr "data-role", "page"
			$(page.el).attr "data-theme", "a"
		
			
			trans = "slide"
			
			if @firstPage
				trans = "none"
				@firstPage = false
			#$.mobile.loading "show",
			#	theme: 'e'
			$.mobile.changePage $(page.el), changeHash: true, reverse: direction, transition: "none"

	
	
		initialize: ->
			@firstPage = true
			@firstDash = true
		
			
			
			
			
			#Meshable.loginRegion.show(home)
		#	data = home.render()
		
			#@changePage home
	    
			# Handle back button throughout the application
			#$(".back").live "click", (event) ->
			 # window.history.back()
			  #false
			
			
	
			###
		changePage: (pagey) ->
			
			$('#home_page').attr "data-role", "page"
			#page.render()
			#this adds the code to the body
		#	$("#login_page").append $(page.el)
			#Meshable.loginRegion.show(home)
			transition = $.mobile.defaultPageTransition
		
		# We don't want to slide the first page
			if @firstPage
			  transition = "none"
			  @firstPage = false
			test = $('#home_page')
	#		test.page()
			$("#click").click ->
				#rou.navigate "page_99", trigger : true
				$.mobile.changePage $('#home_page'), changeHash: true, transition: transition, reverse: true
#			$.mobile.changePage $.mobile.activePage#, changeHash: false, transition: transition, reverse: true
###
	
			  
			  
	
		


	
	
	
	###
	Routing = Backbone.Marionette.AppRouter.extend
		
			
		
		routes : 
			"authorized" : "appStart"
			"help" : "help"
		
		help: -> 
			alert "help!"
		
		appStart: -> 
			#logged in user 
			Events.trigger "router:appStart"

		try2: ->
			alert "hi"
		
		try1: (data) ->
			Events.trigger "start:angrycats"

				
 
			Meshable.vent.trigger "routing:started"
		
			###
	

	return Routing
