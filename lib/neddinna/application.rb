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
        route.execute(request)
      else
        [404, { "Content-Type" => "text/html" },
         ["<h3 style='color:red;font-size:40px;'>\
           Page:#{request.host}#{request.path_info} not found :(</h3>"]]
      end
    end
  end
end
