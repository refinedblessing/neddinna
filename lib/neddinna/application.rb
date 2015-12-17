require_relative "router"
module Neddinna
  class Application
    attr_reader :routes
    def initialize
      @routes = Router.new
    end

    def call(env)
      request = Rack::Request.new(env)
      route = @routes.route_for(request)
      if route
        response = route.execute(request)
        return [200, {}, [response]]
      else
        return [404, {}, ["Page not found"]]
      end
    end
  end
end
