define ['jquery', 'jqm', 'backbone','underscore','marionette', 'Meshable', 'Events'], ($, jqm, Backbone, _, Marionette, Meshable, Events) ->									 
	
	
	
	menuModel = Backbone.Model.extend 		
		#initialize: -> 
			#@set
				#trafficlight: Meshable.chooseLight @get('trafficlight')		
		defaults: 				 				
			href: "#"
			image: "img/smico3.png"
			name: "Test" 
			
	menuCollection = Backbone.Collection.extend
		model: menuModel	
	#	url: ->
	#		Meshable.rooturl + "/api/dashboard"
	#	initialize: (dashboards) ->
	#		@fetch()


	menuItem = Backbone.Marionette.ItemView.extend
		initialize: (menuModel) ->
			
			@bindTo @model, "change", @render
			
			
		template: '#menuModel'
		tagName: 'li'
		
		
		
			
		
		


	menuComposite = Backbone.Marionette.CompositeView.extend
		itemView: menuItem
		template: "#menuComposite"
		itemViewContainer: "ul"
		
		
		
		
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
			collectionView.$("#menu-insert").append(itemView.el) 

	
	
	Meshable.vent.on "goto:menu", ->
		
		###window.forge.ajax
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
				dashView = new dashboardsView
					collection: nodeCollection###
			
		menuCollect = new menuCollection [
			new menuModel { 
				href: "#" 
				image: "img/smico3.png"
				name: "My Systems"
				}
			new menuModel {
				href: "#search" 
				image: "img/smico3.png"
				name: "Search"
				}
			new menuModel {
				href: "#" 
				image: "img/smico3.png"
				name: "Add Gateway"
				}
			]
		
		menuCompView = new menuComposite
					collection: menuCollect
				
		menuCompView.render()
		$('#slidemenu').empty();
		$('#slidemenu').append($(menuCompView.el))
		#Meshable.menuRegion.show(menuCompView)
		#$.mobile.activePage.trigger("refresh")
		#Meshable.vent.trigger "goto:dashboard"
		

		

	

	 		
	