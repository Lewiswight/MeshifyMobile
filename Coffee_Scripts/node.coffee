define ['jquery', 'jqm', 'backbone','underscore','marionette', 'Meshable', 'Events'], ($, jqm, Backbone, _, Marionette, Meshable, Events) ->									 
	
	
				
				
				
		
			
	
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
			
			
		template: '#node-template'
		tagName: 'li'
		
			
		events:
			"click #mistBtn": "mist"
			"click #stopBtn": "stop"
			
		
		mist : ->
			mistData = new Array
			localobj = 
				ChannelId: @model.attributes.channels["mc3.r"].ChannelId
				value: "M"
				techName: @model.attributes.channels["mc3.r"].techName
				name: @model.attributes.channels["mc3.r"].name
			mistData[0] = localobj	
			@setChannel mistData
		
		stop : ->
			stopData = new Array
			localobj = 
				ChannelId: @model.attributes.channels["mc3.r"].ChannelId
				value: "S"
				techName: @model.attributes.channels["mc3.r"].techName
				name: @model.attributes.channels["mc3.r"].name
			stopData[0] = localobj	
			@setChannel stopData
		
		
		setChannel: (channels) -> 
			mac = new Array
			mac[0] = Meshable.currentMac
			#add validation
			#find the channels that need to be set 

			window.forge.ajax
				url: Meshable.rooturl + "/api/channel"
				data:  JSON.stringify({macaddresses: [Meshable.currentMac], channelDTO: channels})
				dataType: "json"
				type: "POST"
				error: (e) -> 
					alert "An error occurred while getting node details... sorry!"
				success: (data) =>


	nodeCompView = Backbone.Marionette.CompositeView.extend
		itemView: nodeView
		template: "#wrapper_dashboard"
		itemViewContainer: "ul"
		id: "node"
		
		
		
		
			
		
		appendHtml: (collectionView, itemView) ->
			collectionView.$("#dashboard_insert").append(itemView.el) 

	
	
	Meshable.vent.on "goto:node", (model) ->
		
					
		displayResults model.attributes
		
		
	

	
	
					
	displayResults = (data) ->
		
		nodeCollection = new nodes

		tempNode = new node
		nodeCollection.add tempNode.parse(data)
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
		
			
	