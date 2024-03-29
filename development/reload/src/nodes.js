// Generated by CoffeeScript 1.3.3
(function() {

  define(['jquery', 'jqm', 'backbone', 'underscore', 'marionette', 'Meshable', 'Events'], function($, jqm, Backbone, _, Marionette, Meshable, Events) {
    var changePage, displayResults, make_collection, node, nodeCompView, nodeView, nodes;
    make_collection = function() {
      return window.forge.ajax({
        url: "http://devbuildinglynx.apphb.com/api/dashboard",
        dataType: "json",
        type: "GET",
        error: function(e) {
          return alert(e.content);
        },
        success: function(data) {
          var cModel, model, nodeCollection, _i, _len;
          nodeCollection = new dashboards;
          for (_i = 0, _len = data.length; _i < _len; _i++) {
            model = data[_i];
            cModel = new dashboard;
            nodeCollection.add(cModel.parse(model));
          }
          return nodeCollection;
        }
      });
    };
    node = Backbone.Model.extend({
      initialize: function() {
        return this.set({
          trafficlight: "green"
        });
      },
      defaults: {
        trafficlight: "green"
      }
    });
    nodes = Backbone.Collection.extend({
      model: node
    });
    nodeView = Backbone.Marionette.ItemView.extend({
      initialize: function(node) {
        return this.bindTo(this.model, "change", this.render);
      },
      template: '#nodeitem-template',
      tagName: 'li',
      className: "list_item_node",
      events: {
        "click .node-item": "displayNode"
      },
      displayNode: function() {
        return Meshable.vent.trigger("goto:node", this.model);
      }
    });
    nodeCompView = Backbone.Marionette.CompositeView.extend({
      itemView: nodeView,
      template: "#wrapper_dashboard",
      itemViewContainer: "ul",
      id: "node",
      appendHtml: function(collectionView, itemView) {
        return collectionView.$("#dashboard_insert").append(itemView.el);
      }
    });
    Meshable.vent.on("goto:nodes", function(macaddress) {
      var _this = this;
      return window.forge.ajax({
        url: "http://devbuildinglynx.apphb.com/api/gateway",
        data: {
          macaddress: macaddress
        },
        dataType: "json",
        type: "GET",
        error: function(e) {
          return alert("An error occurred while getting node details... sorry!");
        },
        success: function(data) {
          if (data.isAuthenticated === false) {
            return alert("auth:logout");
          } else if (data.length === 0) {
            return alert("No Results");
          } else {
            return displayResults(data);
          }
        }
      });
    });
    displayResults = function(data) {
      var nodeCoView, nodeCollection, obj, tempNode, _i, _len;
      nodeCollection = new nodes;
      for (_i = 0, _len = data.length; _i < _len; _i++) {
        obj = data[_i];
        tempNode = new node;
        nodeCollection.add(tempNode.parse(obj));
      }
      nodeCoView = new nodeCompView({
        collection: nodeCollection
      });
      Meshable.currentpage = "nodes";
      $.mobile.changePage($('#splash'), {
        changeHash: false,
        transition: 'none',
        showLoadMsg: false
      });
      Meshable.loginRegion.close();
      Meshable.mainRegion.close();
      Meshable.mainRegion.show(nodeCoView);
      return changePage(nodeCoView, false);
    };
    return changePage = function(page, direction) {
      var trans;
      $(page.el).attr("data-role", "page");
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
    };
  });

}).call(this);
