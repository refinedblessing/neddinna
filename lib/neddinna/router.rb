require_relative "route"
module Neddinna
  class Router
    attr_accessor :routes
    def initialize
      @routes = Hash.new { |hash, key| hash[key] = [] }
    end

    def draw(&block)
      instance_eval(&block)
    end

    def get(path, options = {})
      routes[:get] << [path, parse_to(options[:to])]
    end

    def post(path, options = {})
      routes[:post] << [path, parse_to(options[:to])]
    end

    def put(path, options = {})
      routes[:put] << [path, parse_to(options[:to])]
    end

    def delete(path, options = {})
      routes[:delete] << [path, parse_to(options[:to])]
    end

    def route_for(request)
      path = request.path_info
      method = request.request_method.downcase.to_sym
      route_array = routes[method].detect { |route| path == route.first }
      return Route.new(route_array) if route_array
      nil
    end

    private

    def parse_to(to_string)
      klass, method = to_string.split("#")
      { klass: klass.capitalize, method: method }
    end
  end
end
