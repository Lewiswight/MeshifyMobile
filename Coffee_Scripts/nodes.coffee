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
				
				
				
		
			
	
	node = Backbone.Model.extend 
		initialize: -> 
				@set
					trafficlight: "green"		
			defaults: 				 				
				trafficlight: "green" 			
				
		
	nodes = Backbone.Collection.extend
		model: node	
	


	nodeView = Backbone.Marionette.ItemView.extend
		initialize: (node) ->
			
			@bindTo @model, "change", @render
			
			
		template: '#nodeitem-template'
		tagName: 'li'
		className: "list_item_node"
		
		
		events:
			"click .node-item": "displayNode"
			
		
		displayNode: ->
			Meshable.vent.trigger "goto:node", @model
			
		


	nodeCompView = Backbone.Marionette.CompositeView.extend
		itemView: nodeView
		template: "#wrapper_dashboard"
		itemViewContainer: "ul"
		id: "node"
		
		
		
		
			
		
		appendHtml: (collectionView, itemView) ->
			collectionView.$("#dashboard_insert").append(itemView.el) 

	
	
	Meshable.vent.on "goto:nodes", (macaddress) ->
		
		
		window.forge.ajax
			url: "http://devbuildinglynx.apphb.com/api/gateway"
			data:  macaddress: macaddress
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
					displayResults data
		
		
	

	
	
					
	displayResults = (data) ->
		
		nodeCollection = new nodes
		for obj in data
			tempNode = new node
			nodeCollection.add tempNode.parse(obj)
		nodeCoView = new nodeCompView
			collection: nodeCollection
	
		
		


			
		Meshable.currentpage = "nodes"
		$.mobile.changePage $('#splash'), changeHash: false,  transition: 'none', showLoadMsg: false  
		Meshable.loginRegion.close()
		Meshable.mainRegion.close()
	
		Meshable.mainRegion.show(nodeCoView)

		#$("#gateway").attr "data-role", "listview"
		#$("#gateway").attr "data-insert", "true" 

	
		changePage nodeCoView, false
					
				
				
				
		
	changePage = (page, direction) ->
			$(page.el).attr "data-role", "page"
			
		
			
			trans = "slide"
			
			if @firstPage
				trans = "none"
				@firstPage = false
			#$.mobile.loading "show",
			#	theme: 'e'
			$.mobile.changePage $(page.el), changeHash: true, reverse: direction, transition: "none"
		
			
	