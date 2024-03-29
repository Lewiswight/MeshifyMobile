// Generated by CoffeeScript 1.3.3
(function() {

  define(['jquery', 'jqm', 'backbone', 'underscore', 'marionette', 'Meshable', 'Events', 'login', 'dashboard', 'search'], function($, jqm, Backbone, _, Marionette, Meshable, Events, login, dashboard, search) {
    var Routing;
    Routing = Backbone.Router.extend({
      routes: {
        "gateway/:macaddress": "gateway",
        "": "home",
        "dashboard": "dashboard",
        "menu": "menu",
        "back": "back",
        "popupPanel": "popupPanel",
        "menu_back_btn": "menu_back_btn",
        "search": "search",
        "gateways": "gateways"
      },
      gateway: function(macaddress) {
        return Meshable.vent.trigger("goto:nodes", macaddress);
      },
      gateways: function() {
        return Meshable.vent.trigger("goto:gateways");
      },
      search: function() {
        return Meshable.vent.trigger("goto:search");
      },
      menu_back_btn: function() {
        return $("#popupPanel").popup("close");
      },
      popupPanel: function() {
        return $("#popupPanel").popup("open");
      },
      back: function() {
        return window.history.back();
      },
      home: function() {
        $.mobile.changePage($('#splash'), {
          changeHash: false,
          transition: 'none',
          showLoadMsg: false
        });
        Meshable.loginRegion.show(login);
        $("#password-input").hide();
        return this.changePage(login, false);
      },
      dashboard: function() {
        return Meshable.vent.trigger("goto:dashboard");
      },
      menu: function() {
        var h;
        $("#popupPanel").on({
          popupbeforeposition: function() {}
        });
        h = $(window).height();
        $("#popupPanel").css("height", h);
        $("#popupPanel").bind({
          popupafterclose: function() {
            return Meshable.vent.trigger("menu:close");
          }
        });
        $("#popupPanel").popup("open");
        $("#menu_back_btn").tap(function() {
          return $("#popupPanel").popup("close");
        });
        return $("#menu_search_btn").tap(function() {
          $("#popupPanel").popup("close");
          return window.setTimeout((function() {
            return Meshable.vent.trigger("open:search");
          }), 600);
        });
      },
      changePage: function(page, direction) {
        var trans;
        $(page.el).attr("data-role", "page");
        $(page.el).attr("data-theme", "a");
        trans = "slide";
        if (this.firstPage) {
          trans = "none";
          this.firstPage = false;
        }
        return $.mobile.changePage($(page.el), {
          changeHash: true,
          reverse: direction,
          transition: "none"
        });
      },
      initialize: function() {
        this.firstPage = true;
        return this.firstDash = true;
        /*
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
        */

      }
    });
    /*
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
    */

    return Routing;
  });

}).call(this);
