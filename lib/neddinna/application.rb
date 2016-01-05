require_relative "routing/router"
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
        return route.execute(request)
      else
        return [404, {},
                ["Page: #{request.host}#{request.path_info} not found"]]
      end
    end
  end
end
