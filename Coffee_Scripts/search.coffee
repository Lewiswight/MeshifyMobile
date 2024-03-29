define ['jquery', 'jqm', 'backbone','underscore','marionette', 'Meshable', 'Events'], ($, jqm, Backbone, _, Marionette, Meshable, Events) ->									 
	
	make_collection = ->
		
		nodeCollection = new collections [
			new search_prop { 
				template: "#search-template" 
				
				}
			new search_prop {
				template: "#search-fileds-template" 
				image_path: "images/cat2.jpg"
				}
			#new search_prop {
				#template: "#search-fileds-template"
				#image_path: "images/cat3.jpg"
				#}
			
			]
		return nodeCollection
	
	search_prop = Backbone.Model.extend 		
		#initialize: ->
		defaults:
			searchInput: ""
		setInput: (msg) ->
			@set
				searchInput: msg
			    
			
			
		
	collections = Backbone.Collection.extend
		model: search_prop	
	


	searchsView = Backbone.Marionette.ItemView.extend
		initialize: (options) ->
			@template = options.model.attributes.template
			
			@bindTo @model, "change", @render
			
			
		#template: '#dashboarditem-template'
		tagName: 'li'
		className: "list_item"
		
		
			
		
		


	searchView = Backbone.Marionette.CompositeView.extend
		itemView: searchsView
		
		itemViewOptions: @model
			
		
		template: "#wrapper_dashboard"
		itemViewContainer: "ul"
		id: "search"
		
		
		
		events: 
			
			"click #search-btn": "update"
			#"click #menu_back_btn": "menu_back"

			
		update: ->
			searchField = $('#search-main').val()
			if searchField.length < 1
				alert "Please Enter Text"
			else
				Meshable.vent.trigger "search:gateways", searchField
				###window.forge.ajax
					url: "http://devbuildinglynx.apphb.com/api/address"
					data: { address: searchField, pagenum: 0 }
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
							for node in data
								
								gateway = Backbone.Model.extend 
									initialize: -> 
											@set
												trafficlight: "green"		
										defaults: 				 				
											trafficlight: "green" 			
											
									
								gateways = Backbone.Collection.extend
									model: gateway	
								
							
							
								gatewayView = Backbone.Marionette.ItemView.extend
									initialize: (gateway) ->
										
										@bindTo @model, "change", @render
										
										
									template: '#gatewayitem-template'
									tagName: 'li'
									className: "list_item"
									id: "gatewayItm"
									
										

							
								gatewayCompView = Backbone.Marionette.CompositeView.extend
									itemView: gatewayView
									template: "#wrapper_search_results"
									itemViewContainer: "ul"
									id: "gateway"
									
										
									
									appendHtml: (collectionView, itemView) ->
										collectionView.$("#results_insert").append(itemView.el) 
							
								
								
								
												
								nodeCollection = new gateways
								for model in data
									cModel = new gateway
									nodeCollection.add cModel.parse(model)
								gateView = new gatewayCompView
									collection: nodeCollection
							
								gateView.render()
								$('#search_insert').empty();
								$('#search_insert').append($(gateView.el))
								$('#results_insert').listview('refresh')
								$('.ui-page-active .ui-listview').listview('refresh')
								$('.ui-page-active :jqmData(role=content)').trigger('create')
								$('#results_insert').trigger('create')
								$('#search_insert').trigger('create')
								$('#search_insert').listview('refresh')###
							
								
							
					
									
								
						
						
						
						
					
						
					
		appendHtml: (collectionView, itemView) ->
			collectionView.$("#dashboard_insert").append(itemView.el) 

	
		
	Meshable.vent.on "goto:search", ->
		
		
	
		search = new searchView
			collection: make_collection()
				
		Meshable.currentpage = "search"
		$.mobile.changePage $('#splash2'), changeHash: false,  transition: 'none', showLoadMsg: false
		Meshable.loginRegion.close()
		Meshable.mainRegion.close()
		Meshable.searchRegion.show(search)
		
		
	
		
		changePage search, false
		
	changePage = (page, direction) ->
			$(page.el).attr "data-role", "page"
			
		
			
			trans = "slide"
			
			if @firstPage
				trans = "none"
				@firstPage = false
			#$.mobile.loading "show",
			#	theme: 'e'
			$.mobile.changePage $(page.el), changeHash: true, reverse: direction, transition: "none"
	
	
		
	
	
	 		
	 		
