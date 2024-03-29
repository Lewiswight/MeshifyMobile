define ['jquery', 'jqm', 'backbone','underscore','marionette', 'Meshable', 'Events'], ($, jqm, Backbone, _, Marionette, Meshable, Events) ->									 
	
	make_collection = ->
		
		
		window.forge.ajax
			url: "http://devbuildinglynx.apphb.com/api/dashboard"
			dataType: "json"
			type: "GET"
			error: (e) -> 
				alert e.content
			success: (data) ->
				
				
				
				nodeCollection = new dashboards
				for model in data
					cModel = new dashboard
					nodeCollection.add cModel.parse(model)
				
				return nodeCollection
				
				
				
		
			###models = JSON.parse """[{"address":"123 Main Ave","channelname":"energy cost","post":"","pre":"$","status":"The status","trafficlight":"green","value":"1232"},{"address":"123 Main Ave","channelname":"energy cost","post":"","pre":"$","status":"The status","trafficlight":"green","value":"1232"},{"address":"123 Main Ave","channelname":"energy cost","post":"","pre":"$","status":"The status","trafficlight":"green","value":"1232"},{"address":"123 Main Ave","channelname":"energy cost","post":"","pre":"$","status":"The status","trafficlight":"green","value":"1232"},{"address":"123 Main Ave","channelname":"energy cost","post":"","pre":"$","status":"The status","trafficlight":"green","value":"1232"},{"address":"123 Main Ave","channelname":"energy cost","post":"","pre":"$","status":"The status","trafficlight":"green","value":"1232"},{"address":"123 Main Ave","channelname":"energy cost","post":"","pre":"$","status":"The status","trafficlight":"green","value":"1232"},{"address":"123 Main Ave","channelname":"energy cost","post":"","pre":"$","status":"The status","trafficlight":"green","value":"1232"},{"address":"123 Main Ave","channelname":"energy cost","post":"","pre":"$","status":"The status","trafficlight":"green","value":"1232"},{"address":"123 Main Ave","channelname":"energy cost","post":"","pre":"$","status":"The status","trafficlight":"green","value":"1232"}]"""
			
			nodeCollection = new dashboards
		 	
			for model in models
				cModel = new dashboard
				nodeCollection.add cModel.parse(model)
			
			return nodeCollection###
	
	gateway = Backbone.Model.extend 
		initialize: -> 
				@set
					trafficlight: "green"		
			defaults: 				 				
				trafficlight: "green" 			
				
		
	gateways = Backbone.Collection.extend
		model: gateway	
	#	url: ->
	#		Meshable.rooturl + "/api/dashboard"
	#	initialize: (dashboards) ->
	#		@fetch()


	gatewayView = Backbone.Marionette.ItemView.extend
		initialize: (gateway) ->
			
			@bindTo @model, "change", @render
			
			
		template: '#gatewayitem-template'
		tagName: 'li'
		className: "list_item"
		id: "gatewayItm"
		
		
		###$("#gatewayItm").attr 
			"data-role": "listview"
			"data-icon": "arrow-r" 
			"data-iconpos": "right" 
			"data-theme": "c" 
			"class": "ui-btn ui-btn-icon-right ui-li-has-arrow ui-li ui-first-child ui-btn-up-c"###
			
			
		
		events:
			"click #gatewayItm": "get_gateway"
			
		get_gateway: ->
			
			window.forge.ajax
			url: "http://devbuildinglynx.apphb.com/api/gateway"
			data:  macaddress: "00409DFF-FF45871E"
			dataType: "json"
			type: "GET"
			error: (e) -> 
				alert "An error occurred while getting node details... sorry!"
			success: (data) =>
				if data.isAuthenticated == false
					alert "auth:logout"
				else if data.length == 0
					alert "No Results"
				else
					alert "you did it, now start debugging"
			
			 
			
			
		
		


	gatewayCompView = Backbone.Marionette.CompositeView.extend
		itemView: gatewayView
		template: "#wrapper_dashboard"
		itemViewContainer: "ul"
		id: "gateway"
		
		
		
		#events: 
			
			#"click #back-btn1": "back"
			#"click #menu_back_btn": "menu_back"

			
		#menu_back: ->
			#$("#popupPanel").popup("close")
		#back: ->
			#window.history.back()
		
		#popmenu: ->
			
			#$("#popupPanel").on popupbeforeposition: ->
				#h = $(window).height()
				#$("#popupPanel").css "height", h

			#$("#popupPanel").popup("open")
			
		
		appendHtml: (collectionView, itemView) ->
			collectionView.$("#dashboard_insert").append(itemView.el) 

	
	
	Meshable.vent.on "goto:gateways", ->
		
		
		window.forge.ajax
			url: "http://devbuildinglynx.apphb.com/api/address"
			#data: { address: searchField, pagenum: 1 }
			dataType: "json"
			type: "GET"
			error: (e) -> 
				alert "An error occurred on search... sorry!"
			success: (data) =>
				if data.isAuthenticated == false
					myvent.trigger "auth:logout"
				else if data.length == 0
					alert "No Results" 
				else
					displayResults data
					
	Meshable.vent.on "search:gateways", (sdata) ->
		
		window.forge.ajax
			url: "http://devbuildinglynx.apphb.com/api/address"
			data: { address: sdata, pagenum: 0 } 
			dataType: "json"
			type: "GET"
			error: (e) -> 
				alert "An error occurred on search... sorry!"
			success: (data) =>
				if data.isAuthenticated == false
					myvent.trigger "auth:logout"
				else if data.length == 0
					alert "No Results" 
				else
					Backbone.history.navigate "search-gateways", replace: false, trigger: false
					displayResults data

	
	
					
	displayResults = (data) ->
		
		nodeCollection = new gateways
		for model in data
			cModel = new gateway
			nodeCollection.add cModel.parse(model)
		gateView = new gatewayCompView
			collection: nodeCollection
	
		
		


			
		Meshable.currentpage = "gateways"
		$.mobile.changePage $('#splash'), changeHash: false,  transition: 'none', showLoadMsg: false  
		Meshable.loginRegion.close()
		Meshable.mainRegion.close()
	
		Meshable.mainRegion.show(gateView)

		#$("#gateway").attr "data-role", "listview"
		#$("#gateway").attr "data-insert", "true" 

	
		changePage gateView, false
					
				
				
				
		
	changePage = (page, direction) ->
			$(page.el).attr "data-role", "page"
			
		
			
			trans = "slide"
			
			if @firstPage
				trans = "none"
				@firstPage = false
			#$.mobile.loading "show",
			#	theme: 'e'
			$.mobile.changePage $(page.el), changeHash: true, reverse: direction, transition: "none"
		
			
	