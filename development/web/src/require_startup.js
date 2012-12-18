// Generated by CoffeeScript 1.3.3
(function() {

  require(["jquery", 'jqmglobe', 'jqm', "backbone", "underscore", "marionette", "Meshable", "Router", "Events", "login", 'dashboard', 'search', 'animate', 'slide', 'menu', 'gateways', 'nodes', 'node'], function($, jqmglobe, jqm, Backbone, _, Marionette, Meshable, Router, Events, login, dashboard, search, animate, slide, menu, gateways, nodes, node) {
    return $(document).ready(function() {
      Meshable.events = Events;
      Meshable.router = new Router();
      Backbone.history.navigate("", {
        replace: true,
        trigger: true
      });
      return Meshable.start({
        authModel: "login"
      });
    });
  });

}).call(this);
